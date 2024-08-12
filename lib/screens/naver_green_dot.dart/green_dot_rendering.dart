import 'package:flutter/material.dart';
import 'package:interactive_ui/mixins/animation_controller_mixin.dart';
import 'package:interactive_ui/painter/green_dot_painter.dart';
import 'package:interactive_ui/style/default_layout.dart';

class GreenDotRendering extends StatefulWidget {
  const GreenDotRendering({super.key});

  @override
  State<GreenDotRendering> createState() => _GreenDotRenderingState();
}

class _GreenDotRenderingState extends State<GreenDotRendering>
    with AnimationControllerMixin {
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
      body: Center(
        child: AnimatedBuilder(
          animation: animation,
          builder: (context, child) {
            return CustomPaint(
              painter: GreenDotPainter(animation.value),
              size: const Size(180, 180),
            );
          },
        ),
      ),
    );
  }
}
