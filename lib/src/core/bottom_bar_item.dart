import 'package:flutter/material.dart';

/// Represents an item in the bottom navigation bar.
class BottomBarItem {
  /// Creates an instance of [BottomBarItem].
  ///
  /// * [icon] is required and represents the item's icon.
  /// * [title] represents the item's title.
  /// * [selectedIcon] is an optional widget to display when the item is selected.
  /// * [backgroundColor] sets the item's background color.
  /// * [unSelectedColor] sets the color of the icon and text when the item is not selected. Defaults to [Colors.grey].
  /// * [selectedColor] sets the color of the icon and text when the item is selected. Defaults to [Colors.green].
  /// * [badge] is an optional widget to display as a badge.
  /// * [badgeColor] sets the badge's background color. Defaults to [Colors.grey].
  /// * [showBadge] determines whether to show the badge. Defaults to `false`.
  /// * [badgePadding] sets the padding around the badge.
  /// * [borderColor] sets the color of the border around the item. Defaults to [Colors.black].
  BottomBarItem({
    required this.icon,
    required this.title,
    this.selectedIcon,
    this.backgroundColor,
    this.unSelectedColor = Colors.grey,
    this.selectedColor = Colors.green,
    this.badge,
    this.badgeColor = Colors.grey,
    this.showBadge = false,
    this.badgePadding,
    this.borderColor = Colors.black,
  });

  /// The icon to display for this item.
  final Widget icon;

  /// The icon to display when this item is selected.
  final Widget? selectedIcon;

  /// The title of this item.
  final Widget? title;

  /// The widget to display as a badge.
  ///
  /// Example:
  /// ```dart
  /// badge: Text('90'),
  /// ```
  final Widget? badge;

  /// Whether to show the badge.
  ///
  /// Defaults to `false`.
  final bool showBadge;

  /// The background color of the badge.
  ///
  /// Defaults to [Colors.grey].
  final Color badgeColor;

  /// The padding around the badge.
  final EdgeInsetsGeometry? badgePadding;

  /// The color of the border around this item.
  ///
  /// Defaults to [Colors.black].
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

  /// The color of the icon and text when this item is selected.
  ///
  /// Defaults to [Colors.green].
  final Color selectedColor;

  /// The color of the icon and text when this item is not selected.
  ///
  /// Defaults to [Colors.grey].
  final Color unSelectedColor;
}
