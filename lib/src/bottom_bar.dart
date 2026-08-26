import 'dart:math' as math;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:stylish_bottom_bar/src/core/bottom_bar_constants.dart';
import 'package:stylish_bottom_bar/src/core/bottom_bar_item.dart';
import 'package:stylish_bottom_bar/src/core/bottom_bar_option.dart';
import 'package:stylish_bottom_bar/src/shared/clippers/bar_clipper.dart';
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
  })  : assert(items.length >= 2,
            '\n\nStylish Bottom Navigation must have 2 or more items'),
        assert(
          items.every((BottomBarItem item) => item.title != null),
          '\n\nEvery item must have a non-null title',
        ),
        assert(currentIndex >= 0 && currentIndex < items.length,
            '\n\nCurrent index is out of bounds. Provided: $currentIndex Bounds: 0 to ${items.length - 1}'),
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

  @override
  State<StylishBottomBar> createState() => _StylishBottomBarState();
}

class _StylishBottomBarState extends State<StylishBottomBar>
    with TickerProviderStateMixin {
  List<AnimationController> _controllers = <AnimationController>[];
  List<CurvedAnimation> _animations = <CurvedAnimation>[];

  ValueListenable<ScaffoldGeometry>? _geometryListenable;
  late Animatable<double> _flexTween;

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

    _controllers =
        List<AnimationController>.generate(widget.items.length, (int index) {
      return AnimationController(
        duration: const Duration(milliseconds: 200),
        vsync: this,
      )..addListener(() {
          if (widget.option.requiresControllerListener) {
            setState(() {});
          }
        });
    });

    _animations =
        List<CurvedAnimation>.generate(widget.items.length, (int index) {
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
  }

  @override
  void dispose() {
    _disposeAnimations();
    super.dispose();
  }

  @override
  void didUpdateWidget(StylishBottomBar oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.items.length != oldWidget.items.length) {
      _initAnimations();
      return;
    }

    if (widget.currentIndex != oldWidget.currentIndex) {
      final oldIndex = oldWidget.currentIndex.clamp(0, _controllers.length - 1);
      final newIndex = widget.currentIndex.clamp(0, _controllers.length - 1);
      _controllers[oldIndex].reverse();
      _controllers[newIndex].forward();
    }
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

    final additionalBottomPadding = math.max(
          mediaQuery.padding.bottom - bottomMargin,
          0.0,
        ) +
        widget.option.additionalBottomPadding;

    final List<Widget> listWidget =
        List<Widget>.generate(widget.items.length, (i) {
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

    final content = Container(
      decoration: BoxDecoration(
        borderRadius: widget.borderRadius,
        gradient: widget.gradient,
        color: widget.backgroundColor ?? Colors.white,
      ),
      child: _innerWidget(
        context,
        additionalBottomPadding,
        widget.fabLocation,
        listWidget,
        widget.option.barAnimation,
      ),
    );

    return Semantics(
      explicitChildNodes: true,
      child: widget.hasNotch
          ? PhysicalShape(
              elevation: widget.elevation,
              color: widget.backgroundColor ?? Colors.white,
              clipper: BarClipper(
                shape: isM3
                    ? const AutomaticNotchedShape(
                        RoundedRectangleBorder(),
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(18),
                          ),
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
                            borderRadius: BorderRadius.all(
                              Radius.circular(18),
                            ),
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
              elevation: widget.elevation,
              borderRadius: widget.borderRadius,
              color: Colors.transparent,
              child: content,
            ),
    );
  }

  Widget _innerWidget(
    BuildContext context,
    double additionalBottomPadding,
    StylishBarFabLocation? fabLocation,
    List<Widget> children, [
    BarAnimation? barAnimation,
  ]) {
    final isLiquid = barAnimation == BarAnimation.liquid;
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
      ),
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
}
