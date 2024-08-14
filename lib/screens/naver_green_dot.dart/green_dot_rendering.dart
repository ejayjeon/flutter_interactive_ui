import 'package:flutter/material.dart';
import 'package:interactive_ui/mixins/animation_controller_mixin.dart';
import 'package:interactive_ui/painter/green_dot_answering_painter.dart';
import 'package:interactive_ui/painter/green_dot_processing_painter.dart';
import 'package:interactive_ui/style/default_layout.dart';
import 'dart:math';

class GreenDotRendering extends StatefulWidget {
  const GreenDotRendering({super.key});

  @override
  State<GreenDotRendering> createState() => _GreenDotRenderingState();
}

class _GreenDotRenderingState extends State<GreenDotRendering>
    with AnimationControllerMixin {
  final size = const Size(180, 180);

  @override
  void initState() {
    super.initState();
    initAmination();
  }

  @override
  int? get duration => 1000;

  @override
  void initAmination() {
    super.initAmination();
    animation =
        Tween<double>(begin: 0.0, end: 1.0).animate(animationController);

    animationController.repeat();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      backgroundColor: Colors.white,
      body: Center(
        child: AnimatedBuilder(
          animation: animation,
          builder: (context, child) {
            // return CustomPaint(
            //   painter: GreenDotAnsweringPainter(animation.value),
            //   size: const Size(180, 180),
            // );
            final angle = (-pi * 2) * animation.value;
            // Vector3 angle2 =
            final transform = Matrix4.identity()
              // ..applyToVector3Array([0, 0, 0])
              ..setEntry(3, 2, 0.001)
              // ..rotateZ(0)
              ..rotateY(angle);

            return Transform(
              transform: transform,
              origin: size.center(Offset.zero),
              child: CustomPaint(
                painter: GreenDotProcessingPainter(animation.value),
                size: size,
              ),
            );
          },
        ),
      ),
    );
  }
}
