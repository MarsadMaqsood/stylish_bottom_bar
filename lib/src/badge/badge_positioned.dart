import 'package:flutter/material.dart';

class BadgePositioned extends StatelessWidget {
  /// This specify a badge position according to [child]
  final BadgePosition? position;

  /// It is a child that will be displayed according to [position]
  final Widget child;

  /// This creates a new instance of [BadgePositioned].
  ///
  /// See also:
  /// * [PositionedDirectional]
  const BadgePositioned({super.key, this.position, required this.child});

  @override
  Widget build(BuildContext context) {
    final position = this.position;
    if (position == null) {
      final topRight = BadgePosition.topEnd();
      return PositionedDirectional(
        top: topRight.top,
        end: topRight.end,
        child: child,
      );
    }
    return PositionedDirectional(
      top: position.top,
      end: position.end,
      bottom: position.bottom,
      start: position.start,
      child: child,
    );
  }
}

class BadgePosition {
  /// This is the distance to the top side of a parent widget.
  final double? top;

  /// This is the distance to the end side of a parent widget.
  final double? end;

  /// This is the distance to the start side of a parent widget.
  final double? start;

  /// This is the distance to the bottom side of a parent widget.
  final double? bottom;

  /// This creates a new instance of this widget
  const BadgePosition({this.top, this.end, this.bottom, this.start});

  /// Factory method that creates a new instance of this widget
  /// according to [top] and [start]
  factory BadgePosition.topStart({double top = -5, double start = -10}) {
    return BadgePosition(top: top, start: start);
  }

  /// Factory method that creates a new instance of this widget
  /// according to [top] and [end]
  factory BadgePosition.topEnd({double top = -8, double end = -10}) {
    return BadgePosition(top: top, end: end);
  }

  /// Factory method that creates a new instance of this widget
  /// according to [bottom] and [end]
  factory BadgePosition.bottomEnd({double bottom = -8, double end = -10}) {
    return BadgePosition(bottom: bottom, end: end);
  }

  /// Factory method that creates a new instance of this widget
  /// according to [bottom] and [start]
  factory BadgePosition.bottomStart({double bottom = -8, double start = -10}) {
    return BadgePosition(bottom: bottom, start: start);
  }
}
