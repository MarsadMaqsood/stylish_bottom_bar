import 'package:flutter/material.dart';
import 'package:stylish_bottom_bar/src/core/bottom_bar_item.dart';
import 'package:stylish_bottom_bar/src/core/bottom_bar_option.dart';
import 'package:stylish_bottom_bar/src/styles/animated/animated_navigation_tile.dart';
import 'package:stylish_bottom_bar/src/utils/enums.dart';

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
  final double opacity;

  ///BarAnimation to animate items when current index changes
  ///[BarAnimation.fade]
  ///[BarAnimation.blink]
  ///[BarAnimation.transform3D]
  ///[BarAnimation.liquid]
  ///
  ///Default value is [BarAnimation.fade]
  @override
  final BarAnimation barAnimation;

  /// Change icon style
  final IconStyle iconStyle;

  const AnimatedBarOptions({
    this.iconSize = 26.0,
    this.padding,
    this.inkEffect = false,
    this.inkColor = Colors.grey,
    this.opacity = 0.8,
    this.barAnimation = BarAnimation.fade,
    this.iconStyle = IconStyle.defaultStyle,
  }) : assert(iconSize > 0, 'iconSize must be greater than 0'),
       assert(
         opacity >= 0.0 && opacity <= 1.0,
         'opacity must be between 0.0 and 1.0',
       );

  @override
  double get additionalBottomPadding => 2.0;

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
    return AnimatedNavigationTiles(
      item,
      iconSize,
      padding: padding,
      inkEffect: inkEffect,
      inkColor: inkColor,
      selected: isSelected,
      opacity: opacity,
      animation: animation,
      flex: flexTween.evaluate(animation),
      indexLabel: indexLabel,
      barAnimation: barAnimation,
      iconStyle: iconStyle,
      onTap: onTap,
    );
  }
}
