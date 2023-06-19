import 'package:flutter/material.dart';
import 'package:stylish_bottom_bar/helpers/bottom_bar.dart';
import 'package:stylish_bottom_bar/helpers/enums.dart';

class BubbleBarOptions extends BottomBarOption {
  ///Change unselected item color
  ///If you don't want to change every single icon color use this property
  ///this will bulk change all the unselected icon color which does'nt have color property.
  ///
  ///If icon color not provided then
  ///default unselected icon color is [Colors.black]
  ///this is also used to set bulk color to unselected icons
  final Color unselectedIconColor;

  ///BarStyle to align icon and title in horizontal or vertical
  ///[BubbleBarStyle.horizotnal]
  ///[BubbleBarStyle.vertical]
  ///Default value is [BubbleBarStyle.horizotnal]
  final BubbleBarStyle barStyle;

  ///Use this to customize the bubble background fill style
  ///You can use border with [BubbleFillStyle.outlined]
  ///and also fill the background with color using [BubbleFillStyle.fill]
  final BubbleFillStyle bubbleFillStyle;

  ///Change Icon size
  ///Default is 26.0
  final double iconSize;

  ///Enable ink effect to bubble navigation bar item
  ///Default value is `false`
  final bool inkEffect;

  ///Border radius of the `BubbleBarItem`
  final BorderRadius? borderRadius;

  ///Add padding arround navigation tiles
  ///Default padding is [EdgeInsets.zero]
  final EdgeInsets padding;

  ///Change ink color
  ///
  ///Default color is [Colors.grey]
  final Color inkColor;

  ///Change navigation bar items background color opacity
  final double? opacity;

  BubbleBarOptions({
    this.barStyle = BubbleBarStyle.horizotnal,
    this.bubbleFillStyle = BubbleFillStyle.fill,
    this.iconSize = 26.0,
    this.inkEffect = false,
    this.unselectedIconColor = Colors.black,
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

  ///Change navigation bar items background color opacity
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
