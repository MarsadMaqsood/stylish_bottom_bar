import 'package:flutter/material.dart';
import 'package:stylish_bottom_bar/src/core/bottom_bar_constants.dart';
import 'package:stylish_bottom_bar/src/core/bottom_bar_item.dart';
import 'package:stylish_bottom_bar/src/styles/animated/widgets/water_drop_painter.dart';
import 'package:stylish_bottom_bar/src/utils/enums.dart';

class AnimatedNavigationTiles extends StatelessWidget {
  const AnimatedNavigationTiles(
    this.items,
    this.iconSize, {
    super.key,
    this.padding,
    this.onTap,
    this.inkEffect = false,
    this.inkColor,
    required this.selected,
    required this.opacity,
    this.animation,
    this.flex,
    this.indexLabel,
    required this.barAnimation,
    required this.iconStyle,
  });

  final BottomBarItem items;

  /// Icon size
  final double iconSize;

  /// onTap gesture event
  final VoidCallback? onTap;

  final bool? inkEffect;
  final Color? inkColor;
  final bool selected;
  final EdgeInsets? padding;

  /// Background color opacity
  final double opacity;
  final double? flex;
  final String? indexLabel;
  final Animation<double>? animation;
  final BarAnimation barAnimation;

  /// Icon style of the bottom bar items
  final IconStyle iconStyle;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Semantics(
        container: true,
        header: true,
        selected: selected,
        label: indexLabel,
        child: Padding(
          padding: padding ??
              (items.showBadge && iconStyle != IconStyle.simple
                  ? const EdgeInsets.only(
                      top: 6.0,
                    )
                  : EdgeInsets.zero),
          child: InkWell(
            onTap: onTap,
            splashColor: (inkEffect ?? false) ? (inkColor ?? Colors.grey) : Colors.transparent,
            highlightColor: Colors.transparent,
            borderRadius: const BorderRadius.horizontal(
              right: Radius.circular(52),
              left: Radius.circular(52),
            ),
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
    final label = _AnimatedLabelWidget(
      iconStyle: iconStyle,
      animation: animation,
      item: items,
      color: itemColor,
    );
    return [
      Container(
        alignment: Alignment.center,
        child: Badge(
          label: items.badge,
          isLabelVisible: items.showBadge,
          backgroundColor: items.badgeColor,
          padding: items.badgePadding,
          child: IconTheme(
            data: IconThemeData(
              color: itemColor,
              size: iconSize,
            ),
            child: selected ? items.selectedIcon ?? items.icon : items.icon,
          ),
        ),
      ),
      label,
    ];
  }

  List<Widget> _liquidItems() {
    final label = _AnimatedLabelWidget(
      iconStyle: iconStyle,
      animation: animation,
      item: items,
      color: itemColorOnSelected,
    );
    return [
      Badge(
        label: items.badge,
        isLabelVisible: items.showBadge,
        backgroundColor: items.badgeColor,
        padding: items.badgePadding,
        alignment: const Alignment(0.175, -1.0),
        child: AnimatedCrossFade(
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
              child: selected ? items.selectedIcon ?? items.icon : items.icon,
            ),
          ),
          duration: const Duration(milliseconds: 600),
          sizeCurve: Curves.fastOutSlowIn,
          firstCurve: Curves.fastOutSlowIn,
          secondCurve: Curves.fastOutSlowIn.flipped,
          crossFadeState:
              selected ? CrossFadeState.showFirst : CrossFadeState.showSecond,
        ),
      ),
      AnimatedCrossFade(
        firstChild: const SizedBox.shrink(),
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
    final label = _AnimatedLabelWidget(
      iconStyle: iconStyle,
      animation: animation,
      item: items,
      color: itemColorOnSelected,
    );

    return iconStyle == IconStyle.Default
        ? _defaultItems()
        : iconStyle == IconStyle.animated
            ? [
                Badge(
                  label: items.badge,
                  isLabelVisible: items.showBadge,
                  backgroundColor: items.badgeColor,
                  padding: items.badgePadding,
                  child: _AnimatedIconWidget(
                    item: items,
                    selected: selected,
                    iconSize: iconSize,
                    barAnimation: barAnimation,
                  ),
                ),
                AnimatedCrossFade(
                  alignment: const Alignment(0, 0),
                  firstChild: label,
                  secondChild: const SizedBox.shrink(),
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
                  child: Badge(
                    label: items.badge,
                    isLabelVisible: items.showBadge,
                    backgroundColor: items.badgeColor,
                    padding: items.badgePadding,
                    child: IconTheme(
                      data: IconThemeData(
                        color: itemColor,
                        size: selected ? iconSize + 4 : iconSize,
                      ),
                      child: selected
                          ? items.selectedIcon ?? items.icon
                          : items.icon,
                    ),
                  ),
                ),
              ];
  }

  List<Widget> _dropItems() {
    return [
      Badge(
        label: items.badge,
        isLabelVisible: items.showBadge,
        backgroundColor: items.badgeColor,
        padding: items.badgePadding,
        alignment: const Alignment(0.17, -1.0),
        child: AnimatedCrossFade(
          firstChild: Container(
            alignment: Alignment.center,
            child: IconTheme(
              data: IconThemeData(
                color: itemColor,
                size: iconSize,
              ),
              child: selected ? items.selectedIcon ?? items.icon : items.icon,
            ),
          ),
          secondChild: Align(
            alignment: Alignment.center,
            child: WaterDrop(
              top: 0,
              color: items.backgroundColor,
              width: 48,
              height: 48,
              left: 0,
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: IconTheme(
                  data: IconThemeData(
                    color: itemColor,
                    size: iconSize,
                  ),
                  child: selected && items.selectedIcon != null
                      ? items.selectedIcon!
                      : items.icon,
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
      )
    ];
  }
}

class _AnimatedLabelWidget extends StatelessWidget {
  const _AnimatedLabelWidget({
    required this.animation,
    required this.item,
    required this.color,
    required this.iconStyle,
  });

  final Animation<double>? animation;
  final BottomBarItem item;
  final Color color;
  final IconStyle iconStyle;

  @override
  Widget build(BuildContext context) {
    if (item.title == null) return const SizedBox.shrink();

    final text = DefaultTextStyle.merge(
      style: TextStyle(
        fontSize: activeFontSize,
        fontWeight: FontWeight.w600,
        color: color,
      ),
      child: item.title!,
    );

    return Align(
      alignment: Alignment.center,
      heightFactor: 1.0,
      child: iconStyle == IconStyle.Default || animation == null
          ? text
          : FadeTransition(
              alwaysIncludeSemantics: true,
              opacity: animation!,
              child: text,
            ),
    );
  }
}

class _AnimatedIconWidget extends StatefulWidget {
  const _AnimatedIconWidget({
    required this.item,
    required this.selected,
    required this.iconSize,
    required this.barAnimation,
  });

  final BottomBarItem item;
  final bool selected;
  final double iconSize;
  final BarAnimation barAnimation;

  @override
  State<_AnimatedIconWidget> createState() => _AnimatedIconWidgetState();
}

class _AnimatedIconWidgetState extends State<_AnimatedIconWidget>
    with SingleTickerProviderStateMixin {
  AnimationController? _controller;
  Animation<Color?>? _animationColor;
  Animation<double>? _animation;

  @override
  void initState() {
    super.initState();
    _init();
    if (widget.selected) {
      _controller?.value = 1.0;
    }
  }

  void _init() {
    if (widget.barAnimation != BarAnimation.transform3D) {
      final ctrl = AnimationController(
        duration: const Duration(milliseconds: 300),
        reverseDuration: const Duration(milliseconds: 300),
        vsync: this,
      );
      _controller = ctrl;

      if (widget.barAnimation == BarAnimation.blink) {
        _animation = CurvedAnimation(parent: ctrl, curve: Curves.bounceIn);
      } else {
        _animation = CurvedAnimation(parent: ctrl, curve: Curves.ease);
      }

      _animationColor = ColorTween(
        begin: widget.item.backgroundColor ?? widget.item.unSelectedColor,
        end: widget.item.selectedColor,
      ).animate(_animation!);
    }
  }

  @override
  void didUpdateWidget(_AnimatedIconWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.selected != oldWidget.selected) {
      if (widget.selected) {
        _controller?.forward();
      } else {
        _controller?.reverse();
      }
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.barAnimation == BarAnimation.transform3D) {
      return _buildTransform3D();
    }

    if (_controller == null) return const SizedBox.shrink();

    return AnimatedBuilder(
      animation: _controller!,
      builder: (context, child) {
        return IconTheme(
          data: IconThemeData(
            color: widget.item.backgroundColor ??
                (widget.selected
                    ? _animationColor?.value ?? widget.item.selectedColor
                    : widget.item.unSelectedColor),
            size: widget.selected ? widget.iconSize + 4 : widget.iconSize,
          ),
          child: widget.selected
              ? (widget.item.selectedIcon ?? widget.item.icon)
              : widget.item.icon,
        );
      },
    );
  }

  Widget _buildTransform3D() {
    return IconTheme(
      data: IconThemeData(
        color: widget.item.backgroundColor ??
            (widget.selected
                ? widget.item.selectedColor
                : widget.item.unSelectedColor),
        size: widget.selected ? widget.iconSize + 4 : widget.iconSize,
      ),
      child: widget.selected
          ? Transform(
              transform: Matrix4.identity()
                ..setEntry(3, 0, 0.002)
                ..rotateY(0),
              child: widget.item.selectedIcon ?? widget.item.icon,
            )
          : widget.item.icon,
    );
  }
}
