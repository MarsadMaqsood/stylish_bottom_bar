import 'package:flutter/material.dart';
import 'package:stylish_bottom_bar/src/model/bottom_bar_option.dart';
import 'package:stylish_bottom_bar/src/utils/enums.dart';

/// Configuration options for the Bubble Bar.
class BubbleBarOptions extends BottomBarOption {
  ///BarStyle to align icon and title in horizontal or vertical
  ///[BubbleBarStyle.horizontal]
  ///[BubbleBarStyle.vertical]
  ///
  ///Default value is [BubbleBarStyle.horizontal]
  final BubbleBarStyle barStyle;

  ///Use this to customize the bubble background fill style
  ///You can use border with [BubbleFillStyle.outlined]
  ///and also fill the background with color using [BubbleFillStyle.fill]
  final BubbleFillStyle bubbleFillStyle;

  ///Change icon size
  ///
  ///Default is 26.0
  final double iconSize;

  ///Enable ink effect to bubble navigation bar item
  ///
  ///Default value is `false`
  final bool inkEffect;

  ///Border radius of the `BubbleBarItem`
  final BorderRadius? borderRadius;

  ///Add padding arround navigation tiles
  ///
  ///Default padding is [EdgeInsets.zero]
  final EdgeInsets padding;

  ///Change ink color
  ///
  ///Default color is [Colors.grey]
  final Color inkColor;

  /// Specifies the opacity of the navigation bar items' backgrounds.
  ///
  /// The default value is `0.8`.
  final double? opacity;

  BubbleBarOptions({
    this.barStyle = BubbleBarStyle.horizontal,
    this.bubbleFillStyle = BubbleFillStyle.fill,
    this.iconSize = 26.0,
    this.inkEffect = false,
    this.borderRadius,
    this.padding = EdgeInsets.zero,
    this.inkColor = Colors.grey,
    this.opacity = 0.8,
  });
}

class AnimatedBarOptions extends BottomBarOption {
  ///Change Icon size
  ///Default is 26.0
  final double iconSize;

  ///Add padding arround navigation tiles
  ///
  ///Default padding is `EdgeInsets.only(top: 6.0)` if badge is displayed
  /// otherwise `EdgeInsets.zero`
  final EdgeInsets? padding;

  ///Enable ink effect to bubble navigation bar item
  ///
  ///Default value is `false`
  final bool inkEffect;

  ///Change ink color
  ///
  ///Default color is [Colors.grey]
  final Color? inkColor;

  /// Specifies the opacity of the navigation bar items' backgrounds.
  /// The default value is `0.8`.
  final double? opacity;

  ///BarAnimation to animate items when current index changes
  ///[BarAnimation.fade]
  ///[BarAnimation.blink]
  ///[BarAnimation.transform3D]
  ///[BarAnimation.liquid]
  ///
  ///Default value is [BarAnimation.fade]
  final BarAnimation barAnimation;

  ///Change icon style
  ///`IconStyle.simple`
  ///`IconStyle.animated`
  ///
  ///[IconStyle.simple] is used to show icons without title and animations
  ///
  ///Default is [IconStyle.Default]
  final IconStyle? iconStyle;

  AnimatedBarOptions({
    this.iconSize = 26.0,
    this.padding,
    this.inkEffect = false,
    this.inkColor = Colors.grey,
    this.opacity = 0.8,
    this.barAnimation = BarAnimation.fade,
    this.iconStyle = IconStyle.Default,
  });
}

//

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

  DotBarOptions({
    this.iconSize = 26.0,
    this.padding,
    this.inkEffect = false,
    this.inkColor = Colors.grey,
    this.dotStyle = DotStyle.circle,
    this.gradient,
  });
}
