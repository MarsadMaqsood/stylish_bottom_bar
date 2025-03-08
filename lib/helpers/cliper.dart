import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class BarClipper extends CustomClipper<Path> {
  const BarClipper({
    required this.geometry,
    required this.shape,
    required this.notchMargin,
  }) : super(reclip: geometry);

  final ValueListenable<ScaffoldGeometry> geometry;
  final NotchedShape shape;
  final double notchMargin;

  @override
  Path getClip(Size size) {
    final scaffoldGeometry = geometry.value;
    final fabArea = scaffoldGeometry.floatingActionButtonArea;
    final barTop = scaffoldGeometry.bottomNavigationBarTop ?? 0.0;

    final Rect? button = fabArea
        ?.translate(
          0.0,
          -barTop,
        )
        .inflate(notchMargin);

    return shape.getOuterPath(Offset.zero & size, button);
  }

  @override
  bool shouldReclip(covariant BarClipper oldClipper) {
    return oldClipper.geometry != geometry ||
        oldClipper.shape != shape ||
        oldClipper.notchMargin != notchMargin;
  }
}
