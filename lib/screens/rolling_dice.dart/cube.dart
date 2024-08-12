import 'dart:math';
// import 'package:vector_math/vector_math_64.dart' as vector;
import 'package:flutter/material.dart';

class Cube extends StatelessWidget {
  final double x, y, size;
  final bool rainbow;
  final Map<int, Color> colorPairs; // // (1,6), (2,5), (3,4) 각각의 색상을 전달
  const Cube({
    super.key,
    required this.x,
    required this.y,
    required this.size,
    this.rainbow = false,
    required this.colorPairs,
  });

  static const double _shadow = 0.2, _halfPi = pi / 2, _oneHalfPi = pi + pi / 2;

  double get _sum => (y + (x > pi ? pi : 0.0)).abs() % (pi * 2);

  double map(num value,
          [num iStart = 0,
          num iEnd = pi * 2,
          num oStart = 0,
          num oEnd = 1.0]) =>
      ((oEnd - oStart) / (iEnd - iStart)) * (value - iStart) + oStart;

  Widget drawDiceDots(int number) {
    List<Widget> dots = [];

    if ([1, 3, 5].contains(number)) {
      dots.add(_buildDot(Alignment.center)); // 중앙 점
    }
    if ([2, 3, 4, 5, 6].contains(number)) {
      dots.add(_buildDot(Alignment.topLeft)); // 왼쪽 위 점
      dots.add(_buildDot(Alignment.bottomRight)); // 오른쪽 아래 점
    }
    if ([4, 5, 6].contains(number)) {
      dots.add(_buildDot(Alignment.topRight)); // 오른쪽 위 점
      dots.add(_buildDot(Alignment.bottomLeft)); // 왼쪽 아래 점
    }
    if ([6].contains(number)) {
      dots.add(_buildDot(Alignment.centerLeft)); // 왼쪽 중간 점
      dots.add(_buildDot(Alignment.centerRight)); // 오른쪽 중간 점
    }

    return Stack(children: dots);
  }

  // 주사위 점
  Widget _buildDot(Alignment alignment) {
    return Align(
      alignment: alignment,
      child: Container(
        width: 24.0,
        height: 24.0,
        decoration: const BoxDecoration(
          color: Colors.black,
          shape: BoxShape.circle,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bool _topBottom = x < _halfPi || x > _oneHalfPi;
    final bool _northSouth = _sum < _halfPi || _sum > _oneHalfPi;
    final bool _eastWest = _sum < pi;

    int _getFrontSide(double x, double y) {
      // X축이 기본적으로 정면을 결정
      if (x < _halfPi || x > _oneHalfPi) {
        return 1;
      } else {
        return 6;
      }
    }

    int _getRightSide(double x, double y) {
      // Y축이 기본적으로 오른쪽 면을 결정
      if (_sum < _halfPi || _sum > _oneHalfPi) {
        return 2;
      } else {
        return 5;
      }
    }

    int _getTopSide(double x, double y) {
      // Z축이 기본적으로 위쪽 면을 결정
      if (_sum < pi) {
        return 3;
      } else {
        return 4;
      }
    }

    final int frontSide = _getFrontSide(x, y);
    final int rightSide = _getRightSide(x, y);
    final int topSide = _getTopSide(x, y);

    Color getSideColor(int side) {
      // 반대편 면끼리 같은 색상 적용
      return colorPairs[side] ?? Colors.white;
    }

    return Stack(
      children: <Widget>[
        _side(
          zRot: y,
          xRot: -x,
          shadow: _getShadow(x),
          moveZ: _topBottom,
          number: frontSide,
          color: getSideColor(frontSide),
        ),
        _side(
          yRot: y,
          xRot: _halfPi - x,
          shadow: _getShadow(_sum),
          moveZ: _northSouth,
          number: rightSide,
          color: getSideColor(rightSide),
        ),
        _side(
          yRot: -_halfPi + y,
          xRot: _halfPi - x,
          shadow: _shadow - _getShadow(_sum),
          moveZ: _eastWest,
          number: topSide,
          color: getSideColor(topSide),
        ),
      ],
    );
  }

  double _getShadow(double r) {
    if (r < _halfPi) {
      return map(r, 0, _halfPi, 0, _shadow);
    } else if (r > _oneHalfPi) {
      return _shadow - map(r, _oneHalfPi, pi * 2, 0, _shadow);
    } else if (r < pi) {
      return _shadow - map(r, _halfPi, pi, 0, _shadow);
    }

    return map(r, pi, _oneHalfPi, 0, _shadow);
  }

  Widget _side({
    bool moveZ = true,
    double xRot = 0.0,
    double yRot = 0.0,
    double zRot = 0.0,
    double shadow = 0.0,
    required int number,
    required Color color,
  }) {
    return Transform(
      alignment: Alignment.center,
      transform: Matrix4.identity()
        ..rotateX(xRot)
        ..rotateY(yRot)
        ..rotateZ(zRot)
        // ..setEntry(3, 2, 0.001)
        ..translate(0.0, 0.0, moveZ ? -size / 2 : size / 2),
      child: Container(
        alignment: Alignment.center,
        child: Container(
          constraints: BoxConstraints.expand(width: size, height: size),
          color: color,
          padding: const EdgeInsets.all(18),
          foregroundDecoration: BoxDecoration(
            color: Colors.black.withOpacity(rainbow ? 0.0 : shadow),
            border: Border.all(
              width: 0.8,
              color: rainbow ? color.withOpacity(0.3) : Colors.black26,
            ),
          ),
          child: drawDiceDots(number),
        ),
      ),
    );
  }
}
