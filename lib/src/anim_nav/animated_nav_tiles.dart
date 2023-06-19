import 'package:flutter/material.dart';
import 'package:stylish_bottom_bar/helpers/constant.dart';
import 'package:stylish_bottom_bar/helpers/enums.dart';
import 'package:stylish_bottom_bar/model/bar_items.dart';
import 'package:stylish_bottom_bar/src/water_drop/water_drop.dart';

class AnimatedNavigationTiles extends StatelessWidget {
  const AnimatedNavigationTiles(
    this.items,
    this.iconSize, {
    super.key,
    this.padding,
    this.onTap,
    this.inkEffect,
    this.inkColor,
    required this.selected,
    required this.opacity,
    this.animation,
    this.flex,
    this.indexLabel,
    required this.barAnimation,
    required this.iconStyle,
  });

  // final AnimatedBarItems items;
  final BottomBarItem items;

  ///Icon size
  final double iconSize;

  ///onTap gesture event
  final VoidCallback? onTap;

  final bool? inkEffect;
  final Color? inkColor;
  final bool selected;
  final EdgeInsets? padding;

  ///Background color opacity
  final double opacity;
  final double? flex;
  final String? indexLabel;
  final Animation<double>? animation;
  final BarAnimation barAnimation;

  ///icon style of the bottom bar items
  ///[IconStyle.Default]
  ///[IconStyle.animated]
  ///[IconStyle.simple]
  final IconStyle iconStyle;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Semantics(
        container: true,
        header: true,
        selected: selected,
        child: Padding(
          padding: padding ??
              (items.showBadge && iconStyle != IconStyle.simple
                  ? const EdgeInsets.only(
                      top: 6.0,
                    )
                  : EdgeInsets.zero),
          child: Badge(
            label: items.badge,
            isLabelVisible: items.showBadge,
            child: InkWell(
              onTap: onTap,
              splashColor: inkEffect! ? inkColor : Colors.transparent,
              highlightColor: Colors.transparent,
              borderRadius: const BorderRadius.horizontal(
                right: Radius.circular(52),
                left: Radius.circular(52),
              ),
              // child: SizedBox(
              // height: iconSize <= 26 ? 48 : 48 + (iconSize - 26),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: selected
                    ? barAnimation == BarAnimation.liquid
                        ? MainAxisAlignment.spaceBetween
                        : MainAxisAlignment.spaceEvenly
                    : MainAxisAlignment.center,
                children: _getBarItems(),
              ),
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> _getBarItems() {
    if (barAnimation == BarAnimation.liquid) {
      return _liquidItems();
    } else if (barAnimation == BarAnimation.drop) {
      return _dropItems();
    } else {
      return _childItems();
    }
  }

  Color get itemColor =>
      items.backgroundColor ??
      (selected ? items.selectedColor : items.unSelectedColor);
  Color get itemColorOnSelected => items.backgroundColor ?? items.selectedColor;

  List<Widget> _defaultItems() {
    var label = LabelWidget(
      iconStyle: iconStyle,
      animation: animation!,
      item: items,
      color: itemColor,
    );
    return [
      Container(
        alignment: Alignment.center,
        child: IconTheme(
          data: IconThemeData(
            color: itemColor,
            size: iconSize,
            // size: selected ? iconSize + 4 : iconSize,
          ),
          child: selected && items.selectedIcon != null
              ? items.selectedIcon!
              : items.icon!,
        ),
      ),
      label,
    ];
  }

  List<Widget> _liquidItems() {
    var label = LabelWidget(
      iconStyle: iconStyle,
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
              size: iconSize,
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
        firstChild: Container(),
        secondChild: Container(
          height: 20,
          width: 22,
          decoration: BoxDecoration(
            color: itemColorOnSelected,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.elliptical(12, 20),
              topRight: Radius.elliptical(12, 20),
            ),
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

  List<Widget> _childItems() {
    var label = LabelWidget(
      iconStyle: iconStyle,
      animation: animation!,
      item: items,
      color: itemColorOnSelected,
    );

    return iconStyle == IconStyle.Default
        ? _defaultItems()
        : iconStyle == IconStyle.animated
            ? [
                IconWidget(
                  items: items,
                  selected: selected,
                  iconSize: iconSize,
                  barAnimation: barAnimation,
                ),
                AnimatedCrossFade(
                  alignment: const Alignment(0, 0),
                  firstChild: label,
                  secondChild: Container(),
                  duration: const Duration(milliseconds: 250),
                  sizeCurve: Curves.fastOutSlowIn,
                  firstCurve: Curves.fastOutSlowIn,
                  secondCurve: Curves.fastOutSlowIn.flipped,
                  crossFadeState: selected
                      ? CrossFadeState.showFirst
                      : CrossFadeState.showSecond,
                ),
              ]
            : [
                Container(
                  alignment: Alignment.center,
                  child: IconTheme(
                    data: IconThemeData(
                      color: itemColor,
                      size: selected ? iconSize + 4 : iconSize,
                    ),
                    child: selected && items.selectedIcon != null
                        ? items.selectedIcon!
                        : items.icon!,
                  ),
                ),
              ];
  }

  List<Widget> _dropItems() {
    return [
      AnimatedCrossFade(
        firstChild: Container(
          alignment: Alignment.center,
          child: IconTheme(
            data: IconThemeData(
              color: itemColor,
              size: iconSize,
            ),
            child: selected && items.selectedIcon != null
                ? items.selectedIcon!
                : items.icon!,
          ),
        ),
        secondChild: Align(
          alignment: Alignment.center,
          child: WaterDrop(
            top: 0,
            size: const Size(48, 48),
            left: 0,
            child: Container(
              color: items.backgroundColor,
              padding: const EdgeInsets.all(12),
              child: IconTheme(
                data: IconThemeData(
                  color: itemColor,
                  size: iconSize,
                ),
                child: selected && items.selectedIcon != null
                    ? items.selectedIcon!
                    : items.icon!,
              ),
            ),
          ),
        ),
        duration: const Duration(milliseconds: 300),
        sizeCurve: Curves.linear,
        firstCurve: Curves.ease,
        secondCurve: Curves.fastOutSlowIn.flipped,
        crossFadeState:
            selected ? CrossFadeState.showSecond : CrossFadeState.showFirst,
      )
    ];
  }
}

class LabelWidget extends StatelessWidget {
  const LabelWidget({
    Key? key,
    required this.animation,
    required this.item,
    required this.color,
    required this.iconStyle,
  }) : super(key: key);

  final Animation<double> animation;
  // final AnimatedBarItems item;
  final BottomBarItem item;
  final Color color;
  final IconStyle iconStyle;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      heightFactor: 1.0,
      child: Container(
        child: iconStyle == IconStyle.Default
            ? DefaultTextStyle.merge(
                style: TextStyle(
                  fontSize: activeFontSize,
                  fontWeight: FontWeight.w600,
                  color: color,
                ),
                child: item.title!,
              )
            : FadeTransition(
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
