import 'package:flutter/material.dart';
import 'package:interactive_ui/painter/circle_checker_painter.dart';
import 'package:interactive_ui/style/default_layout.dart';

class CircleChecker extends StatefulWidget {
  const CircleChecker({super.key});

  @override
  State<CircleChecker> createState() => _CircleCheckerState();
}

class _CircleCheckerState extends State<CircleChecker>
    with SingleTickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );

    animation = Tween<double>(begin: 0.0, end: 1).animate(controller);

    // controller.repeat(reverse: false);
    controller.forward();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  Widget _bottomNavigationBar() {
    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          backgroundColor: Colors.black,
          icon: Icon(
            Icons.home,
            color: Colors.white,
          ),
          label: "home",
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.search,
            color: Colors.white,
          ),
          label: "search",
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.video_collection_outlined,
            color: Colors.white,
          ),
          label: "video",
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.shopping_basket_outlined,
            color: Colors.white,
          ),
          label: "shopping",
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      backgroundColor: Colors.black,
      body: Center(
        child: AnimatedBuilder(
          animation: animation,
          builder: (context, child) {
            return CustomPaint(
              painter: CircleCheckerPainter(animation.value),
              size: const Size(180, 180),
            );
          },
        ),
      ),
      bottomNavigationBar: _bottomNavigationBar(),
    );
  }
}
