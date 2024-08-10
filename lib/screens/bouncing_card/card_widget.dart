import 'package:flutter/material.dart';
import 'dart:math' as math;

class CardWidget extends StatelessWidget {
  final AlignmentGeometry? alignment;
  final double? radius;
  const CardWidget({
    super.key,
    this.alignment,
    this.radius,
  });

  @override
  Widget build(BuildContext context) {
    double angle = (90 * math.pi) / 180;
    return Container(
      width: MediaQuery.of(context).size.width * 0.6,
      height: MediaQuery.of(context).size.height * 0.43,
      decoration: BoxDecoration(
        gradient: RadialGradient(
          colors: const [
            Color.fromARGB(255, 225, 225, 225),
            Color.fromARGB(255, 174, 174, 174),
            Color.fromARGB(255, 88, 88, 88),
          ],
          radius: radius ?? 1.2,
          center: alignment ?? Alignment.center,
          // stops: <double>[0.0, 0.7, 1.0],
        ),
        borderRadius: const BorderRadius.all(
          Radius.circular(20),
        ),
      ),
      child: Stack(
        children: <Widget>[
          Positioned(
            right: 30,
            top: 30,
            child: Transform.rotate(
              angle: angle,
              child: Image.asset(
                'assets/images/ic.png',
                scale: 8,
              ),
            ),
          ),
          Positioned(
            left: -20,
            bottom: 20,
            child: Transform.rotate(
              angle: angle,
              child: Image.asset(
                'assets/images/master.png',
                scale: 5,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
