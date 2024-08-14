import 'dart:math';

import 'package:flutter/material.dart';
import 'package:interactive_ui/painter/green_dot_circle_painter.dart';

class GreenDotProcessingPainter extends CustomPainter {
  final double animationValue;
  GreenDotProcessingPainter(this.animationValue);
  @override
  void paint(Canvas canvas, Size size) {
    var width = size.width;
    var height = size.height;
    final outterCircle =
        createGreendotCirclePaint(width, height, animationValue);

    canvas.drawCircle(
      Offset(
        size.width / 2,
        size.height / 2,
      ),
      // 1 + min(animationValue * size.width, size.width / 2),
      size.width / 2,
      outterCircle,
    );
  }

  @override
  bool shouldRepaint(GreenDotProcessingPainter oldDelegate) {
    return oldDelegate.animationValue != animationValue;
  }
}
