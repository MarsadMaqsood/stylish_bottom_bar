import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:stylish_bottom_bar/src/core/bottom_bar_item.dart';
import 'package:stylish_bottom_bar/src/core/bottom_bar_option.dart';
import 'package:stylish_bottom_bar/src/styles/blur/blur_navigation_tile.dart';

/// Configuration for floating translucent and glassmorphic bottom bar navigation.
class BarBlurOptions extends BottomBarOption {
  /// Standard Gaussian blur sigma X (default: 12.0)
  final double sigmaX;

  /// Standard Gaussian blur sigma Y (default: 12.0)
  final double sigmaY;

  /// Whether blur is active
  final bool enabled;

  /// Whether to use the custom liquid glass fragment shader
  final bool useShader;

  /// Optional custom FragmentShader for advanced refraction & chromatic dispersion
  final ui.FragmentShader? customShader;

  /// Refraction index multiplier when using custom shaders (default: 0.0255)
  final double refraction;

  /// Chromatic dispersion intensity for rainbow rim highlights (default: 0.0039)
  final double dispersion;

  /// Icon size (default: 26.0)
  final double iconSize;

  /// Enable ink splash effect
  final bool inkEffect;

  /// Splash ink color
  final Color inkColor;

  /// Opacity of the selected item's background pill
  final double opacity;

  /// Padding around each navigation tile
  final EdgeInsets padding;

  /// Border radius of the selected item pill
  final BorderRadius? borderRadius;

  final double bevelDepth;

  /// Default constructor for standard frosted blur effect.
  const BarBlurOptions({
    this.sigmaX = 12.0,
    this.sigmaY = 12.0,
    this.enabled = true,
    this.iconSize = 26.0,
    this.inkEffect = false,
    this.inkColor = Colors.grey,
    this.opacity = 0.8,
    this.padding = EdgeInsets.zero,
    this.borderRadius,
  }) : useShader = false,
       customShader = null,
       refraction = 0.0255,
       dispersion = 0.0039,
       bevelDepth = 9.0,
       assert(iconSize > 0, 'iconSize must be greater than 0'),
       assert(
         opacity >= 0.0 && opacity <= 1.0,
         'opacity must be between 0.0 and 1.0',
       );

  /// Preset for standard frosted glass with a single [sigma] parameter.
  const BarBlurOptions.frosted({
    double sigma = 14.0,
    bool enabled = true,
    double iconSize = 26.0,
    bool inkEffect = false,
    Color inkColor = Colors.grey,
    double opacity = 0.8,
    EdgeInsets padding = EdgeInsets.zero,
    BorderRadius? borderRadius,
  }) : this(
         sigmaX: sigma,
         sigmaY: sigma,
         enabled: enabled,
         iconSize: iconSize,
         inkEffect: inkEffect,
         inkColor: inkColor,
         opacity: opacity,
         padding: padding,
         borderRadius: borderRadius,
       );

  /// Preset for Apple-style liquid glass with refraction shader.
  const BarBlurOptions.liquidGlass({
    double sigma = 24.0,
    this.refraction = 0.0255,
    this.dispersion = 0.0039,
    this.bevelDepth = 9.0,
    ui.FragmentShader? shader,
    this.iconSize = 26.0,
    this.inkEffect = false,
    this.inkColor = Colors.grey,
    this.opacity = 0.8,
    this.padding = EdgeInsets.zero,
    this.borderRadius,
    this.useShader = true,
    this.enabled = true,
  }) : sigmaX = sigma,
       sigmaY = sigma,
       customShader = shader,
       assert(iconSize > 0, 'iconSize must be greater than 0'),
       assert(
         opacity >= 0.0 && opacity <= 1.0,
         'opacity must be between 0.0 and 1.0',
       );

  /// Advanced constructor for raw control over all parameters.
  const BarBlurOptions.custom({
    this.sigmaX = 12.0,
    this.sigmaY = 12.0,
    this.enabled = true,
    this.useShader = false,
    this.customShader,
    this.refraction = 0.0255,
    this.dispersion = 0.0039,
    this.bevelDepth = 9.0,
    this.iconSize = 26.0,
    this.inkEffect = false,
    this.inkColor = Colors.grey,
    this.opacity = 0.8,
    this.padding = EdgeInsets.zero,
    this.borderRadius,
  }) : assert(iconSize > 0, 'iconSize must be greater than 0'),
       assert(
         opacity >= 0.0 && opacity <= 1.0,
         'opacity must be between 0.0 and 1.0',
       );

  @override
  double get additionalBottomPadding => 8.0;

  @override
  bool get requiresControllerListener => true;

  @override
  Widget buildTile({
    required BuildContext context,
    required BottomBarItem item,
    required bool isSelected,
    required Animation<double> animation,
    required Animatable<double> flexTween,
    required ui.VoidCallback? onTap,
    required String? indexLabel,
    required int index,
    required int totalLength,
  }) {
    return BlurNavigationTile(
      item,
      opacity,
      animation,
      iconSize,
      onTap: onTap,
      flex: flexTween.evaluate(animation),
      selected: isSelected,
      indexLabel: indexLabel,
      ink: inkEffect,
      inkColor: inkColor,
      padding: padding,
      itemBorderRadius: borderRadius,
    );
  }
}
