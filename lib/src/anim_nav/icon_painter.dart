import 'package:flutter/material.dart';

class IconPainter extends CustomPainter {
  IconData iconData;
  Color color;
  double size;
  IconPainter(this.iconData, this.color, this.size);

  @override
  void paint(Canvas canvas, Size size) {
    final icon = Icons.settings;

    TextPainter textPainter = TextPainter(
      textDirection: TextDirection.ltr,
    );
    textPainter.text = TextSpan(
      text: String.fromCharCode(icon.codePoint),
      style: TextStyle(
        color: color,

        fontSize: this.size,
        fontFamily: icon.fontFamily,
        package:
            icon.fontPackage, // This line is mandatory for external icon packs
      ),
    );
    textPainter.layout();
    textPainter.paint(canvas, Offset(50, 0));
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
    // throw UnimplementedError();
  }
}

class CirclePaint extends CustomPainter {
  double size;
  Color color;

  CirclePaint(this.size, this.color);

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawCircle(
        Offset(66, 16), (this.size / 3.5), new Paint()..color = color);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
