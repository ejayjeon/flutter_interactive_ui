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