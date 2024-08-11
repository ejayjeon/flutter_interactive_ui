import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:interactive_ui/extensions/widget_extension.dart';

class CustomScrollBar extends StatefulWidget {
  final double min;
  final double max;
  final num step;
  final double value;
  final double width;
  final double height;
  final Color backgroundColor;
  final bool needDecimal;
  final void Function(DragEndDetails)? onHorizontalDragEnd;
  final ValueChanged<double>? onChanged;
  final String iconPath;
  final String title;
  const CustomScrollBar({
    super.key,
    required this.min,
    required this.max,
    required this.value,
    this.onHorizontalDragEnd,
    this.onChanged,
    this.width = 200.0,
    this.height = 50.0,
    this.step = 10,
    this.backgroundColor = Colors.grey,
    required this.iconPath,

    /// 보여주는 부분에 소수점 표기가 필요하다면 true로 변경
    this.needDecimal = false,

    /// 해당 컴포넌트의 타이틀 ex) 글자 크기, 행간 너비
    this.title = "",
  });

  @override
  State<CustomScrollBar> createState() => _CustomScrollBarState();
}

class _CustomScrollBarState extends State<CustomScrollBar> {
  // 스크롤 영역 변수
  late double _scrollValue;

  // calculateSize
  double calculateSize({
    required double dragValue,
    required num step,
    required double min,
    required double max,
  }) {
    /// 몇 단계로 구성할 것인지 dragStep: 1 ~ 10단계로 구성
    int dragStep = (dragValue / 10).round();

    /// dragStep을 몇 스텝마다 나눌 것인지 설정 ex) 0.1 step -> 0.1, 0.2, 0.3 ...
    double size = dragStep * step.toDouble();

    if (size < min) size = min;
    if (size > max) size = max;
    return size;
  }

  @override
  void initState() {
    super.initState();
    _scrollValue = widget.value;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onHorizontalDragUpdate: (DragUpdateDetails details) {
        setState(() {
          // 이전 스크롤에 비해 delta.dx 만큼 움직임

          double dragValue = details.localPosition.dx;

          _scrollValue = calculateSize(
            dragValue: dragValue,
            min: widget.min,
            max: widget.max,
            step: widget.step,
          );

          if (widget.onChanged != null) {
            widget.onChanged!(_scrollValue);
          }
        });
      },
      onHorizontalDragEnd: widget.onHorizontalDragEnd,
      child: LayoutBuilder(
        builder: (context, constraints) => Container(
          constraints: constraints,
          width: constraints.maxWidth,
          decoration: BoxDecoration(
            color: widget.backgroundColor,
            borderRadius: BorderRadius.circular(4),
          ),
          child: Stack(
            children: [
              Positioned(
                left: 0,
                bottom: 0,
                top: 0,
                child: SvgPicture.asset(
                  widget.iconPath,
                  width: 24,
                  colorFilter:
                      const ColorFilter.mode(Colors.white, BlendMode.srcIn),
                ),
              ),
              Positioned(
                left: 30,
                bottom: 0,
                top: 0,
                child: Text(
                  widget.title,
                  style: const TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ).center,
              ),
              Positioned(
                child: Container(
                  width: constraints.maxWidth * (_scrollValue / widget.max),
                  height: widget.height,
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
              Positioned(
                right: 0,
                bottom: 0,
                top: 0,
                child: Text(
                  widget.needDecimal
                      ? _scrollValue.toStringAsFixed(1)
                      : _scrollValue.toStringAsFixed(0),
                  style: const TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ).center.paddingSymmetric(size: const Size(4, 0)),
              ),
            ],
          ),
        ),
      ),
    ).paddingSymmetric(
      size: const Size(8, 0),
    );
  }
}
