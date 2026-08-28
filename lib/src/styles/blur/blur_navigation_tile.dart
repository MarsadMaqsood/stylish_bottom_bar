import 'package:flutter/material.dart';
import 'package:stylish_bottom_bar/src/core/bottom_bar_constants.dart';
import 'package:stylish_bottom_bar/src/core/bottom_bar_item.dart';

/// A navigation tile for [BarBlurOptions].
///
/// Renders clean icon and label elements with smooth color transitions,
/// badge support, and label animations matching AnimatedNavigationTile's style.
class BlurNavigationTile extends StatelessWidget {
  const BlurNavigationTile(
    this.item,
    this.opacity,
    this.animation,
    this.iconSize, {
    super.key,
    this.onTap,
    this.flex,
    this.selected = false,
    this.indexLabel,
    this.ink = false,
    this.inkColor = Colors.grey,
    this.padding,
    this.itemBorderRadius,
  });

  final BottomBarItem item;
  final Animation<double>? animation;
  final double iconSize;
  final VoidCallback? onTap;
  final double? flex;
  final bool selected;
  final String? indexLabel;
  final double opacity;
  final bool ink;
  final Color? inkColor;
  final EdgeInsets? padding;
  final BorderRadius? itemBorderRadius;

  Color get itemColor =>
      item.backgroundColor ??
      (selected ? item.selectedColor : item.unSelectedColor);

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
              (item.showBadge
                  ? const EdgeInsets.only(top: 6.0)
                  : EdgeInsets.zero),
          child: InkWell(
            onTap: onTap,
            splashColor: ink ? (inkColor ?? Colors.grey) : Colors.transparent,
            highlightColor: Colors.transparent,
            borderRadius:
                itemBorderRadius ??
                const BorderRadius.horizontal(
                  right: Radius.circular(52),
                  left: Radius.circular(52),
                ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Badge(
                  label: item.badge,
                  isLabelVisible: item.showBadge,
                  backgroundColor: item.badgeColor,
                  padding: item.badgePadding,
                  child: IconTheme(
                    data: IconThemeData(
                      color: itemColor,
                      size: iconSize,
                    ),
                    child: selected
                        ? item.selectedIcon ?? item.icon
                        : item.icon,
                  ),
                ),
                if (item.title != null)
                  _BlurLabelWidget(
                    animation: animation,
                    item: item,
                    color: itemColor,
                    selected: selected,
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _BlurLabelWidget extends StatelessWidget {
  const _BlurLabelWidget({
    required this.animation,
    required this.item,
    required this.color,
    required this.selected,
  });

  final Animation<double>? animation;
  final BottomBarItem item;
  final Color color;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    if (item.title == null) return const SizedBox.shrink();

    final text = DefaultTextStyle.merge(
      style: TextStyle(
        fontSize: activeFontSize,
        fontWeight: selected ? FontWeight.w600 : FontWeight.w500,
        color: color,
      ),
      child: item.title!,
    );

    return Align(
      alignment: Alignment.center,
      heightFactor: 1.0,
      child: text,
    );
  }
}
