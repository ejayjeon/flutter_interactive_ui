import 'dart:async';

import 'package:flutter/material.dart';
import 'package:interactive_ui/extensions/widget_extension.dart';
import 'dart:math';

import 'package:interactive_ui/screens/rolling_dice.dart/cube.dart';
import 'package:interactive_ui/style/default_layout.dart';

class RollingDice extends StatefulWidget {
  const RollingDice({
    super.key,
  });
  @override
  RollingDiceState createState() => RollingDiceState();
}

class RollingDiceState extends State<RollingDice>
    with TickerProviderStateMixin {
  late Animation<double> animation;
  late Animation<double> animationY;
  late AnimationController animationController;

  final List<Widget> _list = <Widget>[];
  final double _size = 140.0;

  double _x = pi * 0.25, _y = pi * 0.25;
  Timer? _timer;

  int get size => _list.length;

  @override
  void initState() {
    super.initState();
    initAmination();
  }

  void initAmination() {
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    );
    // double endX = pi * 2;
    // double endY = Random().nextDouble() * pi * 3;
    animation = Tween<double>(begin: 0.0, end: pi * 2).animate(
      CurvedAnimation(
        parent: animationController,
        curve: Curves.easeInOut,
      ),
    );
    animationY = Tween<double>(begin: 0.0, end: pi * 2).animate(
      CurvedAnimation(
        parent: animationController,
        curve: Curves.easeInOut,
      ),
    );

    animationController.addListener(() {
      setState(() {
        _x = animation.value;
        _y = animationY.value;
      });
    });

    animationController.addStatusListener((AnimationStatus status) {
      if (status == AnimationStatus.completed) {
        animationController.reverse();
      } else if (status == AnimationStatus.dismissed) {
        animationController.forward();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      body: Stack(
        children: <Widget>[
          ElevatedButton(
                  onPressed: () => startAnimation(), child: Text("RUN DICE"))
              .bottomCenter,
          LayoutBuilder(
            builder: (_, BoxConstraints c) => Stack(
              children: _list.map((Widget w) {
                final double _i = map(size - _list.indexOf(w), 0, 150);

                return Positioned(
                  top: (c.maxHeight / 2 - _size / 2) + _i * c.maxHeight * 0.9,
                  left: (c.maxWidth / 2 - _size / 2) - _i * c.maxWidth * 0.9,
                  child: Transform.scale(
                    scale: _i * 1.5 + 1.0,
                    child: w,
                  ),
                );
              }).toList(),
            ),
          ),

          // Cube
          GestureDetector(
            onTap: startAnimation,
            onPanUpdate: (DragUpdateDetails u) => setState(() {
              _x = (_x + -u.delta.dy / 150) % (pi * 2);
              _y = (_y + -u.delta.dx / 150) % (pi * 2);
            }),
            child: Container(
              color: Colors.transparent,
              child: Cube(
                // color: Colors.grey.shade200,
                x: _x,
                y: _y,
                size: _size,
                colorPairs: const {
                  1: Colors.red,
                  2: Colors.pink,
                  3: Colors.yellow,
                  4: Colors.green,
                  5: Colors.blue,
                  6: Colors.purple,
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    animationController.dispose();
    super.dispose();
  }

  // void _start() {
  //   if (_timer?.isActive ?? false) {
  //     return;
  //   }

  //   _timer = Timer.periodic(const Duration(milliseconds: 48), (_) => _add());
  // }

  void startAnimation() {
    if (animationController.isAnimating) {
      animationController.stop();
    } else {
      animationController.repeat();
    }
  }

  double map(
    num value, [
    num iStart = 0,
    num iEnd = pi * 2,
    num oStart = 0,
    num oEnd = 1.0,
  ]) =>
      ((oEnd - oStart) / (iEnd - iStart)) * (value - iStart) + oStart;

  // void _add() {
  //   if (size > 150) {
  //     _list.removeRange(
  //       0,
  //       Colors.accents.length * 4,
  //     ); // Expensive, remove more at once
  //   }

  //   setState(
  //     () => _list.add(
  //       Cube(
  //         x: _x,
  //         y: _y,
  //         colorPairs: {},
  //         rainbow: true,
  //         size: _size,
  //       ),
  //     ),
  //   );
  // }
}
