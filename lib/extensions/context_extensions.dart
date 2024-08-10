import 'package:flutter/material.dart';

extension ContextExtension on BuildContext {
  /// 1. [Dialog]
  /// 2. [BottomSheet]
  Future showBottomSheet({
    required Widget child,
    bool isScrollControlled = true,
    bool isDismissible = true,
    Color? backgroundColor,
    Future Function(dynamic)? afterClose,
  }) {
    return showModalBottomSheet(
            context: this,
            isScrollControlled: isScrollControlled, // 전체화면여부
            isDismissible: isDismissible,
            useSafeArea: isScrollControlled,
            backgroundColor: backgroundColor,
            barrierColor: Colors.black.withOpacity(0.3),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              ),
            ),
            builder: (context) => Wrap(children: [child]))
        .then(afterClose ?? (value) => null);
  }

  /// 3. [Snackbar]
  ScaffoldFeatureController<SnackBar, SnackBarClosedReason> showSnackBar(
    String message, {
    Color? backgroundColor,
    int? seconds,
  }) {
    return ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        backgroundColor: backgroundColor,
        elevation: 0,
        content: Text(message),
        behavior: SnackBarBehavior.floating,
        duration: Duration(seconds: seconds ?? 3),
        showCloseIcon: true,
      ),
    );
  }

  void clearSnackBar() {
    ScaffoldMessenger.of(this).clearSnackBars();
  }

  /// 4. [Toast]
  // Future<bool?> showToast({
  //   required String message,
  //   Color? backgroundColor,
  //   ToastGravity? position,
  // }) {
  //   return Fluttertoast.showToast(
  //     msg: message,
  //     backgroundColor: backgroundColor,
  //     toastLength: Toast.LENGTH_SHORT,
  //     gravity: position ?? ToastGravity.BOTTOM,
  //   );
  // }

  /// 5. [Navigation / Route]
  // NavigatorState get route => Navigator.of(this);
  // void get goBack => Navigator.of(this, rootNavigator: true).pop();
  // Uri get currentPath => GoRouter.of(this).routeInformationProvider.value.uri;
  // List get paths => currentPath.pathSegments;

  /// 6. [Width / Height]
  double get width => MediaQuery.of(this).size.width;
  double get height => MediaQuery.of(this).size.height;
  Size get size => MediaQuery.of(this).size;

  /// 7. [Padding / Margin]
  EdgeInsets gap({
    required Size size,
    bool isSymmetric = true,
  }) {
    return EdgeInsets.symmetric(
      horizontal: size.width,
      vertical: size.height,
    );
  }

  /// 8. [Colors]
  Color get primary => Theme.of(this).colorScheme.primary;
  Color get background => Theme.of(this).colorScheme.background;
}
