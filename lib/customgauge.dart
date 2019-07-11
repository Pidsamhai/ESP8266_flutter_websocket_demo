import 'dart:core';

import 'package:flutter/material.dart';


class GaugeWidget extends StatelessWidget {
  final double size;
  final double strokewidth;
  final double fontsize;
  final double value;
  final Color baseColor;
  final Color valueColor;
  final Color fontColor;
  final String text;
  GaugeWidget({
    Key key,
    this.size = 100,
    this.strokewidth = 5,
    this.fontsize = 10,
    this.value = 0,
    this.baseColor = Colors.grey,
    this.valueColor = Colors.purple,
    this.fontColor = Colors.white,
    this.text = "Value Here",
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: <Widget>[
          // Gague
          Positioned(
            child: Container(
              margin: EdgeInsets.only(top: 10),
              width: size,
              height: size,
              child: CustomPaint(
                painter: GaugePainter(
                  strokewidth: strokewidth,
                  value: value,
                  baseColor: baseColor,
                  valueColor: valueColor,
                ),
              ),
            ),
          ),
          // Inner Text
          Positioned(
            child: Container(
              width: size,
              height: size,
              child: Center(
                child: Text(
                  text,
                  style: TextStyle(
                    color: fontColor,
                    fontSize: fontsize,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class GaugePainter extends CustomPainter {
  final double angle = 4.42159265359;
  final double strokewidth;
  final double value;
  final double percent = 4.42159265359 / 100;
  final Color baseColor;
  final Color valueColor;

  GaugePainter({
    this.strokewidth = 5,
    this.value = 0,
    this.baseColor,
    this.valueColor,
  });

  void paint(Canvas canvas, Size size) {
    // Base line
    canvas.drawArc(
        Rect.fromLTRB(0, 0, size.width, size.height),
        2.5,
        angle,
        false,
        Paint()
          ..color = baseColor
          ..strokeWidth = strokewidth
          ..strokeCap = StrokeCap.round
          ..style = PaintingStyle.stroke);

    // Value line
    canvas.drawArc(
        Rect.fromLTRB(0, 0, size.width, size.height),
        2.5,
        value * percent,
        false,
        Paint()
          ..color = valueColor
          ..strokeWidth = strokewidth
          ..strokeCap = StrokeCap.round
          ..style = PaintingStyle.stroke);
  }

  @override
  bool shouldRepaint(GaugePainter oldDelegate) => false;

  @override
  bool shouldRebuildSemantics(GaugePainter oldDelegate) => false;
}
