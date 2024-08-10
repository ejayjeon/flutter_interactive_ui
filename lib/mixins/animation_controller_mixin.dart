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
    assert(() {
      if (_ticker == null) {
        return true;
      }
      throw FlutterError.fromParts(<DiagnosticsNode>[
        ErrorSummary(
            '$runtimeType is a SingleTickerProviderStateMixin but multiple tickers were created.'),
        ErrorDescription(
            'A SingleTickerProviderStateMixin can only be used as a TickerProvider once.'),
        ErrorHint(
          'If a State is used for multiple AnimationController objects, or if it is passed to other '
          'objects and those objects might use it more than one time in total, then instead of '
          'mixing in a SingleTickerProviderStateMixin, use a regular TickerProviderStateMixin.',
        ),
      ]);
    }());
    _ticker = Ticker(onTick,
        debugLabel: kDebugMode ? 'created by ${describeIdentity(this)}' : null);
    return _ticker!;
  }

  String describeIdentity(Object? object) =>
      '${objectRuntimeType(object, '<optimized out>')}#${shortHash(object)}';

  String shortHash(Object? object) {
    return object.hashCode.toUnsigned(20).toRadixString(16).padLeft(5, '0');
  }
}
