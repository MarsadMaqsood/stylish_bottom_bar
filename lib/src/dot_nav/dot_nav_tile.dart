import 'package:flutter/material.dart';
import 'package:stylish_bottom_bar/helpers/constant.dart';
import 'package:stylish_bottom_bar/helpers/enums.dart';
import 'package:stylish_bottom_bar/model/bar_items.dart';
import 'package:stylish_bottom_bar/stylish_bottom_bar.dart';

class DotNavigationTiles extends StatelessWidget {
  const DotNavigationTiles(
    this.items, {
    super.key,
    this.onTap,
    required this.selected,
    this.animation,
    this.flex,
    this.indexLabel,
    required this.options,
  });

  final DotBarOptions options;

  // final AnimatedBarItems items;
  final BottomBarItem items;

  ///onTap gesture event
  final VoidCallback? onTap;

  final bool selected;

  final double? flex;
  final String? indexLabel;
  final Animation<double>? animation;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Semantics(
        container: true,
        header: true,
        selected: selected,
        child: Padding(
          padding: options.padding ??
              (items.showBadge
                  ? const EdgeInsets.only(
                      top: 6.0,
                    )
                  : EdgeInsets.zero),
          child: Badge(
            label: items.badge,
            isLabelVisible: items.showBadge,
            backgroundColor: items.badgeColor,
            padding: items.badgePadding,
            child: InkWell(
              onTap: onTap,
              splashColor:
                  options.inkEffect ? options.inkColor : Colors.transparent,
              highlightColor: Colors.transparent,
              borderRadius: const BorderRadius.horizontal(
                right: Radius.circular(52),
                left: Radius.circular(52),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: selected
                    ? MainAxisAlignment.spaceEvenly
                    : MainAxisAlignment.center,
                children: _dotItems(),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Color get itemColor =>
      items.backgroundColor ??
      (selected ? items.selectedColor : items.unSelectedColor);
  Color get itemColorOnSelected => items.backgroundColor ?? items.selectedColor;

  List<Widget> _dotItems() {
    var label = LabelWidget(
      animation: animation!,
      item: items,
      color: itemColorOnSelected,
    );
    return [
      AnimatedCrossFade(
        firstChild: Padding(
          padding: const EdgeInsets.all(6.0),
          child: label,
        ),
        secondChild: Container(
          alignment: Alignment.center,
          child: IconTheme(
            data: IconThemeData(
              color: itemColor,
              size: options.iconSize,
            ),
            child: selected && items.selectedIcon != null
                ? items.selectedIcon!
                : items.icon!,
          ),
        ),
        duration: const Duration(milliseconds: 600),
        sizeCurve: Curves.fastOutSlowIn,
        firstCurve: Curves.fastOutSlowIn,
        secondCurve: Curves.fastOutSlowIn.flipped,
        crossFadeState:
            selected ? CrossFadeState.showFirst : CrossFadeState.showSecond,
      ),
      AnimatedCrossFade(
        firstChild: const SizedBox(),
        secondChild: Container(
          height: 8,
          width: options.dotStyle == DotStyle.circle ? 8 : 16,
          decoration: BoxDecoration(
            color: itemColorOnSelected,
            borderRadius: BorderRadius.circular(4),
            gradient: options.gradient,
          ),
        ),
        duration: const Duration(milliseconds: 300),
        sizeCurve: Curves.linear,
        firstCurve: Curves.fastOutSlowIn,
        secondCurve: Curves.fastOutSlowIn.flipped,
        crossFadeState:
            selected ? CrossFadeState.showSecond : CrossFadeState.showFirst,
      ),
    ];
  }
}

class LabelWidget extends StatelessWidget {
  const LabelWidget({
    Key? key,
    required this.animation,
    required this.item,
    required this.color,
  }) : super(key: key);

  final Animation<double> animation;
  final BottomBarItem item;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      heightFactor: 1.0,
      // ignore: avoid_unnecessary_containers
      child: Container(
        child: FadeTransition(
          alwaysIncludeSemantics: true,
          opacity: animation,
          child: DefaultTextStyle.merge(
            style: TextStyle(
              fontSize: activeFontSize,
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
  const IconWidget(
      {Key? key,
      required this.items,
      required this.selected,
      required this.iconSize,
      required this.barAnimation})
      : super(key: key);
  // final AnimatedBarItems items;
  final BottomBarItem items;
  final bool selected;
  final double iconSize;
  final BarAnimation barAnimation;

  @override
  State<IconWidget> createState() => _IconWidgetState();
}

class _IconWidgetState extends State<IconWidget>
    with SingleTickerProviderStateMixin {
  AnimationController? controller;
  late Animation<Color?> animationColor;
  late Animation<double> animation;

  @override
  void initState() {
    super.initState();

    _init();
  }

  void _init() {
    if (widget.barAnimation != BarAnimation.transform3D) {
      controller = AnimationController(
        duration: const Duration(milliseconds: 300),
        reverseDuration: const Duration(milliseconds: 300),
        vsync: this,
      );
    }
    _assignAnimation();
  }

  @override
  void dispose() {
    if (widget.barAnimation != BarAnimation.transform3D) controller?.dispose();
    super.dispose();
  }

  _assignAnimation() {
    if (widget.barAnimation != BarAnimation.transform3D) {
      if (widget.barAnimation == BarAnimation.blink) {
        animation =
            CurvedAnimation(parent: controller!, curve: Curves.bounceIn);
      } else {
        animation = CurvedAnimation(parent: controller!, curve: Curves.ease);
      }

      animationColor = ColorTween(
        begin: widget.items.backgroundColor ?? widget.items.unSelectedColor,
        end: widget.items.selectedColor,
      ).animate(animation)
        ..addListener(() {
          setState(() {});
        });
    }
  }

  _playAnimation() {
    if (widget.barAnimation != BarAnimation.transform3D) {
      widget.selected ? controller?.forward() : controller?.reset();
    }
  }

  @override
  Widget build(BuildContext context) {
    if (controller == null) _init();
    // _assignAnimation();
    _playAnimation();

    return _buildWidget();
  }

  _buildWidget() {
    return IconTheme(
      data: IconThemeData(
        color: widget.items.backgroundColor ??
            (widget.selected
                ? widget.barAnimation == BarAnimation.transform3D
                    ? widget.items.selectedColor
                    : animationColor.value
                : widget.items.unSelectedColor),
        size: widget.selected ? widget.iconSize + 4 : widget.iconSize,
      ),
      child: widget.selected
          ? widget.barAnimation == BarAnimation.transform3D
              ? Transform(
                  transform: Matrix4.identity()
                    // ..setEntry(2, 3, 0.003)
                    ..setEntry(3, 0, 0.002)
                    ..rotateY(0), //..rotateY(0),
                  child: widget.items.icon!,
                )
              : widget.items.icon!
          : widget.items.icon!,
    );
  }
}
