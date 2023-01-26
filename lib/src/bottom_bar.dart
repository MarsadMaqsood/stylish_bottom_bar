import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:stylish_bottom_bar/helpers/bottom_bar.dart';
import 'package:stylish_bottom_bar/helpers/enums.dart';
import 'package:stylish_bottom_bar/model/bar_items.dart';
import 'package:stylish_bottom_bar/model/options.dart';
import 'anim_nav/animated_nav_tiles.dart';
import 'bubble_nav_bar/bubble_navigation_tile.dart';
import '../helpers/cliper.dart';
import '../helpers/constant.dart';
import 'widgets/widgets.dart';
import 'dart:math' as math;

///[StylishBottomBar] class to implement beautiful bottom bar widget
///
///```dart

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

///```

// ignore: must_be_immutable
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

  ///Change Icon size
  ///Default is 26.0
  // final double? iconSize;

  ///Used to change the selected item index
  /// Default is 0
  int currentIndex;

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

  ///Change navigation bar items background color opacity
  // final double? opacity;

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
          setState(() {});
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

  @override
  Widget build(BuildContext context) {
    double additionalBottomPadding = 0;
    late List<Widget> listWidget;

    dynamic options;

    if (widget.option.runtimeType == AnimatedBarOptions) {
      options = widget.option as AnimatedBarOptions;
      additionalBottomPadding =
          math.max(MediaQuery.of(context).padding.bottom - bottomMargin, 0.0) +
              2;
      listWidget = _animatedBarChilds();
    } else if (widget.option.runtimeType == BubbleBarOptions) {
      options = widget.option as BubbleBarOptions;
      additionalBottomPadding =
          math.max(MediaQuery.of(context).padding.bottom - bottomMargin, 0.0) +
              4;
      listWidget = _bubbleBarTiles();
    }

    bool isUsingMaterial3 = Theme.of(context).useMaterial3;

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
                child: innerWidget(
                    context,
                    additionalBottomPadding,
                    widget.fabLocation,
                    listWidget,
                    options is AnimatedBarOptions
                        ? options.barAnimation
                        : null),
              ),
            )
          : Material(
              elevation: widget.elevation,
              color: widget.backgroundColor ?? Colors.white,
              borderRadius: widget.borderRadius ?? BorderRadius.zero,
              child: innerWidget(
                  context,
                  additionalBottomPadding + 2,
                  widget.fabLocation,
                  listWidget,
                  options is AnimatedBarOptions ? options.barAnimation : null),
            ),
    );
  }

  List<Widget> _bubbleBarTiles() {
    final MaterialLocalizations localizations =
        MaterialLocalizations.of(context);
    final List<Widget> children = <Widget>[];

    final BubbleBarOptions options = widget.option as BubbleBarOptions;

    for (int i = 0; i < widget.items.length; i += 1) {
      children.add(
        BubbleNavigationTile(
          widget.items[i],
          options.opacity!,
          _animations[i],
          options.iconSize,
          options.unselectedIconColor,
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
        ),
      );
    }

    if (widget.fabLocation == StylishBarFabLocation.center) {
      children.insert(
          1,
          const Spacer(
            flex: 1500,
          ));
    }
    return children;
  }

  List<Widget> _animatedBarChilds() {
    final List<Widget> list = [];
    final MaterialLocalizations localizations =
        MaterialLocalizations.of(context);

    final AnimatedBarOptions options = widget.option as AnimatedBarOptions;

    for (int i = 0; i < widget.items.length; ++i) {
      list.add(AnimatedNavigationTiles(
        widget.items[i],
        options.iconSize,
        options.padding!,
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
      ));
    }
    if (widget.fabLocation == StylishBarFabLocation.center) {
      list.insert(
        2,
        list.length > 3
            ? Flex(
                direction: Axis.horizontal,
                children: const [Padding(padding: EdgeInsets.all(12))],
              )
            : const Spacer(
                flex: 2,
              ),
      );
    }
    return list;
  }
}
