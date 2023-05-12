import 'package:flutter/material.dart';
import 'package:stylish_bottom_bar/model/bar_items.dart';
import 'package:stylish_bottom_bar/src/badge/badge.dart' as badge;

enum BadgeAnimationType {
  slide,
  fade,
  scale,
}

enum BadgeShape { circle, square }

class IconWidget extends StatelessWidget {
  const IconWidget({
    super.key,
    required this.animation,
    required this.iconSize,
    required this.selected,
    required this.item,
    required this.unselectedIconColor,
  });

  final Animation<double> animation;
  final double iconSize;
  final bool selected;
  final Color? unselectedIconColor;
  final BottomBarItem item;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      heightFactor: 1.0,
      child: badge.Badge(
        showBadge: item.showBadge,
        badgeContent: item.badge,
        badgeColor: item.badgeColor,
        animationType: BadgeAnimationType.fade,
        borderRadius: item.badgeRadius,
        child: IconTheme(
          data: IconThemeData(
            color: selected
                ? item.backgroundColor ?? item.selectedColor
                : unselectedIconColor,
            size: iconSize,
          ),
          child: selected
              ? item.selectedIcon != null
                  ? item.selectedIcon!
                  : item.icon!
              : item.icon!,
        ),
      ),
    );
  }
}
