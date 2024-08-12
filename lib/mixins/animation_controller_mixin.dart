import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

mixin AnimationControllerMixin<T extends StatefulWidget> on State<T>
    implements TickerProvider {
  late AnimationController _animationController;
  late Animation<double> animation;
  int? duration;
  Widget? animationChild;
  Ticker? _ticker;

  late TickerProvider _tickerProvider;

  AnimationController get animationController => _animationController;

  /// Override 해서 사용하면 됨
  void initAmination() {
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: duration ?? 0),
    );

    // _animationController.repeat();
  }

  @override
  void initState() {
    super.initState();
    initAmination();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return animationChild!;
  }

  @override
  Ticker createTicker(TickerCallback onTick) {
    // No need for the assert here since TickerProviderStateMixin handles multiple tickers
    return Ticker(onTick,
        debugLabel: kDebugMode ? 'created by ${describeIdentity(this)}' : null);
  }

  String describeIdentity(Object? object) =>
      '${objectRuntimeType(object, '<optimized out>')}#${shortHash(object)}';

  String shortHash(Object? object) {
    return object.hashCode.toUnsigned(20).toRadixString(16).padLeft(5, '0');
  }
}
