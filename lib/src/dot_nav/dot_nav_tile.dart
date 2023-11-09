import 'package:flutter/material.dart';
import 'package:stylish_bottom_bar/helpers/constant.dart';
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
    );
  }
}

class IconWidget extends StatelessWidget {
  const IconWidget({
    Key? key,
    required this.items,
    required this.selected,
    required this.iconSize,
  }) : super(key: key);

  final BottomBarItem items;
  final bool selected;
  final double iconSize;

  @override
  Widget build(BuildContext context) {
    return _buildWidget();
  }

  Widget _buildWidget() {
    return IconTheme(
      data: IconThemeData(
        color: items.backgroundColor ??
            (selected ? items.selectedColor : items.unSelectedColor),
        size: selected ? iconSize + 4 : iconSize,
      ),
      child: items.icon!,
    );
  }
}
