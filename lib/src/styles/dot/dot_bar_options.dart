import 'package:flutter/material.dart';
import 'package:stylish_bottom_bar/src/core/bottom_bar_item.dart';
import 'package:stylish_bottom_bar/src/core/bottom_bar_option.dart';
import 'package:stylish_bottom_bar/src/styles/dot/dot_navigation_tile.dart';
import 'package:stylish_bottom_bar/src/utils/enums.dart';

class DotBarOptions extends BottomBarOption {
  /// Specifies the size of the navigation bar icons.
  /// The default value is `26.0`.
  final double iconSize;

  /// Specifies the padding around the navigation bar tiles.
  /// The default padding is:
  /// * `EdgeInsets.only(top: 6.0)` if a badge is displayed.
  /// * `EdgeInsets.zero` otherwise.
  final EdgeInsets? padding;

  /// Specifies whether or not to enable the ink effect for the navigation bar items.
  /// The default value is `false`.
  final bool inkEffect;

  /// Specifies the color of the ink effect.
  /// The default color is `Colors.grey`.
  final Color? inkColor;

  /// Specifies the style of dot.
  ///
  /// * **`DotStyle.circle`:** Displays a circular dot.
  /// * **`DotStyle.tile`:** Displays a tiled dot.
  ///
  /// The default value is `DotStyle.circle`.
  final DotStyle dotStyle;

  /// Specifies the gradient to use for the dot.
  /// If not specified, the item's `selectedColor` will be used as the default color.
  final Gradient? gradient;

  const DotBarOptions({
    this.iconSize = 26.0,
    this.padding,
    this.inkEffect = false,
    this.inkColor = Colors.grey,
    this.dotStyle = DotStyle.circle,
    this.gradient,
  }) : assert(iconSize > 0, 'iconSize must be greater than 0');

  @override
  double get additionalBottomPadding => 4.0;

  @override
  Widget buildTile({
    required BuildContext context,
    required BottomBarItem item,
    required bool isSelected,
    required Animation<double> animation,
    required Animatable<double> flexTween,
    required VoidCallback? onTap,
    required String? indexLabel,
    required int index,
    required int totalLength,
  }) {
    return DotNavigationTiles(
      item,
      selected: isSelected,
      animation: animation,
      flex: flexTween.evaluate(animation),
      indexLabel: indexLabel,
      options: this,
      onTap: onTap,
    );
  }
}
