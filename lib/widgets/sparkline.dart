import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/*
lineWidth: 1.5,
                                  lineColor: Colors.black26,
                                  fillMode: FillMode.below,
                                  fillGradient: LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    colors: [
                                      const Color(0xFFEBEBEB),
                                      const Color(0xFFFFFFFF),
                                    ],
                                  ),*
                                  */

class LinesPainter extends CustomPainter {
  LinesPainter(this.values);

  final Iterable<double> values;

  @override
  void paint(Canvas canvas, Size size) {
    final mi = values.reduce(min);
    final mx = values.reduce(max);
    final norm = mx - mi;

    final count = values.length.toDouble();
    final sectionWidth = size.width / count;

    var i = 0;

    final linePaint = Paint();
    linePaint.color = Colors.black54;
    linePaint.strokeWidth = 1.0;

    final rectPaint = Paint();
    rectPaint.shader = LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [
        const Color(0xFFCECECE),
        const Color(0xFFFFFFFF),
      ],
    ).createShader(Rect.fromLTWH(0, 0, sectionWidth, size.height));

    values.forEach((point) {
      final p = (point - mi) / norm;

      final startx = i * sectionWidth;
      final endx = (i + 1) * sectionWidth;
      final y = size.height * p;

      canvas.drawRect(
        Rect.fromLTWH(startx, y + 1.5, sectionWidth, size.height - (y + 1.5)),
        rectPaint,
      );

      canvas.drawLine(
        Offset(startx, y),
        Offset(endx, y),
        linePaint,
      );

      i++;
    });
  }

  @override
  bool shouldRepaint(LinesPainter oldDelegate) => oldDelegate.values != values;
}

class Sparkline extends StatelessWidget {
  Sparkline(this.values);

  final Iterable<double> values;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, contraints) {
      return CustomPaint(
          painter: LinesPainter(values), size: contraints.biggest);
    });
  }
}
