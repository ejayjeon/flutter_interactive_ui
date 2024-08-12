import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:interactive_ui/extensions/context_extensions.dart';
import 'package:interactive_ui/extensions/widget_extension.dart';
import 'package:interactive_ui/mixins/animation_controller_mixin.dart';
import 'package:interactive_ui/screens/text_scale/custom_scroll_bar.dart';
import 'package:interactive_ui/style/default_layout.dart';

class TextScale extends StatefulWidget {
  const TextScale({super.key});

  @override
  State<TextScale> createState() => _TextScaleState();
}

class _TextScaleState extends State<TextScale> with AnimationControllerMixin {
  double rxFontSize = 14;
  double rxLineHeightSize = 1;
  double paddingHorizontal = 0;
  double paddingVertical = 0;
  double visibleOpacity = 0;
  List<double> visibleOpacities = [
    1,
    1,
    1,
    1,
  ];
  Color drawerCanvasColor = const Color.fromARGB(255, 56, 56, 56);
  Color backgroundColor = const Color.fromARGB(220, 79, 79, 79);
  final drawerKey = GlobalKey<ScaffoldState>();
  // late Tween<double> _tween;
  var iconFont = 'assets/icons/ic_font.svg';
  var iconLineHeight = 'assets/icons/ic_line_height.svg';
  var iconHeight = 'assets/icons/ic_height.svg';
  var iconWidth = 'assets/icons/ic_width.svg';

  @override
  void initState() {
    super.initState();
    // _tween = Tween<double>(begin: 0, end: 0);

    // animationController.addListener(() {
    //   setState(() {
    //     rxFontSize = _tween.evaluate(animationController);
    //   });
    // });
  }

  Drawer _drawer({
    required BuildContext context,
    required Color backgroundColor,
  }) {
    return Drawer(
      backgroundColor: backgroundColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AnimatedOpacity(
            opacity: visibleOpacities[0],
            duration: const Duration(milliseconds: 500),
            child: CustomScrollBar(
              min: 8,
              max: 64,
              step: 2,
              value: rxFontSize,
              backgroundColor: backgroundColor,
              onChanged: (value) {
                setState(() {
                  rxFontSize = value;
                  drawerCanvasColor = Colors.transparent;
                  visibleOpacities[1] = 0;
                  visibleOpacities[2] = 0;
                  visibleOpacities[3] = 0;
                });
              },
              onHorizontalDragEnd: _onHorizontalDragEnd,
              iconPath: iconFont,
              title: "글자 크기",
            ),
          ),
          const SizedBox(
            height: 24,
          ),
          AnimatedOpacity(
            opacity: visibleOpacities[1],
            duration: const Duration(milliseconds: 500),
            child: CustomScrollBar(
              min: 0.0,
              max: 3.0,
              step: 0.1,
              value: rxLineHeightSize,
              backgroundColor: backgroundColor,
              onChanged: (value) {
                setState(() {
                  rxLineHeightSize = value;
                  drawerCanvasColor = Colors.transparent;
                  visibleOpacities[0] = 0;
                  visibleOpacities[2] = 0;
                  visibleOpacities[3] = 0;
                });
              },
              onHorizontalDragEnd: _onHorizontalDragEnd,
              iconPath: iconLineHeight,
              title: "줄 간격",
              needDecimal: true,
            ),
          ),
          const SizedBox(
            height: 24,
          ),
          AnimatedOpacity(
            opacity: visibleOpacities[2],
            duration: const Duration(milliseconds: 500),
            child: CustomScrollBar(
              min: 0,
              max: context.width / 3,
              step: 10,
              value: paddingHorizontal,
              backgroundColor: backgroundColor,
              onChanged: (value) {
                setState(() {
                  paddingHorizontal = value;
                  drawerCanvasColor = Colors.transparent;
                  visibleOpacities[0] = 0;
                  visibleOpacities[1] = 0;
                  visibleOpacities[3] = 0;
                });
              },
              onHorizontalDragEnd: _onHorizontalDragEnd,
              iconPath: iconWidth,
              title: "좌우 여백",
            ),
          ),
          const SizedBox(
            height: 24,
          ),
          AnimatedOpacity(
            opacity: visibleOpacities[3],
            duration: const Duration(milliseconds: 500),
            child: CustomScrollBar(
              min: 0,
              max: context.height / 3,
              step: 10,
              value: paddingVertical,
              backgroundColor: backgroundColor,
              onChanged: (value) {
                setState(() {
                  paddingVertical = value;
                  drawerCanvasColor = Colors.transparent;
                  visibleOpacities[0] = 0;
                  visibleOpacities[1] = 0;
                  visibleOpacities[2] = 0;
                });
              },
              onHorizontalDragEnd: _onHorizontalDragEnd,
              iconPath: iconHeight,
              title: "문단 여백",
            ),
          ),
        ],
      ),
    );
  }

  void _onHorizontalDragEnd(DragEndDetails details) {
    setState(() {
      drawerCanvasColor = const Color(0xFF383838);
      visibleOpacities = [1, 1, 1, 1];

      // 현재 rxFontSize와 목적지 값 사이의 애니메이션 설정
      // _tween.begin = rxFontSize;
      // _tween.end = rxFontSize.clamp(8.0, 64.0);

      /// 최소 폰트 크키 ~ 최대 폰트 크기

      // animationController.reset();
      // animationController.forward();
    });
  }

  /// assets/data 에서 파일 불러오기
  Future<Map<String, dynamic>> loadData() async {
    String jsonString = await rootBundle.loadString('assets/data/ipsum.json');

    final jsonData = jsonDecode(jsonString);
    return Future.value(jsonData);
  }

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
        scaffoldKey: drawerKey,
        backgroundColor: Colors.black,
        body: FutureBuilder(
          future: loadData(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) return const CircularProgressIndicator();
            final datas = snapshot.data?['data'];

            return SizedBox(
              height: context.height,
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    ...List.generate(
                      datas.length,
                      (int index) => _ipsum(
                        text: datas[index].toString(),
                        style: TextStyle(
                          fontSize: rxFontSize,
                          color: Colors.white,
                          height: rxLineHeightSize,
                        ),
                      ).paddingSymmetric(
                        size: Size(
                          paddingHorizontal,
                          paddingVertical,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
        endDrawer: _drawer(
          context: context,
          backgroundColor: drawerCanvasColor,
        ));
  }

  Widget _ipsum({
    required String text,
    required TextStyle style,
  }) {
    return Text(
      text,
      style: style,
    );
  }
}
