import 'package:flutter/material.dart';
import 'package:stylish_bottom_bar/src/helpers/constant.dart';
import 'package:stylish_bottom_bar/src/helpers/enums.dart';
import 'package:stylish_bottom_bar/src/model/animated_nav_items.dart';
import 'package:stylish_bottom_bar/src/water_drop/water_drop.dart';

const double paddingSize = 16;

class AnimatedNavigationTiles extends StatelessWidget {
  const AnimatedNavigationTiles(
    this.items,
    this.iconSize,
    this.padding, {
    super.key,
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

  final AnimatedBarItems items;

  ///Icon size
  final double iconSize;

  ///onTap gesture event
  final VoidCallback? onTap;

  final bool? inkEffect;
  final Color? inkColor;
  final bool selected;
  final EdgeInsets padding;

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
        child: Stack(
          children: [
            InkWell(
              onTap: onTap,
              splashColor: inkEffect! ? inkColor : Colors.transparent,
              highlightColor: Colors.transparent,
              // child: SizedBox(
              //   height: iconSize <= 26 ? 62 : 48 + (iconSize - 26),
              child: Padding(
                padding: padding,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: selected
                      ? barAnimation == BarAnimation.liquid
                          ? MainAxisAlignment.spaceBetween
                          : MainAxisAlignment.spaceEvenly
                      : MainAxisAlignment.center,
                  children: barAnimation == BarAnimation.liquid
                      ? _liquidItems()
                      : barAnimation == BarAnimation.drop ||
                              barAnimation == BarAnimation.fade
                          ? _dropItems(barAnimation)
                          : _childItems(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _defaultItems() {
    var label = LabelWidget(
      iconStyle: iconStyle,
      animation: animation!,
      item: items,
      color: selected ? items.selectedColor : items.unSelectedColor,
    );
    return [
      Container(
        alignment: Alignment.center,
        child: IconTheme(
          data: IconThemeData(
            color: selected ? items.selectedColor : items.unSelectedColor,
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

  _liquidItems() {
    var label = LabelWidget(
        iconStyle: iconStyle,
        animation: animation!,
        item: items,
        color: items.selectedColor);
    return [
      // const Spacer(),
      AnimatedCrossFade(
        firstChild: Padding(
          padding: const EdgeInsets.all(6.0),
          child: label,
        ),
        secondChild: Container(
          alignment: Alignment.center,
          child: IconTheme(
            data: IconThemeData(
              color: selected ? items.selectedColor : items.unSelectedColor,
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
      // const Spacer(),
      AnimatedCrossFade(
        firstChild: Container(),
        secondChild: Container(
          height: 20,
          width: 22,
          decoration: BoxDecoration(
            color: items.selectedColor,
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

  _childItems() {
    var label = LabelWidget(
        iconStyle: iconStyle,
        animation: animation!,
        item: items,
        color: items.selectedColor);

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
                      color: selected
                          ? items.selectedColor
                          : items.unSelectedColor,
                      size: selected ? iconSize + 4 : iconSize,
                    ),
                    child: selected && items.selectedIcon != null
                        ? items.selectedIcon!
                        : items.icon!,
                  ),
                ),
              ];
  }

  _dropItems(BarAnimation barAnimation) {
    var label = LabelWidget(
      iconStyle: iconStyle,
      animation: animation!,
      item: items,
      color: selected ? items.selectedColor : items.unSelectedColor,
    );
    return [
      AnimatedCrossFade(
        firstChild: Container(
          alignment: Alignment.center,
          child: IconTheme(
            data: IconThemeData(
              color: selected ? items.selectedColor : items.unSelectedColor,
              size: iconSize,
            ),
            child: Padding(
                child: selected && items.selectedIcon != null
                    ? items.selectedIcon!
                    : items.icon!,
                padding: EdgeInsets.all(paddingSize)),
          ),
        ),
        secondChild: Align(
          alignment: Alignment.center,
          child: WaterDrop(
            backgroundColor: items.backgroundColor,
            top: 0,
            size: Size(iconSize + paddingSize, iconSize + paddingSize),
            left: 0,
            child: Container(
              // color: items.backgroundColor,
              padding: const EdgeInsets.all(paddingSize),
              child: IconTheme(
                data: IconThemeData(
                  color: selected ? items.selectedColor : items.unSelectedColor,
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
      ),
      if (barAnimation == BarAnimation.fade && iconStyle == IconStyle.Default)
        label
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
  final AnimatedBarItems item;
  final Color color;
  final IconStyle iconStyle;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      heightFactor: 0.5,
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
  final AnimatedBarItems items;
  final bool selected;
  final double iconSize;
  final BarAnimation barAnimation;

  @override
  State<IconWidget> createState() => _IconWidgetState();
}

class _IconWidgetState extends State<IconWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<Color?> animationColor;
  late Animation<double> animation;

  @override
  void initState() {
    super.initState();

    if (widget.barAnimation != BarAnimation.transform3D) {
      controller = AnimationController(
        duration: const Duration(milliseconds: 300),
        reverseDuration: const Duration(milliseconds: 300),
        vsync: this,
      );
    }
  }

  @override
  void dispose() {
    if (widget.barAnimation != BarAnimation.transform3D) controller.dispose();
    super.dispose();
  }

  _assignAnimation() {
    if (widget.barAnimation != BarAnimation.transform3D) {
      if (widget.barAnimation == BarAnimation.blink) {
        animation = CurvedAnimation(parent: controller, curve: Curves.bounceIn);
      } else {
        animation = CurvedAnimation(parent: controller, curve: Curves.ease);
      }

      animationColor = ColorTween(
        begin: widget.items.unSelectedColor,
        end: widget.items.selectedColor,
      ).animate(animation)
        ..addListener(() {
          // setState(() {});
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
    return IconTheme(
      data: IconThemeData(
        color: widget.selected
            ? widget.barAnimation == BarAnimation.transform3D
                ? widget.items.selectedColor
                : animationColor.value
            : widget.items.unSelectedColor,
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
