import 'dart:math';

import 'package:flutter/material.dart';
import 'package:interactive_ui/painter/green_dot_circle_painter.dart';
import 'package:interactive_ui/style/custom_color.dart';

class GreenDotAnsweringPainter extends CustomPainter {
  final double animationValue;
  GreenDotAnsweringPainter(this.animationValue);

  @override
  void paint(Canvas canvas, Size size) {
    var width = size.width;
    var height = size.height;
    // final outterCircle = Paint()
    //   ..shader = const LinearGradient(
    //     colors: [
    //       CustomColor.greendotGreen,
    //       CustomColor.greendotMint,
    //       CustomColor.greendotBlue,
    //     ],
    //     begin: Alignment.topLeft,
    //     end: Alignment.bottomRight,
    //   ).createShader(
    //     Rect.fromLTWH(
    //       0,
    //       0,
    //       width,
    //       height,
    //     ),
    //   )
    //   ..style = PaintingStyle.stroke
    //   ..strokeWidth = width / 3 +
    //       max(
    //         (1 - (animationValue) * 2) * 30,
    //         0,
    //       );

    final outterCircle =
        createGreendotCirclePaint(width, height, animationValue);
    final shadowCircle = Paint()
      ..shader = RadialGradient(
        colors: [
          CustomColor.greendotGreen.withOpacity(0.3),
          CustomColor.greendotMint.withOpacity(0.3),
          CustomColor.greendotBlue.withOpacity(0.3),
        ],
        // begin: Alignment.topLeft,
        // end: Alignment.bottomRight,
        stops: [0, 0.3, 0.7],
      ).createShader(
        Rect.fromLTWH(
          0,
          0,
          width,
          height,
        ),
      )
      ..style = PaintingStyle.fill;

    final shadowCircle2 = Paint()
      ..shader = RadialGradient(
        colors: [
          CustomColor.greendotGreen.withOpacity(0.4),
          CustomColor.greendotMint.withOpacity(0.4),
          CustomColor.greendotBlue.withOpacity(0.4),
        ],
        // begin: Alignment.topLeft,
        // end: Alignment.bottomRight,
        stops: [0, 0.3, 0.7],
      ).createShader(
        Rect.fromLTWH(
          0,
          0,
          width,
          height,
        ),
      )
      ..style = PaintingStyle.fill;

    if (animationValue <= 0.5) {
      canvas.drawCircle(
        Offset(
          size.width / 2,
          size.height / 2,
        ),
        1 + min(animationValue * size.width, size.width / 2),
        outterCircle,
      );
      double waveEffect = sin(animationValue * 2 * pi * 6) * 10;
      double shadowRadius = width + waveEffect;
      canvas.drawCircle(
        Offset(
          size.width / 2,
          size.height / 2,
        ),
        shadowRadius,
        shadowCircle,
      );

      canvas.drawCircle(
        Offset(
          size.width / 2,
          size.height / 2,
        ),
        // 1 + min(animationValue * size.width, size.width / 2),

        shadowRadius / 1.3,
        shadowCircle2,
      );
    } else {
      canvas.drawCircle(
        Offset(width / 2, height / 2),
        width / 2,
        outterCircle,
      );
    }
  }

  @override
  bool shouldRepaint(GreenDotAnsweringPainter oldDelegate) {
    return oldDelegate.animationValue != animationValue;
  }
}
