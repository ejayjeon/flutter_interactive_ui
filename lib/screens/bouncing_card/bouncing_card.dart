import 'package:flutter/material.dart';
import 'package:interactive_ui/extensions/widget_extension.dart';
import 'package:interactive_ui/mixins/animation_controller_mixin.dart';
import 'package:interactive_ui/screens/bouncing_card/card_widget.dart';
import 'package:interactive_ui/style/default_layout.dart';
import 'dart:math' as math;

class BouncingCard extends StatefulWidget {
  const BouncingCard({super.key});

  @override
  State<BouncingCard> createState() => _BouncingCardState();
}

class _BouncingCardState extends State<BouncingCard>
    with AnimationControllerMixin {
  Offset offset = Offset.zero;
  @override
  int? get duration => 1000;

  @override
  initAmination() {
    super.initAmination();
    // animation = Tween<double>(begin: 0.0, end: -math.pi / 12).animate(
    //   CurvedAnimation(
    //     parent: animationController,
    //     curve: Curves.easeInOut,
    //   ),
    // );
    animation = Tween<double>(begin: -1.0, end: 1.0).animate(
      animationController,
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      backgroundColor: Colors.black,
      body: AnimatedBuilder(
        animation: animation,
        builder: (context, child) {
          // 원의 반지름(-(180/12))의 -15도,
          // 즉 반시계 방향으로 15도 회전하는 변환
          final angle = (-math.pi / 12) * animation.value;
          final transform = Matrix4.identity()
            ..setEntry(3, 2, 0.001)
            ..rotateY(angle);
          final animatedAlignment = Alignment(
            animation.value * 0.8,
            animation.value * 0.2,
          );

          return GestureDetector(
            onTapDown: (details) {
              setState(() {
                // print(details.localPosition);
                offset = details.localPosition;
                animationController.forward();
              });
            },
            onTapUp: (details) => animationController.reverse(),
            onTapCancel: () => animationController.reverse(),
            child: Transform(
              transform: transform,
              alignment: Alignment.center,
              child: Transform.rotate(
                // angle: (animation.value * math.pi) / 36.0,
                // angle: -math.pi,
                angle: -0.1,
                origin: const Offset(0.0, 0.0),
                child: CardWidget(
                  //   // Alignment는 -1.0에서 1.0까지의 값을 가지며, 면의 중앙을 기준으로 위치를 지정합니다. Offset은 화면의 좌표계를 기준으로 위치를 나타내므로, 이를 Alignment로 변환
                  // alignment: Alignment(
                  //   (offset.dx / MediaQuery.of(context).size.width) * 2 - 1,
                  //   (offset.dy / MediaQuery.of(context).size.height) * 2 - 1,
                  // ),
                  alignment: animatedAlignment,
                ),
              ).center,
            ),
          );
        },
      ),
    );
  }
}
