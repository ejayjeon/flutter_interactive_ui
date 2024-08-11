# Flutter Interactive UI example


## 1. Instagram Circle Checker

<img src="assets/images/video_1.gif" width="200">

- `CustomPainter` + `animatedBuilder` 사용
- `animationValue`(double)를 구간별로 나눔. 0 ~ 0.5 사이로는 원을 그리고, 0.5 이후로는 체크를 그리도록 설정

```dart

// circle_checker_painter.dart

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
    canvas.drawPath(path, checkPaint);
```

- Duration을 달리주거나, `animationValue`를 어떻게 구간별로 나눠서 그려주느냐에 따라 체크가 다르게 보인다. -> 이 부분은 이것저것 변경해 보면서 UI에 가장 적절한 모션을 찾아가야할 듯 하다.



[참고 | locked님 velog](https://velog.io/@locked/Flutter-3%EC%9D%BC-%EC%A7%80%EB%82%9C-%EC%9D%B8%EC%8A%A4%ED%83%80-%ED%94%BC%EB%93%9C)


<br>

## 2. Bouncing Credit card
<div>
<img src="assets/images/video_2.gif" width="200" alt="Bouncing credit card gif">
<img src="assets/images/image_1.png" width="200" alt="Bouncing credit card image">
<img src="assets/images/image_2.png" width="200" alt="Bouncing credit card image">
</div>


(gif라 화질이 구리고.. 전환 속도도 느리다. 
실제로는 `milliseconds: 1000` 이라 저것보다는 빠르다.)

- `animation`의 변하는 값을 이용해, 광원효과와 함께 카드를 비트는 효과를 `Matrix4`로 주었다.
- Gradient의 Alignment에 `animation.value` 값을 사용한다. Alignment는 -1.0부터 1.0까지의 값을 가진다. 면의 중앙(`Alignment.center`)을 기준으로 위치를 정한다. Offset 좌표계로 Alignment를 정한다면, x 좌표의 위치와 y 좌표의 위치를 각각 -1.0 ~ 1.0 의 값으로 변환을 해주어야 한다.

```dart
// bouncing_card.dart
// 여기서는 animation.value를 직접 사용해서, offset을 사용하지 않음
Alignment(
 (offset.dx / MediaQuery.of(context).size.width) * 2 - 1,
 (offset.dy / MediaQuery.of(context).size.height) * 2 - 1,
),
```

<br>

- Offset 좌표값의 변화를 `animation.value`로 컨트롤하는 방법을 알게 되었다. 
- `canvas`로 이미지를 그리는 거에 비해 특별히 어렵거나 복잡하진 않다. 다만 더 자연스럽고 부드러운 광원효과나 Hover 효과를 구현하기 위해서는 3D 변환에 주로 쓰이는 `Matrix4` 를 연구해 볼 필요가 있을 것 같다.


[참고 | locked님 velog](https://velog.io/@locked/Flutter-%EA%B7%B8%EB%9D%BC%EB%8D%B0%EC%9D%B4%EC%85%98%EC%9C%BC%EB%A1%9C-%EB%A7%8C%EB%93%A4%EC%96%B4%EB%B3%B4%EB%8A%94-%EA%B4%91%EC%9B%90-%ED%9A%A8%EA%B3%BC)


<br>

## 3. Viewer Setting (1) : 글자 크기, 줄 간격, 좌우 여백, 문단 여백

<img src="assets/images/video_3.gif" width="200" alt="Viewer Setting gif">
<img src="assets/images/image_3.png" width="200" alt="Viewer Setting image">
<img src="assets/images/image_4.png" width="200" alt="Viewer Setting image">



- e-book 뷰어에 있는 간단하지만 유저를 위한 편의 기능인 뷰어 보기 설정을 만들어 보았다
- 항상 참고하는 [looked님 블로그](https://velog.io/@locked/Flutter-%EB%B0%80%EB%A6%AC%EC%9D%98-%EC%84%9C%EC%9E%AC-%EB%94%B0%EB%9D%BC%ED%95%98%EA%B8%B0) 의 drawer floating 기능 부분에서 자연스러운 애니메이션 적용을 하는 것이 관건인데, 이 부분은 다음 파트에서 추가할 예정이다.
- `GestureDetector`의 `onHorizontalUpdate` 파라미터로 반환받는 `details` 값을 활용한다면 터치나 드래그로 인한 변화를 다룰 때 유용하다. 

(1) 상대적인 drag 기준(`details.delta.dx`): 드래그 변화량을 처리하고 싶을 때

(2) 해당 영역의 절대적 영역 기준(`details.localPosition.dx`): 터치가 발생한 위치를 위젯 기준으로 처리하고 싶을 때

(3) 디바이스의 절대 영역 기준(`details.globalPosition.dx`): 터치가 발생한 위치를 화면 전체 기준으로 처리하고 싶을 때

- 컴포넌트 구성은 `localPosition`을 기준으로 `dragValue`를 구하고, 각각 몇 `min`, `max`, `step`을 설정해주었다.
  
```dart
// custom_scroll_bar.dart

  return GestureDetector(
      onHorizontalDragUpdate: (DragUpdateDetails details) {
        setState(() {
          double dragValue = details.localPosition.dx;
          _scrollValue = calculateSize(
            dragValue: dragValue,
            min: widget.min,
            max: widget.max,
            step: widget.step,
          );
          if (widget.onChanged != null) {
            // 외부에서 받아서 처리
            widget.onChanged!(_scrollValue);
          }
        });
      },
      ...
  )
```
```dart
// custom_scroll_bar.dart
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
```

[참고 | locked님 velog](https://velog.io/@locked/Flutter-%EB%B0%80%EB%A6%AC%EC%9D%98-%EC%84%9C%EC%9E%AC-%EB%94%B0%EB%9D%BC%ED%95%98%EA%B8%B0)