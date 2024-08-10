import 'package:flutter/material.dart';

extension WidgetExtension on Widget {
  Widget get center => Center(child: this);
  Widget get bottomCenter => Align(
        alignment: Alignment.bottomCenter,
        child: this,
      );
  Widget get topCenter => Align(
        alignment: Alignment.topCenter,
        child: this,
      );

  Widget get bottomRight => Align(
        alignment: Alignment.bottomRight,
        child: this,
      );

  Widget get bottomLeft => Align(
        alignment: Alignment.bottomLeft,
        child: this,
      );

  Widget get intrinsitHeight => IntrinsicHeight(
        child: this,
      );

  Widget paddingSymmetric({required Size size}) {
    return Padding(
      padding:
          EdgeInsets.symmetric(horizontal: size.width, vertical: size.height),
      child: this,
    );
  }

  Widget paddingOnly(
      {double? top, double? bottom, double? left, double? right}) {
    return Padding(
      padding: EdgeInsets.only(
        top: top ?? 0.0,
        bottom: bottom ?? 0.0,
        left: left ?? 0.0,
        right: right ?? 0.0,
      ),
      child: this,
    );
  }

  Widget get gap => Padding(
        padding: const EdgeInsets.all(8),
        child: this,
      );

  Widget flex({
    required int flex,
  }) {
    return Flexible(
      flex: flex,
      child: this,
    );
  }
}
