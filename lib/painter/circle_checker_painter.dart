import 'dart:math';

import 'package:flutter/material.dart';

class CircleCheckerPainter extends CustomPainter {
  final double animationValue;
  CircleCheckerPainter(this.animationValue);
  static const color = Color(0xDFFF0000);
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..shader = const LinearGradient(
        colors: [
          color,
          Color.fromARGB(255, 255, 150, 14),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ).createShader(
        Rect.fromLTWH(
          0,
          0,
          size.width,
          size.height,
        ),
      )
      ..style = PaintingStyle.stroke
      ..strokeWidth = 6 +
          max(
            (1 - (animationValue) * 2) * 30,
            0,
          );

    // 체크
    final checkPaint = Paint()
      ..shader = const LinearGradient(
        colors: [color, Color.fromARGB(255, 255, 150, 14)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height))
      // ..color = color // 체크 색상
      ..style = PaintingStyle.stroke
      ..strokeWidth = 10.0; // 선의 두께

    final startPoint = Offset(
      size.width * 0.23,
      size.height * 0.5,
    );
    final centerPoint = Offset(
      size.width * 0.43,
      size.height * 0.7,
    );

    final endPoint = Offset(
      size.width * 0.75,
      size.height * 0.35,
    );

    final path = Path();
    // ..moveTo(startPoint.dx, startPoint.dy) // 시작점으로 이동
    // ..lineTo(centerPoint.dx, centerPoint.dy) // 시작점에서 중간점까지 선을 그림
    // ..lineTo(endPoint.dx, endPoint.dy); // 중간점에서 끝점까지 선을 그림

    if (animationValue <= 0.5) {
      canvas.drawCircle(
        Offset(
          size.width / 2,
          size.height / 2,
        ),
        1 + min(animationValue * size.width, size.width / 2),
        paint,
      );
    } else {
      canvas.drawCircle(
        Offset(size.width / 2, size.height / 2),
        size.width / 2,
        paint,
      );
    }

    if (animationValue <= 0.75) {
      // canvas.drawPath(path, checkPaint);
      double t = (animationValue - 0.5) / 0.25;
      Offset(
        startPoint.dx + (centerPoint.dx - startPoint.dx) * t,
        startPoint.dy + (centerPoint.dy - startPoint.dy) * t,
      );
      startPoint.dx + (centerPoint.dx - startPoint.dx) * t;
      startPoint.dy + (centerPoint.dy - startPoint.dy) * t;
    } else {
      path.moveTo(startPoint.dx, startPoint.dy);
      path.lineTo(centerPoint.dx, centerPoint.dy);
      double t = (animationValue - 0.75) / 0.25;
      final intermediatePoint = Offset(
        centerPoint.dx + (endPoint.dx - centerPoint.dx) * t,
        centerPoint.dy + (endPoint.dy - centerPoint.dy) * t,
      );
      path.lineTo(intermediatePoint.dx, intermediatePoint.dy);
    }

    // 체크 모양을 그립니다.
    canvas.drawPath(path, checkPaint);
  }

  @override
  bool shouldRepaint(CircleCheckerPainter oldDelegate) {
    return oldDelegate.animationValue != animationValue;
  }
}
