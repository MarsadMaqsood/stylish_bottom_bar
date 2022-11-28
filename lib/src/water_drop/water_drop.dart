import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class WaterDrop extends StatefulWidget {
  final double top;
  final double left;
  final Size size;
  final Widget child;

  const WaterDrop({
    super.key,
    required this.size,
    required this.child,
    required this.top,
    required this.left,
  });

  @override
  State<WaterDrop> createState() => __WaterDropState();
}

class __WaterDropState extends State<WaterDrop> {
  // Size of the child widget, needed to provide gradient on the drop.
  Size? totalSize;

  @override
  Widget build(BuildContext context) {
    /// Rebuild the widget if [totalSize] is null
    if (totalSize == null) {
      SchedulerBinding.instance.addPostFrameCallback((_) {
        setState(() => totalSize = context.size!);
      });
    }

    Widget child = Container(
      child: widget.child,
    );

    return Stack(
      children: [
        ClipPath(
          clipper: _OvalClipper(
              center: center,
              width: widget.size.width,
              height: widget.size.height),
          clipBehavior: Clip.hardEdge,
          child: child,
        ),
      ],
    );
  }

  //A child with gradient on it for light illusion
  ///Get center of a drop
  Offset get center => Offset(
        widget.left + widget.size.width / 1.65,
        widget.top + widget.size.height / 1.65,
      );

  ///Map Center and Size to Alignment
  Alignment getAlignment(Size size) => Alignment(
        (center.dx - size.width / 2.25) / (size.width / 2.25),
        (center.dy - size.height / 2.25) / (size.height / 2.25),
      );
}

class _OvalClipper extends CustomClipper<Path> {
  final Offset center;
  final double height, width;

  _OvalClipper(
      {required this.center, required this.width, required this.height});

  @override
  Path getClip(Size size) {
    Path path = Path()
      ..addOval(Rect.fromCenter(
        width: width,
        height: height,
        center: center,
      ));

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}
