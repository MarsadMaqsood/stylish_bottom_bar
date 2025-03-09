import 'dart:math' as math;

import 'package:flutter/material.dart';

class WaterDrop extends StatelessWidget {
  final double top;
  final double left;
  final double width;
  final double height;
  final Widget child;
  final Color? color;

  const WaterDrop({
    super.key,
    required this.width,
    required this.height,
    required this.child,
    required this.top,
    required this.left,
    this.color,
  });

  /// The diameter is the smaller of the two dimensions,
  /// ensuring the water drop is a perfect circle.
  double get diameter => math.min(width, height);

  /// The center of our circle, used by the clippers.
  Offset get center => Offset(left + diameter / 2, top + diameter / 2);

  @override
  Widget build(BuildContext context) {
    // We’ll calculate alignment relative to the screen size
    // to position the gradient properly.
    final screenSize = MediaQuery.of(context).size;
    final alignment = getAlignment(screenSize);

    // Because the shape is forced to a circle, we ignore the
    // difference between width & height for the gradient calculation.
    final alignmentModifier = Alignment(
      diameter / screenSize.width,
      diameter / screenSize.height,
    );

    final begin = alignment - alignmentModifier;
    final end = alignment + alignmentModifier;

    // Gradient overlay to simulate light refraction.
    final childWithGradient = Container(
      decoration: color != null
          ? BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color.lerp(color, Colors.black, 0.1)!,
                  Color.lerp(color, Colors.white, 0.9)!,
                  color!,
                ],
              ),
            )
          : null,
      foregroundDecoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          begin: begin,
          end: end,
          colors: [
            Colors.black12,
            Colors.white.withValues(alpha: 0.1), // Slight white
          ],
        ),
        backgroundBlendMode: BlendMode.overlay,
      ),
    );

    final mainChild = ClipOval(
      child: SizedBox(
        width: diameter,
        height: diameter,
        child: child,
      ),
    );

    return SizedBox(
      width: diameter,
      height: diameter,
      child: ClipOval(
        child: Stack(
          children: [
            // Shadow behind the circle.
            _CircleShadow(
              top: top,
              left: left,
              diameter: diameter,
            ),

            // Multiple scaled layers to simulate a realistic drop.
            ...List.generate(8, (i) {
              final scaleFactor = 1 + 0.02 * i;
              return Transform.scale(
                scale: scaleFactor,
                alignment: alignment,
                child: ClipPath(
                  clipper: _CircleClipper(
                    center: center,
                    diameter: diameter * (1 - 0.04 * i),
                  ),
                  child: childWithGradient,
                ),
              );
            }),

            Positioned(
              left: left,
              top: top,
              child: mainChild,
            ),

            // A small highlight to mimic a reflective dot.
            _LightDot(
              top: top,
              left: left,
              diameter: diameter,
            ),
          ],
        ),
      ),
    );
  }

  /// Converts the center to an alignment within the screen size
  Alignment getAlignment(Size screenSize) {
    return Alignment(
      (center.dx - screenSize.width / 2) / (screenSize.width / 2),
      (center.dy - screenSize.height / 2) / (screenSize.height / 2),
    );
  }
}

class _CircleClipper extends CustomClipper<Path> {
  final Offset center;
  final double diameter;

  _CircleClipper({
    required this.center,
    required this.diameter,
  });

  @override
  Path getClip(Size size) {
    return Path()
      ..addOval(
        Rect.fromCenter(
          center: center,
          width: diameter,
          height: diameter,
        ),
      );
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => true;
}

/// A small reflective dot inside the circle
class _LightDot extends StatelessWidget {
  final double top;
  final double left;
  final double diameter;

  const _LightDot({
    required this.top,
    required this.left,
    required this.diameter,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: left + diameter / 4,
      top: top + diameter / 4,
      width: diameter / 4,
      height: diameter / 4,
      child: DecoratedBox(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              blurRadius: 3,
              color: Colors.white.withValues(alpha: 0.7),
            ),
          ],
        ),
      ),
    );
  }
}

/// A circular shadow behind the drop
class _CircleShadow extends StatelessWidget {
  final double top;
  final double left;
  final double diameter;

  const _CircleShadow({
    required this.top,
    required this.left,
    required this.diameter,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: left,
      top: top,
      width: diameter,
      height: diameter,
      child: DecoratedBox(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              blurRadius: 4,
              offset: const Offset(4, 4),
              color: Colors.black.withValues(alpha: 0.5),
            ),
          ],
        ),
      ),
    );
  }
}
