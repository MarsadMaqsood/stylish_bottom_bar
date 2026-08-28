import 'dart:developer' as developer;
import 'dart:math' as math;
import 'dart:ui' as ui;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:stylish_bottom_bar/src/core/bottom_bar_constants.dart';
import 'package:stylish_bottom_bar/src/core/bottom_bar_item.dart';
import 'package:stylish_bottom_bar/src/core/bottom_bar_option.dart';
import 'package:stylish_bottom_bar/src/core/liquid_glass_shader.dart';
import 'package:stylish_bottom_bar/src/shared/clippers/bar_clipper.dart';
import 'package:stylish_bottom_bar/src/styles/blur/bar_blur_options.dart';
import 'package:stylish_bottom_bar/src/utils/enums.dart';

///[StylishBottomBar] class to implement beautiful bottom bar widget
///
///```dart
///
/// StylishBottomBar(
///   items: [
///     BottomBarItem(
///       icon: Icon(
///               Icons.home,
///         ),
///       selectedColor: Colors.deepPurple,
///       backgroundColor: Colors.amber,
///       title: Text('Home')),
///     BottomBarItem(
///       icon: Icon(
///               Icons.add_circle_outline,
///         ),
///       selectedColor: Colors.green,
///       backgroundColor: Colors.amber,
///       title: Text('Add')),
///     BottomBarItem(
///       icon: Icon(
///               Icons.person,
///         ),
///       backgroundColor: Colors.amber,
///       selectedColor: Colors.pinkAccent,
///       title: Text('Profile')),
///    ],
///    option: AnimatedBarOptions(
///        iconStyle: IconStyle.animated,
///        barAnimation: BarAnimation.liquid,
///        opacity: 0.3,
///    ),
///    onTap: (index) {
///        setState(() {
///            selected = index;
///        });
///    },
///
///  );
///
///```
class StylishBottomBar extends StatefulWidget {
  StylishBottomBar({
    super.key,
    required this.items,
    this.backgroundColor,
    this.elevation = 8.0,
    this.currentIndex = 0,
    this.onTap,
    this.borderRadius,
    this.fabLocation,
    this.hasNotch = false,
    required this.option,
    this.gradient,
    this.iconSpace = 1.5,
    this.notchStyle = NotchStyle.themeDefault,
    this.margin,
    this.border,
    this.boxShadow,
  }) : assert(
         items.length >= 2,
         '\n\nStylish Bottom Navigation must have 2 or more items',
       ),
       assert(
         items.every((BottomBarItem item) => item.title != null),
         '\n\nEvery item must have a non-null title',
       ),
       assert(
         currentIndex >= 0 && currentIndex < items.length,
         '\n\nCurrent index is out of bounds. Provided: $currentIndex Bounds: 0 to ${items.length - 1}',
       ),
       assert(elevation >= 0, 'elevation must be non-negative'),
       assert(iconSpace >= 0, 'iconSpace must be non-negative');

  /// Add navigation bar items
  final List<BottomBarItem> items;

  /// Change animated navigation bar background color
  final Color? backgroundColor;

  /// Add elevation to bottom navigation bar (default value is 8.0)
  final double elevation;

  /// Used to change the selected item index (default value is 0)
  final int currentIndex;

  ///Add notch effect to floating action button
  ///
  ///to make floating action button notch transparent set extendBody to true in scaffold
  ///
  ///```dart
  ///  return Scaffold(
  ///     extendBody: true
  ///
  ///   ...
  ///   );
  ///```
  final bool hasNotch;

  ///Function to return current selected item index
  ///
  ///```dart
  /// onTap: (index){
  ///
  /// },
  ///
  ///```
  final ValueChanged<int>? onTap;

  /// Change navigation bar border radius
  final BorderRadius? borderRadius;

  ///Adjust bubble navigation items according to the fab location
  ///
  ///You can change Fab Location [StylishBarFabLocation.center]
  ///
  ///and [StylishBarFabLocation.end]
  final StylishBarFabLocation? fabLocation;

  /// Customize bottom bar items style and other properties
  ///
  /// You can use
  /// [AnimatedBarOptions] and [BubbleBarOptions]
  /// to change the properties.
  final BottomBarOption option;

  /// The gradient property defines a gradient color pattern for the widget.
  /// The gradient can be used to add a colorful background or add gradient colors to the widget.
  /// The gradient is defined using the [Gradient] class, which provides various options to specify the gradient colors and direction.
  /// Example usage:
  /// ```dart
  /// final gradient = LinearGradient(
  ///   colors: [Colors.red, Colors.yellow],
  ///   begin: Alignment.topLeft,
  ///   end: Alignment.bottomRight,
  /// );
  /// ```
  final Gradient? gradient;

  /// Assign icon space
  final double iconSpace;

  /// Specify the notch style
  ///
  /// [NotchStyle.circle]
  ///
  /// [NotchStyle.square] * Similar to material3
  ///
  /// [NotchStyle.themeDefault] * Depends on the `Theme.of(context).useMaterial3`
  final NotchStyle notchStyle;

  /// Margins around the bottom bar for floating capsule layouts
  final EdgeInsetsGeometry? margin;

  /// Border decoration around the bottom bar (e.g. for specular glass edges)
  final BoxBorder? border;

  /// Custom shadows for the bottom bar container
  final List<BoxShadow>? boxShadow;

  @override
  State<StylishBottomBar> createState() => _StylishBottomBarState();
}

class _StylishBottomBarState extends State<StylishBottomBar>
    with TickerProviderStateMixin {
  List<AnimationController> _controllers = <AnimationController>[];
  List<CurvedAnimation> _animations = <CurvedAnimation>[];

  ValueListenable<ScaffoldGeometry>? _geometryListenable;
  late Animatable<double> _flexTween;
  ui.FragmentShader? _glassShader;

  int _previousIndex = 0;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _geometryListenable = Scaffold.geometryOf(context);
    _flexTween = widget.hasNotch
        ? Tween<double>(begin: 1.15, end: 2.0)
        : Tween<double>(begin: 1.15, end: 1.75);
  }

  void _initAnimations() {
    _disposeAnimations();

    _controllers = List<AnimationController>.generate(widget.items.length, (
      int index,
    ) {
      return AnimationController(
        duration: const Duration(milliseconds: 200),
        vsync: this,
      )..addListener(() {
        if (widget.option.requiresControllerListener) {
          setState(() {});
        }
      });
    });

    _animations = List<CurvedAnimation>.generate(widget.items.length, (
      int index,
    ) {
      return CurvedAnimation(
        parent: _controllers[index],
        curve: Curves.fastOutSlowIn,
        reverseCurve: Curves.fastOutSlowIn.flipped,
      );
    });

    final safeIndex = widget.currentIndex.clamp(0, widget.items.length - 1);
    _controllers[safeIndex].value = 1.0;
  }

  void _disposeAnimations() {
    for (final animation in _animations) {
      animation.dispose();
    }
    _animations = [];
    for (final controller in _controllers) {
      controller.dispose();
    }
    _controllers = [];
  }

  @override
  void initState() {
    super.initState();
    _initAnimations();
    _initShader();
  }

  void _initShader() {
    if (widget.option is BarBlurOptions) {
      final opt = widget.option as BarBlurOptions;
      if (opt.customShader != null) {
        _glassShader = opt.customShader;
      } else if (opt.useShader) {
        LiquidGlassShader.load()
            .then((program) {
              if (mounted && program != null) {
                setState(() {
                  _glassShader = program.fragmentShader();
                });

                if (kDebugMode) {
                  developer.log(
                    'LiquidGlassShader loaded successfully',
                    name: 'stylish_bottom_bar',
                  );
                }
              }
            })
            .catchError((error, stackTrace) {
              if (kDebugMode) {
                developer.log(
                  'Failed to load LiquidGlassShader',
                  name: 'stylish_bottom_bar',
                  error: error,
                  stackTrace: stackTrace,
                );
              }
            });
      }
    }
  }

  @override
  void dispose() {
    _disposeAnimations();
    super.dispose();
  }

  @override
  void didUpdateWidget(StylishBottomBar oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.option != oldWidget.option) {
      _initShader();
    }

    if (widget.items.length != oldWidget.items.length) {
      _initAnimations();
      return;
    }

    if (widget.currentIndex != oldWidget.currentIndex) {
      _previousIndex = oldWidget.currentIndex;
      final oldIndex = oldWidget.currentIndex.clamp(0, _controllers.length - 1);
      final newIndex = widget.currentIndex.clamp(0, _controllers.length - 1);
      _controllers[oldIndex].reverse();
      _controllers[newIndex].forward();
    }
  }

  double _getTabCenterX(int index) {
    final mediaQuery = MediaQuery.of(context);
    final resolvedMargin =
        widget.margin?.resolve(Directionality.of(context)) ?? EdgeInsets.zero;
    final barWidth = mediaQuery.size.width - resolvedMargin.horizontal;
    final isBlur =
        widget.option is BarBlurOptions &&
        (widget.option as BarBlurOptions).enabled;
    final hPadding = isBlur ? 4.0 : 10.0;
    final usableWidth = barWidth - (hPadding * 2);
    final tabWidth = usableWidth / widget.items.length;
    return hPadding + (tabWidth * index) + (tabWidth * 0.5);
  }

  bool _isUsingMaterial3(BuildContext context) {
    return widget.notchStyle == NotchStyle.themeDefault
        ? Theme.of(context).useMaterial3
        : widget.notchStyle == NotchStyle.square;
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final localizations = MaterialLocalizations.of(context);
    final isM3 = _isUsingMaterial3(context);

    final additionalBottomPadding =
        math.max(mediaQuery.padding.bottom - bottomMargin, 0.0) +
        widget.option.additionalBottomPadding;

    final List<Widget> listWidget = List<Widget>.generate(widget.items.length, (
      i,
    ) {
      return widget.option.buildTile(
        context: context,
        item: widget.items[i],
        isSelected: i == widget.currentIndex,
        animation: _animations[i],
        flexTween: _flexTween,
        onTap: () => widget.onTap?.call(i),
        indexLabel: localizations.tabLabel(
          tabIndex: i + 1,
          tabCount: widget.items.length,
        ),
        index: i,
        totalLength: widget.items.length,
      );
    });

    if (widget.fabLocation == StylishBarFabLocation.center) {
      widget.option.insertCenterFabSpacer(listWidget);
    }

    final isBlur =
        widget.option is BarBlurOptions &&
        (widget.option as BarBlurOptions).enabled;
    final blurOptions = isBlur ? widget.option as BarBlurOptions : null;

    final effectiveGradient = isBlur ? null : widget.gradient;

    final effectiveBorder = isBlur ? null : widget.border;

    final defaultBgColor = isBlur
        ? Colors.transparent
        : (widget.backgroundColor ?? Colors.white);

    final effectiveShadow = isBlur ? null : widget.boxShadow;

    final effectiveElevation = (isBlur || widget.boxShadow != null)
        ? 0.0
        : widget.elevation;

    Widget content = Container(
      decoration: BoxDecoration(
        borderRadius: widget.borderRadius,
        gradient: effectiveGradient,
        color: effectiveGradient == null
            ? (widget.backgroundColor ?? defaultBgColor)
            : null,
        border: effectiveBorder,
        boxShadow: effectiveShadow,
      ),
      child: _innerWidget(
        context,
        additionalBottomPadding,
        widget.fabLocation,
        listWidget,
        widget.option.barAnimation,
        isBlur,
      ),
    );

    if (isBlur && blurOptions != null) {
      ui.ImageFilter filter;
      if (_glassShader != null && blurOptions.useShader) {
        ui.FragmentShader glassShader = buildShadderValues(
          _glassShader!,
          additionalBottomPadding,
        );

        filter = ui.ImageFilter.shader(glassShader);
      } else {
        filter = ui.ImageFilter.blur(
          sigmaX: blurOptions.sigmaX,
          sigmaY: blurOptions.sigmaY,
        );
      }

      content = ClipRRect(
        borderRadius: widget.borderRadius ?? BorderRadius.zero,
        child: BackdropFilter(filter: filter, child: content),
      );
    }

    Widget barWidget = Semantics(
      explicitChildNodes: true,
      child: widget.hasNotch
          ? PhysicalShape(
              elevation: effectiveElevation,
              color: widget.backgroundColor ?? defaultBgColor,
              clipper: BarClipper(
                shape: isM3
                    ? const AutomaticNotchedShape(
                        RoundedRectangleBorder(),
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(18)),
                        ),
                      )
                    : const CircularNotchedRectangle(),
                geometry: _geometryListenable!,
                notchMargin: isM3 ? 6.0 : 8.0,
              ),
              child: ClipPath(
                clipper: BarClipper(
                  shape: isM3
                      ? const AutomaticNotchedShape(
                          RoundedRectangleBorder(),
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(18)),
                          ),
                        )
                      : const CircularNotchedRectangle(),
                  geometry: _geometryListenable!,
                  notchMargin: isM3 ? 6.0 : 8.0,
                ),
                child: content,
              ),
            )
          : Material(
              elevation: effectiveElevation,
              borderRadius: widget.borderRadius,
              color: Colors.transparent,
              child: content,
            ),
    );

    if (widget.margin != null) {
      barWidget = Padding(padding: widget.margin!, child: barWidget);
    }

    return barWidget;
  }

  Widget _innerWidget(
    BuildContext context,
    double additionalBottomPadding,
    StylishBarFabLocation? fabLocation,
    List<Widget> children, [
    BarAnimation? barAnimation,
    bool isBlur = false,
  ]) {
    final isLiquid = barAnimation == BarAnimation.liquid;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: isBlur ? 4.0 : 10),
      child: ConstrainedBox(
        constraints: BoxConstraints(
          minHeight: kBottomNavigationBarHeight + additionalBottomPadding,
        ),
        child: Material(
          type: MaterialType.transparency,
          child: Padding(
            padding: EdgeInsets.only(
              bottom: isLiquid ? 0 : additionalBottomPadding,
              right: fabLocation == StylishBarFabLocation.end ? 72 : 0,
            ),
            child: MediaQuery.removePadding(
              context: context,
              removeBottom: true,
              child: DefaultTextStyle.merge(
                overflow: TextOverflow.ellipsis,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: children,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  ui.FragmentShader buildShadderValues(
    ui.FragmentShader glassShader,
    double additionalBottomPadding,
  ) {
    final mediaQuery = MediaQuery.of(context);
    final pixelRatio = mediaQuery.devicePixelRatio;
    final screenSize = mediaQuery.size * pixelRatio;

    final renderBox = context.findRenderObject() as RenderBox?;
    final resolvedMargin =
        widget.margin?.resolve(Directionality.of(context)) ?? EdgeInsets.zero;

    final hasLayout = renderBox != null && renderBox.hasSize;
    final rawOffset = hasLayout
        ? renderBox.localToGlobal(Offset.zero)
        : Offset(
            0.0,
            mediaQuery.size.height -
                (kBottomNavigationBarHeight + additionalBottomPadding) -
                resolvedMargin.bottom -
                resolvedMargin.top,
          );

    final originX = (rawOffset.dx + resolvedMargin.left) * pixelRatio;
    final originY = (rawOffset.dy + resolvedMargin.top) * pixelRatio;

    final barRenderWidth = hasLayout
        ? renderBox.size.width - resolvedMargin.horizontal
        : mediaQuery.size.width - resolvedMargin.horizontal;
    final barRenderHeight = hasLayout
        ? renderBox.size.height - resolvedMargin.vertical
        : kBottomNavigationBarHeight + additionalBottomPadding;

    final barWidth = barRenderWidth * pixelRatio;
    final barHeight = barRenderHeight * pixelRatio;

    final cornerRadius = widget.borderRadius?.topLeft.x ?? 33.5;

    final blurOpt = widget.option is BarBlurOptions
        ? widget.option as BarBlurOptions
        : null;
    final refraction = blurOpt?.refraction ?? 0.0255;
    final dispersion = blurOpt?.dispersion ?? 0.0039;
    final bevelDepth = blurOpt?.bevelDepth ?? 9.0;

    // Selected Tab Capsule Calculations
    final hPadding = 4.0 * pixelRatio;
    final usableWidth = barWidth - (hPadding * 2);
    final tabWidth = usableWidth / widget.items.length;

    //
    final startX = _getTabCenterX(_previousIndex);
    final endX = _getTabCenterX(widget.currentIndex);
    final animValue =
        _animations.isNotEmpty && widget.currentIndex < _animations.length
        ? _animations[widget.currentIndex].value
        : 1.0;
    final currentTabX = ui.lerpDouble(startX, endX, animValue) ?? endX;
    //

    final activeCenterX = currentTabX * pixelRatio;
    final activeCenterY = barHeight * 0.5;

    final pillHalfWidth = tabWidth * 0.50; // 0.5000 ratio
    final pillHalfHeight = barHeight * 0.4373; // 0.4373 ratio
    final pillRadius = pillHalfHeight;

    // Passing calibrated values directly into the shader
    _glassShader!.setFloat(0, screenSize.width);
    _glassShader!.setFloat(1, screenSize.height);
    _glassShader!.setFloat(2, originX);
    _glassShader!.setFloat(3, originY);
    _glassShader!.setFloat(4, barWidth);
    _glassShader!.setFloat(5, barHeight);
    _glassShader!.setFloat(6, cornerRadius * pixelRatio);
    _glassShader!.setFloat(7, refraction);
    _glassShader!.setFloat(8, dispersion);
    _glassShader!.setFloat(9, bevelDepth * pixelRatio);
    _glassShader!.setFloat(10, 1.0); // Tint R
    _glassShader!.setFloat(11, 1.0); // Tint G
    _glassShader!.setFloat(12, 1.0); // Tint B
    _glassShader!.setFloat(13, 0.0); // Tint Alpha
    _glassShader!.setFloat(14, activeCenterX);
    _glassShader!.setFloat(15, activeCenterY);
    _glassShader!.setFloat(16, pillHalfWidth);
    _glassShader!.setFloat(17, pillHalfHeight);
    _glassShader!.setFloat(18, pillRadius);
    _glassShader!.setFloat(19, 1.0); // Pill R
    _glassShader!.setFloat(20, 1.0); // Pill G
    _glassShader!.setFloat(21, 1.0); // Pill B
    _glassShader!.setFloat(22, 0.0); // Pill Alpha (Pure Optical Lens)

    return _glassShader!;
  }
}
