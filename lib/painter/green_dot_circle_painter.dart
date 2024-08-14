import 'dart:math';

import 'package:flutter/material.dart';
import 'package:interactive_ui/style/custom_color.dart';

Paint createGreendotCirclePaint(
    double width, double height, double animationValue) {
  return Paint()
    ..shader = const LinearGradient(
      colors: [
        CustomColor.greendotGreen,
        CustomColor.greendotMint,
        CustomColor.greendotBlue,
      ],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ).createShader(
      Rect.fromLTWH(
        0,
        0,
        width,
        height,
      ),
    )
    ..style = PaintingStyle.stroke
    // ..strokeWidth = width / 3 +
    //     max(
    //       (1 - (animationValue) * 2) * 30,
    //       0,
    //     );
    ..strokeWidth = width / 3;
}
