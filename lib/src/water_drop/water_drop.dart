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
  State<WaterDrop> createState() => _WaterDropState();
}

class _WaterDropState extends State<WaterDrop> {
  // Size of the child widget, needed to provide gradient on the drop.
  Size? totalSize;

  @override
  Widget build(BuildContext context) {
    /// Rebuild the widget if [totalSize] is null
    if (totalSize == null) {
      SchedulerBinding.instance.addPostFrameCallback((_) {
        if (context.size != null) {
          setState(() => totalSize = context.size);
        }
      });
    }

    final size = totalSize ?? MediaQuery.of(context).size;
    final alignment = getAlignment(size);

    //used for determining alignments for gradient
    final alignmentModifier = Alignment(
      widget.size.width / size.width,
      widget.size.height / size.height,
    );

    final begin = alignment - alignmentModifier;
    final end = alignment + alignmentModifier;

    Widget childWithGradient = Container(
      foregroundDecoration: BoxDecoration(
        gradient: LinearGradient(
          begin: begin,
          end: end,
          colors: const [Colors.black, Colors.white],
        ),
        // backgroundBlendMode: BlendMode.overlay,
        backgroundBlendMode: BlendMode.colorBurn,
      ),
      child: widget.child,
    );

    return Stack(
      children: [
        _OvalShadow(
          width: widget.size.width,
          height: widget.size.height,
        ),
        ClipPath(
          clipper: _OvalClipper(
              center: center,
              width: widget.size.width,
              height: widget.size.height),
          clipBehavior: Clip.hardEdge,
          child: childWithGradient,
        ),
        _LightDot(
          width: widget.size.width,
          height: widget.size.height,
        ),
      ],
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

class _LightDot extends StatelessWidget {
  final double width, height;

  const _LightDot({required this.width, required this.height});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: width / 5,
      top: height / 5,
      width: width / 5,
      height: height / 5,
      child: DecoratedBox(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              blurRadius: 2.25,
              color: Colors.white.withOpacity(0.9),
            ),
          ],
        ),
      ),
    );
  }
}

class _OvalShadow extends StatelessWidget {
  final double width;
  final double height;

  const _OvalShadow({required this.width, required this.height});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      width: width,
      height: height,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(width / 2),
          boxShadow: [
            BoxShadow(
              blurRadius: 3,
              offset: const Offset(3, 3),
              color: Colors.black.withOpacity(0.5),
            ),
          ],
        ),
      ),
    );
  }
}
