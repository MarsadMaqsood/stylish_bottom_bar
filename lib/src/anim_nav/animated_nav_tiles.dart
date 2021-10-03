import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'animated_nav_bar.dart';
import 'animated_nav_items.dart';

class AnimatedNavigationTiles extends StatelessWidget {
  const AnimatedNavigationTiles(this.items, this.iconSize, this.padding,
      {Key? key,
      this.onTap,
      this.inkEffect,
      this.inkColor,
      required this.selected,
      required this.opacity,
      this.animation,
      this.flex,
      this.indexLabel,
      required this.barAnimation})
      : super(key: key);

  final AnimatedBarItems items;
  final double iconSize;
  final VoidCallback? onTap;
  final bool? inkEffect;
  final Color? inkColor;
  final bool selected;
  final EdgeInsets padding;
  final double opacity;
  final double? flex;
  final String? indexLabel;
  final Animation<double>? animation;
  final BarAnimation barAnimation;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Semantics(
        container: true,
        header: true,
        selected: this.selected,
        child: Stack(
          children: [
            Padding(
              padding: this.padding,
              child: InkWell(
                onTap: onTap,
                splashColor: inkEffect! ? inkColor : Colors.transparent,
                highlightColor: Colors.transparent,
                borderRadius: BorderRadius.horizontal(
                  right: Radius.circular(52),
                  left: Radius.circular(52),
                ),
                child: Container(
                    height: iconSize <= 26 ? 48 : 48 + (iconSize - 26),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: selected
                          ? MainAxisAlignment.spaceEvenly
                          : MainAxisAlignment.center,
                      children: _childItems(),
                    )),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _childItems() {
    var label = LabelWidget(
        animation: animation!, item: items, color: items.selectedColor!);

    return [
      IconWidget(
        items: items,
        selected: selected,
        iconSize: iconSize,
        barAnimation: barAnimation,
      ),
      AnimatedCrossFade(
        alignment: Alignment(0, 0),
        firstChild: label,
        secondChild: Container(),
        duration: Duration(milliseconds: 250),
        sizeCurve: Curves.fastOutSlowIn,
        firstCurve: Curves.fastOutSlowIn,
        secondCurve: Curves.fastOutSlowIn.flipped,
        crossFadeState:
            selected ? CrossFadeState.showFirst : CrossFadeState.showSecond,
      ),
    ];
  }
}

const _activeFontSize = 14.0;

class LabelWidget extends StatelessWidget {
  LabelWidget({
    Key? key,
    required this.animation,
    required this.item,
    required this.color,
  }) : super(key: key);

  final Animation<double> animation;
  final AnimatedBarItems item;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      heightFactor: 1.0,
      child: Container(
        child: FadeTransition(
          alwaysIncludeSemantics: true,
          opacity: animation,
          child: DefaultTextStyle.merge(
            style: TextStyle(
              fontSize: _activeFontSize,
              fontWeight: FontWeight.w600,
              color: color,
            ),
            child: item.title!,
          ),
        ),
      ),
    );
  }
}

class IconWidget extends StatefulWidget {
  IconWidget(
      {Key? key,
      required this.items,
      required this.selected,
      required this.iconSize,
      required this.barAnimation})
      : super(key: key);
  final AnimatedBarItems items;
  final bool selected;
  final double iconSize;
  final BarAnimation barAnimation;

  @override
  _IconWidgetState createState() => _IconWidgetState();
}

class _IconWidgetState extends State<IconWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<Color?> animationColor;
  late Animation<double> animation;

  @override
  void initState() {
    super.initState();
    if (widget.barAnimation != BarAnimation.transform3D)
      controller = AnimationController(
        duration: Duration(milliseconds: 600),
        vsync: this,
      );
  }

  @override
  void dispose() {
    if (widget.barAnimation != BarAnimation.transform3D) controller.dispose();
    super.dispose();
  }

  _assignAnimation() {
    if (widget.barAnimation != BarAnimation.transform3D) {
      if (widget.barAnimation == BarAnimation.fade) {
        animation =
            new CurvedAnimation(parent: controller, curve: Curves.easeIn);
      } else if (widget.barAnimation == BarAnimation.blink) {
        animation =
            new CurvedAnimation(parent: controller, curve: Curves.bounceIn);
      }

      animationColor = ColorTween(
        begin: widget.items.unSelectedColor,
        end: widget.items.selectedColor,
      ).animate(animation)
        ..addListener(() {
          setState(() {});
        });

      widget.selected ? controller.forward() : controller.reset();
    }
  }

  @override
  Widget build(BuildContext context) {
    _assignAnimation();

    return _buildWidget();
  }

  _buildWidget() {
    return Container(
      child: IconTheme(
        data: IconThemeData(
          color: widget.selected
              ? widget.barAnimation == BarAnimation.transform3D
                  ? widget.items.selectedColor
                  : animationColor.value
              : Colors.grey,
          size: widget.selected ? widget.iconSize + 4 : widget.iconSize,
        ),
        child:
            widget.barAnimation == BarAnimation.transform3D && widget.selected
                ? Transform(
                    transform: Matrix4.identity()
                      ..setEntry(3, 0, 0.003)
                      ..rotateY(0),
                    child: widget.items.icon!,
                  )
                : widget.items.icon!,
      ),
    );
  }
}

class LiquidPainter extends CustomPainter {
  static const _pi2 = 2 * pi;
  final GlobalKey textKey;
  final double waveValue;
  final double loadValue;
  final double boxHeight;
  final Color waveColor;

  LiquidPainter({
    required this.textKey,
    required this.waveValue,
    required this.loadValue,
    required this.boxHeight,
    required this.waveColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final RenderBox? textBox =
        textKey.currentContext!.findRenderObject() as RenderBox;
    if (textBox == null) return;
    final textHeight = textBox.size.height;
    final baseHeight =
        (boxHeight / 2) + (textHeight / 2) - (loadValue * textHeight);

    final width = size.width;
    final height = size.height;
    final path = Path();
    path.moveTo(0.0, baseHeight);
    for (var i = 0.0; i < width; i++) {
      path.lineTo(i, baseHeight + sin(_pi2 * (i / width + waveValue)) * 8);
    }

    path.lineTo(width, height);
    path.lineTo(0.0, height);
    path.close();
    final wavePaint = Paint()..color = waveColor;
    canvas.drawPath(path, wavePaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
