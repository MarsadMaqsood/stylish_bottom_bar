import 'package:flutter/material.dart';
import 'package:stylish_bottom_bar/src/core/bottom_bar_item.dart';
import 'package:stylish_bottom_bar/src/core/bottom_bar_option.dart';
import 'package:stylish_bottom_bar/src/styles/bubble/bubble_navigation_tile.dart';
import 'package:stylish_bottom_bar/src/utils/enums.dart';

/// Configuration options for the Bubble Bar.
class BubbleBarOptions extends BottomBarOption {
  /// BarStyle to align icon and title in horizontal or vertical
  /// [BubbleBarStyle.horizontal]
  /// [BubbleBarStyle.vertical]
  ///
  /// Default value is [BubbleBarStyle.horizontal]
  final BubbleBarStyle barStyle;

  /// Use this to customize the bubble background fill style
  /// You can use border with [BubbleFillStyle.outlined]
  /// and also fill the background with color using [BubbleFillStyle.fill]
  final BubbleFillStyle bubbleFillStyle;

  /// Change icon size (default is 26.0)
  final double iconSize;

  /// Enable ink effect to bubble navigation bar item (default is `false`)
  final bool inkEffect;

  /// Border radius of the `BubbleBarItem`
  final BorderRadius? borderRadius;

  /// Add padding around navigation tiles (default is [EdgeInsets.zero])
  final EdgeInsets padding;

  /// Change ink color (default is [Colors.grey])
  final Color inkColor;

  /// Specifies the opacity of the navigation bar items' backgrounds.
  /// The default value is `0.2`.
  final double opacity;

  const BubbleBarOptions({
    this.barStyle = BubbleBarStyle.horizontal,
    this.bubbleFillStyle = BubbleFillStyle.fill,
    this.iconSize = 26.0,
    this.inkEffect = false,
    this.borderRadius,
    this.padding = EdgeInsets.zero,
    this.inkColor = Colors.grey,
    this.opacity = 0.2,
  }) : assert(iconSize > 0, 'iconSize must be greater than 0'),
       assert(
         opacity >= 0.0 && opacity <= 1.0,
         'opacity must be between 0.0 and 1.0',
       );

  @override
  double get additionalBottomPadding => 4.0;

  @override
  bool get requiresControllerListener => true;

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
    return BubbleNavigationTile(
      item,
      opacity,
      animation,
      iconSize,
      barStyle,
      onTap: onTap,
      flex: flexTween.evaluate(animation),
      selected: isSelected,
      indexLabel: indexLabel,
      ink: inkEffect,
      inkColor: inkColor,
      padding: padding,
      fillStyle: bubbleFillStyle,
      itemBorderRadius: borderRadius,
    );
  }
}
