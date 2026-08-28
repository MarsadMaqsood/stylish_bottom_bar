import 'package:flutter/material.dart';
import 'package:stylish_bottom_bar/src/core/bottom_bar_item.dart';
import 'package:stylish_bottom_bar/src/styles/animated/widgets/animated_icon_widget.dart';
import 'package:stylish_bottom_bar/src/styles/animated/widgets/animated_label_widget.dart';
import 'package:stylish_bottom_bar/src/styles/animated/widgets/drop_tile_layout.dart';
import 'package:stylish_bottom_bar/src/styles/animated/widgets/liquid_tile_layout.dart';
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

  Color get itemColor =>
      items.backgroundColor ??
      (selected ? items.selectedColor : items.unSelectedColor);

  Color get itemColorOnSelected => items.backgroundColor ?? items.selectedColor;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Semantics(
        container: true,
        header: true,
        selected: selected,
        label: indexLabel,
        child: Padding(
          padding:
              padding ??
              (items.showBadge && iconStyle != IconStyle.simple
                  ? const EdgeInsets.only(top: 6.0)
                  : EdgeInsets.zero),
          child: InkWell(
            onTap: onTap,
            splashColor: (inkEffect ?? false)
                ? (inkColor ?? Colors.grey)
                : Colors.transparent,
            highlightColor: Colors.transparent,
            borderRadius: const BorderRadius.horizontal(
              right: Radius.circular(52),
              left: Radius.circular(52),
            ),
            child: _buildTileContent(),
          ),
        ),
      ),
    );
  }

  Widget _buildTileContent() {
    switch (barAnimation) {
      case BarAnimation.liquid:
        return LiquidTileLayout(
          item: items,
          selected: selected,
          iconSize: iconSize,
          iconStyle: iconStyle,
          animation: animation,
          itemColor: itemColor,
          itemColorOnSelected: itemColorOnSelected,
        );
      case BarAnimation.drop:
        return DropTileLayout(
          item: items,
          selected: selected,
          iconSize: iconSize,
          itemColor: itemColor,
        );
      default:
        return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: selected
              ? MainAxisAlignment.spaceEvenly
              : MainAxisAlignment.center,
          children: _childItems(),
        );
    }
  }

  List<Widget> _childItems() {
    final isDefault =
        iconStyle == IconStyle.Default || iconStyle == IconStyle.defaultStyle;

    if (isDefault) {
      return [
        Align(
          alignment: Alignment.center,
          child: Badge(
            label: items.badge,
            isLabelVisible: items.showBadge,
            backgroundColor: items.badgeColor,
            padding: items.badgePadding,
            // child: IconTheme(
            //   data: IconThemeData(color: itemColor, size: iconSize),
            //   child: selected ? items.selectedIcon ?? items.icon : items.icon,
            // ),
            child: AnimatedIconWidget(
              item: items,
              selected: selected,
              iconSize: iconSize,
              barAnimation: barAnimation,
              animation: animation,
            ),
          ),
        ),
        AnimatedLabelWidget(
          iconStyle: iconStyle,
          animation: animation,
          item: items,
          color: itemColor,
        ),
      ];
    }

    if (iconStyle == IconStyle.animated) {
      final label = AnimatedLabelWidget(
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
          child: AnimatedIconWidget(
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
      ];
    }

    // IconStyle.simple or other
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
              size: selected ? iconSize + 4 : iconSize,
            ),
            child: selected ? items.selectedIcon ?? items.icon : items.icon,
          ),
        ),
      ),
    ];
  }
}
