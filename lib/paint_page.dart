import 'dart:ui';
import 'dart:math';
import 'package:flutter/material.dart';

class Cake extends StatefulWidget {
  @override
  _CakeState createState() => _CakeState();
}

class _CakeState extends State<Cake> {
  double _top = 0;
  double _left = 0;
  final Size _cakeSize = Size(200, 200);
  GlobalKey _keyStack = GlobalKey();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback(_afterLayout);
    super.initState();
  }

  _getPositions() {
    final RenderBox renderBoxStack = _keyStack.currentContext.findRenderObject();
    final positionStack = renderBoxStack.localToGlobal(Offset.zero);
    print("POSITION of Stack: $positionStack ");
  }

  _getSizes() {
    final RenderBox renderBoxStack = _keyStack.currentContext.findRenderObject();
    final sizeStack = renderBoxStack.size;
    setState(() {
      _top = sizeStack.height / 2 - _cakeSize.height / 2;
      _left = sizeStack.width / 2 - _cakeSize.width / 2;
    });
    print("SIZE of Stack: $sizeStack");
  }

  _afterLayout(_) {
    _getSizes();
    _getPositions();
  }

  @override
  Widget build(BuildContext context) {       
    return Stack(
      key: _keyStack,
      children: [
        Positioned(
            top: _top,
            left: _left,
            child: GestureDetector(
              child: Center(
                child: CustomPaint(
                  size: _cakeSize,
                  painter: WheelPainter(),
                ),
              ),
              onTap: () => print('Tap'),
              onDoubleTap: () => print('Double Tap'),
              onLongPress: () => print('Long Press'),
              onPanUpdate: (e) {
                setState(() {
                  _left += e.delta.dx;
                  _top += e.delta.dy;
                });
              },
            ))
      ],
    );
  }
}

class WheelPainter extends CustomPainter {
  //设置画笔颜色
  Paint getColoredPaint(Color color) {
    Paint paint = Paint();
    paint.color = color;
    return paint;
  }

  @override
  void paint(Canvas canvas, Size size) {
    //饼图尺寸
    double wheelSize = min(size.width, size.height) / 2;
    double nbElem = 6;
    double radius = (2 * pi) / nbElem;
    Rect boundingRect = Rect.fromCircle(
        center: Offset(wheelSize, wheelSize), radius: wheelSize);

    //画圆弧，每次1/6个圆弧
    canvas.drawArc(
        boundingRect, 0, radius, true, getColoredPaint(Colors.orange));
    canvas.drawArc(
        boundingRect, radius, radius, true, getColoredPaint(Colors.black38));
    canvas.drawArc(
        boundingRect, radius * 2, radius, true, getColoredPaint(Colors.green));
    canvas.drawArc(
        boundingRect, radius * 3, radius, true, getColoredPaint(Colors.red));
    canvas.drawArc(
        boundingRect, radius * 4, radius, true, getColoredPaint(Colors.blue));
    canvas.drawArc(
        boundingRect, radius * 5, radius, true, getColoredPaint(Colors.pink));
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => oldDelegate != this;
}
