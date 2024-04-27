import 'dart:math';

import'package:flutter/material.dart';

class BagShapePainter extends CustomPainter {
  double skewTop = 0;
  double skewButtom = 0.2;
  double ratio = 0.85;
   double fullness ; // will be change depending on items
  BagShapePainter({required this.fullness});
  @override
  void paint(Canvas canvas, Size size) {
    Paint glass = Paint()
      ..color =const Color(0xff5c666c).withAlpha(50)
      ..style = PaintingStyle.fill;
    // Paint milkTopPaint = Paint()
    //   ..color = Color(0xff5c666c).withOpacity(0.3)
    //   ..style = PaintingStyle.fill;
    Paint milkColor = Paint()
      ..color = const Color(0xff5c666c).withOpacity(0.5)
      ..style = PaintingStyle.fill;
    Paint black = Paint()
      ..color =const Color(0xff5c666c)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4;
    //!
    Paint paint = Paint()
      ..color =const Color(0xff5c666c)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4;
    // the top and the buttom of the glass :
    Rect top = Rect.fromLTRB(0, 0, size.width, size.width * skewTop);
    // drawing the the top of the glass :

    Rect bottom = Rect.fromCenter(
        center: Offset(size.width * .5,
            size.height - size.width * 0.5 * skewButtom * ratio),
        width: size.width * ratio,
        height: size.width * skewButtom * ratio);

    dynamic liquidTop = Rect.lerp(bottom, top, (fullness/100));
    // to draw the border of the cup from left and right :
    Path cupPath = Path()
      ..moveTo(top.left, top.top + top.height * .5)
      ..arcTo(top, pi, pi, true)
      ..lineTo(bottom.right, bottom.top + bottom.height * 0.5)
      ..arcTo(bottom, 0, pi, true)
      ..lineTo(top.left, top.top + top.height * .5);
    Path liquidPath = Path()
      ..moveTo(liquidTop.left, liquidTop.top + liquidTop.height * .5)
      ..arcTo(liquidTop, pi, pi, true)
      ..lineTo(bottom.right, bottom.top + bottom.height * 0.5)
      ..arcTo(bottom, 0, pi, true)
      ..lineTo(liquidTop.left, liquidTop.top + liquidTop.height * .5);

    canvas.drawOval(top, glass);
    // canvas.drawOval(bottom, glass);
    canvas.drawPath(cupPath, glass);
    canvas.drawPath(liquidPath, milkColor);
    // canvas.drawOval(liquidTop, milkTopPaint);
    canvas.drawPath(cupPath, black);
    canvas.drawOval(top, black);
//!
    final firstRadius = size.width / 4;
    final center = Offset(size.width / 2, size.height /220);

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: firstRadius),
      pi,
      pi,
      false,
      paint,
    );

    final secRaduis = size.width / 6;
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: secRaduis),
      pi,
      pi,
      false,
      paint,
    );
  }

  @override
  bool shouldRepaint(BagShapePainter oldDelegate) {
    return oldDelegate.ratio != ratio ||
        oldDelegate.fullness != fullness ||
        oldDelegate.skewTop != skewTop ||
        oldDelegate.skewButtom != skewButtom;
  }
}
