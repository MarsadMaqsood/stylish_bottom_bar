import 'dart:math' as math;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:stylish_bottom_bar/src/anim_nav/animated_nav_tiles.dart';
import 'package:stylish_bottom_bar/src/dot_nav/dot_nav_tile.dart';
import 'package:stylish_bottom_bar/src/model/bar_items.dart';
import 'package:stylish_bottom_bar/src/model/bottom_bar_option.dart';
import 'package:stylish_bottom_bar/src/model/options.dart';
import 'package:stylish_bottom_bar/src/utils/enums.dart';

import 'bubble_nav_bar/bubble_navigation_tile.dart';
import 'shapes/bar_cliper.dart';
import 'utils/constant.dart';

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
          items.every((BottomBarItem item) => item.title != null) == true,
          '\n\nEvery item must have a non-null title',
        ),
        assert((currentIndex >= items.length) == false,
            '\n\nCurrent index is out of bond. Provided: $currentIndex  Bond: 0 to ${items.length - 1}'),
        assert((currentIndex < 0) == false,
            '\n\nCurrent index is out of bond. Provided: $currentIndex  Bond: 0 to ${items.length - 1}');

  ///Add navigation bar items
  ///[BottomBarItem]
  ///
  ///You can use `BottomBarItem` class to add navigation bar items
  final List<BottomBarItem> items;

  ///Change animated navigation bar background color
  final Color? backgroundColor;

  ///Add elevation to bottom navigation bar
  ///
  ///Default value is 8.0
  final double elevation;

  ///Used to change the selected item index
  ///
  /// Default value is 0
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

  ///Change navigation bar border radius
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

  ///Assign icon sapce;
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
  late List<AnimationController> _controllers = <AnimationController>[];
  late List<CurvedAnimation> _animations;
  Color? _backgroundColor;

  ValueListenable<ScaffoldGeometry>? _geometryListenable;
  Animatable<double>? _flexTween;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _geometryListenable = Scaffold.geometryOf(context);
    _flexTween = widget.hasNotch
        ? Tween<double>(begin: 1.15, end: 2.0)
        : Tween<double>(begin: 1.15, end: 1.75);
  }

  void _state() {
    for (AnimationController controller in _controllers) {
      controller.dispose();
    }

    _controllers =
        List<AnimationController>.generate(widget.items.length, (int index) {
      return AnimationController(
        duration: const Duration(milliseconds: 200),
        vsync: this,
      )..addListener(() {
          if (widget.option.runtimeType == BubbleBarOptions) {
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
    _controllers[widget.currentIndex].value = 1.0;
    _backgroundColor = widget.items[widget.currentIndex].backgroundColor;
  }

  @override
  void initState() {
    super.initState();
    _state();
  }

  @override
  void dispose() {
    ///Dispose controllers
    for (AnimationController controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  double _evaluateFlex(Animation<double> animation) =>
      _flexTween!.evaluate(animation);

  @override
  void didUpdateWidget(StylishBottomBar oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.items.length != oldWidget.items.length) {
      _state();
      return;
    }

    if (widget.currentIndex != oldWidget.currentIndex) {
      _controllers[oldWidget.currentIndex].reverse();
      _controllers[widget.currentIndex].forward();

      if (widget.fabLocation == StylishBarFabLocation.center) {
        // dynamic _currentItem = widget.items[oldWidget.currentIndex!];
        // dynamic _nextItem = widget.items[widget.currentIndex!]!;

        // widget.items[0] = _nextItem;
        // widget.items[widget.currentIndex!] = _currentItem;
        _controllers[oldWidget.currentIndex].reverse();
        _controllers[widget.currentIndex].forward();
        // widget.currentIndex = 0;
        _state();
      }
    } else {
      if (_backgroundColor !=
          widget.items[widget.currentIndex].backgroundColor) {
        _backgroundColor = widget.items[widget.currentIndex].backgroundColor;
      }
    }
  }

  bool getStyle() {
    return widget.notchStyle == NotchStyle.themeDefault
        ? Theme.of(context).useMaterial3
        : widget.notchStyle == NotchStyle.square;
  }

  @override
  Widget build(BuildContext context) {
    double additionalBottomPadding = 0;
    late List<Widget> listWidget;

    final mediaQuery = MediaQuery.of(context);

    late BottomBarOption options;

    switch (widget.option.runtimeType) {
      case AnimatedBarOptions:
        options = widget.option as AnimatedBarOptions;
        additionalBottomPadding =
            math.max(mediaQuery.padding.bottom - bottomMargin, 0.0) + 2;
        listWidget = _animatedBarChilds();
        break;

      case BubbleBarOptions:
        options = widget.option as BubbleBarOptions;
        additionalBottomPadding =
            math.max(mediaQuery.padding.bottom - bottomMargin, 0.0) + 4;
        listWidget = _bubbleBarTiles();
        break;

      case DotBarOptions:
        options = widget.option as DotBarOptions;
        additionalBottomPadding =
            math.max(mediaQuery.padding.bottom - bottomMargin, 0.0) + 4;
        listWidget = _dotBarChilds();
        break;
    }

    bool isUsingMaterial3 = getStyle();

    return Semantics(
      explicitChildNodes: true,
      child: widget.hasNotch
          ? PhysicalShape(
              elevation: widget.elevation,
              color: widget.backgroundColor ?? Colors.white,
              clipper: BarClipper(
                shape: isUsingMaterial3
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
                notchMargin: isUsingMaterial3 ? 6 : 8,
              ),
              child: ClipPath(
                clipper: BarClipper(
                  shape: isUsingMaterial3
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
                  notchMargin: isUsingMaterial3 ? 6 : 8,
                ),
                child: Container(
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
                    options is AnimatedBarOptions ? options.barAnimation : null,
                  ),
                ),
              ),
            )
          : Material(
              elevation: widget.elevation,
              borderRadius: widget.borderRadius,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: widget.borderRadius,
                  gradient: widget.gradient,
                  color: widget.backgroundColor ?? Colors.white,
                ),
                child: _innerWidget(
                    context,
                    additionalBottomPadding + 2,
                    widget.fabLocation,
                    listWidget,
                    options is AnimatedBarOptions
                        ? options.barAnimation
                        : null),
              ),
            ),
    );
  }

  List<Widget> _bubbleBarTiles() {
    final MaterialLocalizations localizations =
        MaterialLocalizations.of(context);
    final List<Widget> list = <Widget>[];

    final BubbleBarOptions options = widget.option as BubbleBarOptions;

    list.addAll(List.generate(widget.items.length, (i) {
      return BubbleNavigationTile(
        widget.items[i],
        options.opacity!,
        _animations[i],
        options.iconSize,
        options.barStyle,
        onTap: () {
          if (widget.onTap != null) widget.onTap!(i);
        },
        selected: i == widget.currentIndex,
        flex: _evaluateFlex(_animations[i]),
        indexLabel: localizations.tabLabel(
            tabIndex: i + 1, tabCount: widget.items.length),
        ink: options.inkEffect,
        inkColor: options.inkColor,
        padding: options.padding,
        fillStyle: options.bubbleFillStyle,
        itemBorderRadius: options.borderRadius,
      );
    }));

    if (widget.fabLocation == StylishBarFabLocation.center) {
      list.insert(
          1,
          const Spacer(
            flex: 1500,
          ));
    }
    return list;
  }

  List<Widget> _animatedBarChilds() {
    final List<Widget> list = [];
    final MaterialLocalizations localizations =
        MaterialLocalizations.of(context);

    final AnimatedBarOptions options = widget.option as AnimatedBarOptions;

    list.addAll(
      List.generate(widget.items.length, (i) {
        return AnimatedNavigationTiles(
          widget.items[i],
          options.iconSize,
          padding: options.padding,
          inkEffect: options.inkEffect,
          inkColor: options.inkColor,
          selected: widget.currentIndex == i,
          opacity: options.opacity!,
          animation: _animations[i],
          barAnimation: options.barAnimation,
          iconStyle: options.iconStyle ?? IconStyle.Default,
          onTap: () {
            if (widget.onTap != null) widget.onTap!(i);
          },
          flex: _evaluateFlex(_animations[i]),
          indexLabel: localizations.tabLabel(
              tabIndex: i + 1, tabCount: widget.items.length),
        );
      }),
    );

    // if (widget.fabLocation == StylishBarFabLocation.center && list.length > 2) {
    //   list.insert(
    //     2,
    //     list.length > 3
    //         ? const Flex(
    //             direction: Axis.horizontal,
    //             children: [Padding(padding: EdgeInsets.all(12))],
    //           )
    //         : const Spacer(
    //             flex: 2,
    //           ),
    //   );
    // }

    insertSpace(list);

    return list;
  }

  List<Widget> insertSpace(List<Widget> list) {
    if (widget.fabLocation == StylishBarFabLocation.center) {
      if (list.length == 2) {
        list.insert(1, const Spacer()); // One at start, one at end
      } else if (list.length == 3) {
        list.insert(2, const Spacer(flex: 1)); // Push second item towards FAB
        list.insert(4, const Spacer()); // Minimal spacing after FAB
      } else if (list.length == 4) {
        list.insert(2, const Spacer()); // Two before, two after FAB
      }
    }
    return list;
  }

  List<Widget> _dotBarChilds() {
    final List<Widget> list = [];
    final MaterialLocalizations localizations =
        MaterialLocalizations.of(context);

    final DotBarOptions options = widget.option as DotBarOptions;

    list.addAll(
      List.generate(widget.items.length, (i) {
        return DotNavigationTiles(
          widget.items[i],
          selected: widget.currentIndex == i,
          animation: _animations[i],
          options: options,
          onTap: () {
            if (widget.onTap != null) widget.onTap!(i);
          },
          flex: _evaluateFlex(_animations[i]),
          indexLabel: localizations.tabLabel(
              tabIndex: i + 1, tabCount: widget.items.length),
        );
      }),
    );

    insertSpace(list);
    return list;
  }

  Widget _innerWidget(
    context,
    double additionalBottomPadding,
    fabLocation,
    List<Widget> childs, [
    BarAnimation? barAnimation,
  ]) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
      ),
      child: ConstrainedBox(
        constraints: BoxConstraints(
            minHeight: kBottomNavigationBarHeight + additionalBottomPadding),
        child: Material(
          type: MaterialType.transparency,
          child: Padding(
            padding: EdgeInsets.only(
                bottom:
                    barAnimation != null && barAnimation == BarAnimation.liquid
                        ? 0
                        : additionalBottomPadding,
                right: fabLocation == StylishBarFabLocation.end ? 72 : 0),
            child: MediaQuery.removePadding(
              context: context,
              removeBottom: true,
              child: DefaultTextStyle.merge(
                overflow: TextOverflow.ellipsis,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: childs,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
