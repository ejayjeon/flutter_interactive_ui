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

