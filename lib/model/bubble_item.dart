import 'package:flutter/material.dart';

class BubbleBarItem {
  final Widget icon;
  final Widget? title;
  final Widget? activeIcon;
  final Widget? badge;
  final bool showBadge;
  final Color badgeColor;
  final Color? backgroundColor;
  final BorderRadius badgeRadius;

  ///Use this to change border color
  ///default color is [Colors.black]
  final Color? borderColor;

  BubbleBarItem({
    required this.icon,
    this.title,
    this.activeIcon,
    this.showBadge = false,
    this.badgeColor = Colors.black,
    this.backgroundColor = Colors.green,
    this.badge,
    this.badgeRadius = BorderRadius.zero,
    this.borderColor = Colors.black,
  });
}

class BottomBarItem {}
