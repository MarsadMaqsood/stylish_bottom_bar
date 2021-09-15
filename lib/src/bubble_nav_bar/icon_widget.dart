import 'package:badges/badges.dart';
import 'package:flutter/material.dart';

import 'bubble_item.dart';

class IconWidget extends StatelessWidget {
  const IconWidget({
    Key? key,
    required this.animation,
    required this.iconSize,
    required this.selected,
    required this.item,
    required this.unselectedIconColor,
  }) : super(key: key);

  final Animation<double> animation;
  final double iconSize;
  final bool selected;
  final Color? unselectedIconColor;
  final BubbleBarItem item;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      heightFactor: 1.0,
      child: Badge(
        showBadge: item.showBadge,
        badgeContent: item.badge,
        badgeColor: item.badgeColor,
        animationType: BadgeAnimationType.fade,
        child: Container(
          child: IconTheme(
            data: IconThemeData(
              color: selected ? item.backgroundColor : unselectedIconColor,
              size: iconSize,
            ),
            child: selected
                ? item.activeIcon != null
                    ? item.activeIcon!
                    : item.icon
                : item.icon,
          ),
        ),
      ),
    );
  }
}
