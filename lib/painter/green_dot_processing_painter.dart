import 'dart:math';

import 'package:flutter/material.dart';
import 'package:interactive_ui/painter/green_dot_circle_painter.dart';
import 'package:interactive_ui/style/custom_color.dart';

class GreenDotProcessingPainter extends CustomPainter {
  final double animationValue;
  GreenDotProcessingPainter(this.animationValue);
  @override
  void paint(Canvas canvas, Size size) {
    var width = size.width;
    var height = size.height;
    double radius = width / 2;

    final outterCircle =
        createGreendotCirclePaint(width, height, animationValue);

    canvas.drawCircle(
      Offset(
        size.width / 2,
        size.height / 2,
      ),
      // 1 + min(animationValue * size.width, size.width / 2),
      // size.width / 2,
      radius,
      outterCircle,
    );

    final shadowPaint =
        createGreendotCirclePaint(width, height, animationValue, [
      CustomColor.greendotGreen.withOpacity(0.3),
      CustomColor.greendotMint.withOpacity(0.3),
      CustomColor.greendotBlue.withOpacity(0.3),
    ]);

    canvas.drawCircle(
      Offset(width / 2 + 10, height / 2),
      radius,
      shadowPaint,
    );
  }

  @override
  bool shouldRepaint(GreenDotProcessingPainter oldDelegate) {
    return oldDelegate.animationValue != animationValue;
  }
}
