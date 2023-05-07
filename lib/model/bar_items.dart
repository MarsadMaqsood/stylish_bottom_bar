import 'package:flutter/material.dart';

class BottomBarItem {
  BottomBarItem({
    required this.icon,
    required this.title,
    this.selectedIcon,
    this.backgroundColor,
    // this.backgroundColor = Colors.black,
    this.unSelectedColor = Colors.grey,
    this.selectedColor = Colors.green,
    //
    this.badge,
    this.badgeColor = Colors.grey,
    this.showBadge = false,
    this.badgeRadius = BorderRadius.zero,
    this.borderColor = Colors.black,
  });

  ///Use this to add item icon
  final Widget? icon;

  ///Use this to change the selected item icon
  final Widget? selectedIcon;

  ///Use this to add item title
  final Widget? title;

  ///Set widget to display as a badge
  ///
  ///```dart
  ///badge: Text('90'),
  ///```
  final Widget? badge;

  ///Use this to show or hide the badge
  ///
  ///default is `false`
  final bool showBadge;

  ///Change the badge color
  ///
  ///default is [Colors.black]
  final Color badgeColor;

  ///Use this to customize the badge [BorderRadius]
  ///
  ///default is [BorderRadius.zero]
  final BorderRadius badgeRadius;

  ///Use this to change the border color
  ///
  ///default color is [Colors.black]
  final Color borderColor;

  ///The `backgroundColor` property is used to assign a [backgroundColor] to [BottomBarItem].
  /// If a value is assigned to this property, the [BottomBarItem] will be displayed
  /// with the specified [backgroundColor]. If value is not assigned or null,
  /// the [selectedColor] and [unSelectedColor] properties will be
  /// used to determine the color of the [BottomBarItem].
  ///
  /// When using the `BubbleBarOptions` the [backgroundColor] will also be
  /// used to change the background color [selectedColor]
  ///  and [unSelectedColor] and [borderColor] of the item
  final Color? backgroundColor;

  ///Use this to change the selected item's icon color
  ///default color is [Colors.green]
  final Color selectedColor;

  ///Use this to change the unselected item's icon color
  ///default color is [Colors.grey]
  final Color unSelectedColor;
}
