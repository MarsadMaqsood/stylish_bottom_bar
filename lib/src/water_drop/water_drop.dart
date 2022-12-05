import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class WaterDrop extends StatefulWidget {
  final double top;
  final double left;
  final Size size;
  final Widget child;
  final Color? backgroundColor;

  const WaterDrop(
      {super.key,
      required this.size,
      required this.child,
      required this.top,
      required this.left,
      this.backgroundColor});

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

    Widget child = Stack(
      alignment: Alignment.center,
      children: [
        Container(
          alignment: Alignment.center,
          height: 50,
          width: 50,
          decoration: BoxDecoration(
              color: widget.backgroundColor,
              borderRadius: BorderRadius.circular(28)),
        ),
        widget.child
      ],
    );

    return Stack(
      children: [Container(child: child)],
    );
  }

  //A child with gradient on it for light illusion
  ///Get center of a drop
  Offset get center => Offset(
        widget.left + widget.size.width / 2,
        widget.top + widget.size.height / 2,
      );

  ///Map Center and Size to Alignment
  Alignment getAlignment(Size size) => Alignment(
        (center.dx - size.width / 2) / (size.width / 2),
        (center.dy - size.height / 2) / (size.height / 2),
      );
}
