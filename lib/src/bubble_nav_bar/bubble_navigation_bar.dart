import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:stylish_bottom_bar/stylish_bottom_bar.dart';
import 'dart:math' as math;
import 'bubble_item.dart';
import 'bubble_navigation_tile.dart';
import 'cliper.dart';

const _BottomMargin = 8.0;

// ignore: must_be_immutable
class BubbleNavigationBar extends StatefulWidget {
  BubbleNavigationBar({
    Key? key,
    required this.items,
    this.onTap,
    this.barStyle = BubbleBarStyle.horizotnal,

    ///By default first item is selected
    this.currentIndex = 0,
    required this.opacity,
    this.iconSize = 26.0,
    this.borderRadius,
    this.elevation,
    this.backgroundColor,
    this.hasNotch = false,
    this.inkEffect = false,
    this.inkColor,
    this.fabLocation,
    this.padding = EdgeInsets.zero,
    this.bubbleFillStyle = BubbleFillStyle.fill,

    ///If icon color not provided then
    ///default unselected icon color is [Colors.black]
    ///this is also used to set bulk color to unselected icons
    this.unselectedIconColor = Colors.black,
  })  : assert(items.length >= 2,
            'Animated Bottom Navigation must have 2 or more items'),
        assert(
          items.every((BubbleBarItem item) => item.title != null) == true,
          'Every item must have a non-null title',
        ),
        assert((currentIndex! >= items.length) == false,
            '\n\nCurrent index is out of bond. Provided: $currentIndex  Bond: 0 to ${items.length - 1}'),
        assert((currentIndex! < 0) == false,
            'Current index is out of bond. Provided: $currentIndex  Bond: 0 to ${items.length - 1}'),
        super(key: key);

  ///Add BubbleNavigationbar items
  ///
  ///{required this.icon,this.title,this.activeIcon,this.showBadge,
  ///this.badgeColor,this.backgroundColor,this.badge, this.badgeRadius}
  final List<BubbleBarItem> items;

  ///BarStyle to align icon and title in horizontal or vertical
  ///[BubbleBarStyle.horizotnal]
  ///[BubbleBarStyle.vertical]
  ///Default value is [BubbleBarStyle.horizotnal]
  final BubbleBarStyle? barStyle;

  ///ValueChanged function to return current selected item index
  ///
  ///(index){
  ///
  ///}
  final ValueChanged<int?>? onTap;

  ///Used to change the selected item
  int? currentIndex;

  ///Change Icon size
  ///Default is 26.0
  final double? iconSize;

  ///Change bubble item background color opacity
  final double opacity;

  ///Change bubble navigation bar border radius
  final BorderRadius? borderRadius;

  ///Add elevation to bottom navigation bar
  final double? elevation;

  ///Change bubble navigation bar background color
  final Color? backgroundColor;

  ///Add notch effect to fab icon
  final bool hasNotch;

  ///Enable ink effect to bubble navigation bar item
  ///Default value is false
  final bool inkEffect;

  ///Adjust bubble navigation items according to the fab location
  ///
  ///You can change Fab Location [StylishBarFabLocation.center]
  ///
  ///and [StylishBarFabLocation.end]
  final StylishBarFabLocation? fabLocation;

  ///Change ink color
  ///Default color is [Colors.grey]
  final Color? inkColor;

  ///Change unselected item color
  ///If you don't want to change every single icon color use this property
  ///this will bulk change all the unselected icon color which does'nt have color property.
  ///
  ///If icon color not provided then
  ///default unselected icon color is [Colors.black]
  ///this is also used to set bulk color to unselected icons
  Color? unselectedIconColor;

  ///Add padding arround navigation tiles
  ///Default padding is [EdgeInsets.zero]
  final EdgeInsets padding;

  ///Use this to customize bubble background fill style
  ///You can use border with [BubbleFillStyle.outlined]
  ///and also fill the background with color using [BubbleFillStyle.fill]
  final BubbleFillStyle? bubbleFillStyle;

  @override
  _BubbleNavigationBarState createState() => _BubbleNavigationBarState();
}

class _BubbleNavigationBarState extends State<BubbleNavigationBar>
    with TickerProviderStateMixin {
  late List<AnimationController> _controllers = <AnimationController>[];
  late List<CurvedAnimation> _animations;
  Color? _backgroundColor;
  ValueListenable<ScaffoldGeometry>? _geometryListenable;
  Animatable<double>? _flexTween;

  @override
  void initState() {
    super.initState();
    _initializeState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _geometryListenable = Scaffold.geometryOf(context);
    _flexTween = widget.hasNotch
        ? Tween<double>(begin: 1.15, end: 2.0)
        : Tween<double>(begin: 1.15, end: 1.75);
  }

  _initializeState() {
    for (AnimationController controller in _controllers) controller.dispose();

    _controllers =
        List<AnimationController>.generate(widget.items.length, (int index) {
      return AnimationController(
        duration: Duration(milliseconds: 200),
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
    _controllers[widget.currentIndex!].value = 1.0;
    _backgroundColor = widget.items[widget.currentIndex!].backgroundColor;
  }

  @override
  void dispose() {
    ///Disposing active controllers
    for (AnimationController controller in _controllers) controller.dispose();
    super.dispose();
  }

  double _evaluateFlex(Animation<double> animation) =>
      _flexTween!.evaluate(animation);

  @override
  void didUpdateWidget(BubbleNavigationBar oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.items.length != oldWidget.items.length) {
      _initializeState();
      return;
    }

    if (widget.currentIndex != oldWidget.currentIndex) {
      _controllers[oldWidget.currentIndex!].reverse();
      _controllers[widget.currentIndex!].forward();

      if (widget.fabLocation == StylishBarFabLocation.center) {
        BubbleBarItem _currentItem = widget.items[oldWidget.currentIndex!];
        BubbleBarItem _nextItem = widget.items[widget.currentIndex!];

        widget.items[0] = _nextItem;
        widget.items[widget.currentIndex!] = _currentItem;
        _controllers[oldWidget.currentIndex!].reverse();
        _controllers[widget.currentIndex!].forward();
        widget.currentIndex = 0;
        _initializeState();
      }
    } else {
      if (_backgroundColor !=
          widget.items[widget.currentIndex!].backgroundColor)
        _backgroundColor = widget.items[widget.currentIndex!].backgroundColor;
    }
  }

  List<Widget> _barTiles() {
    final MaterialLocalizations? localizations =
        MaterialLocalizations.of(context);
    assert(localizations != null);
    final List<Widget> children = <Widget>[];
    for (int i = 0; i < widget.items.length; i += 1) {
      children.add(
        BubbleNavigationTile(
          widget.items[i],
          widget.opacity,
          _animations[i],
          widget.iconSize!,
          widget.unselectedIconColor,
          widget.barStyle,
          onTap: () {
            if (widget.onTap != null) widget.onTap!(i);
          },
          selected: i == widget.currentIndex,
          flex: _evaluateFlex(_animations[i]),
          indexLabel: localizations!
              .tabLabel(tabIndex: i + 1, tabCount: widget.items.length),
          ink: widget.inkEffect,
          inkColor: widget.inkColor,
          padding: widget.padding,
          fillStyle: widget.bubbleFillStyle,
        ),
      );
    }

    if (widget.fabLocation == StylishBarFabLocation.center) {
      children.insert(
          1,
          Spacer(
            flex: 1500,
          ));
    }
    return children;
  }

  Widget _container(List<Widget> tiles) {
    return DefaultTextStyle.merge(
      overflow: TextOverflow.ellipsis,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: tiles,
      ),
    );
  }

  Widget _innerWidgets(double additionalBottomPadding) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 10,
      ),
      child: ConstrainedBox(
        constraints: BoxConstraints(
            minHeight: kBottomNavigationBarHeight +
                additionalBottomPadding +
                4), //increased to 4 from 2
        child: Material(
          type: MaterialType.transparency,
          child: Padding(
            padding: EdgeInsets.only(
                bottom: additionalBottomPadding,
                right:
                    widget.fabLocation == StylishBarFabLocation.end ? 72 : 0),
            child: MediaQuery.removePadding(
              context: context,
              removeBottom: true,
              child: _container(_barTiles()),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    assert(debugCheckHasDirectionality(context));
    assert(debugCheckHasMaterialLocalizations(context));
    final double additionalBottomPadding =
        math.max(MediaQuery.of(context).padding.bottom - _BottomMargin, 0.0);
    return Semantics(
        explicitChildNodes: true,
        child: widget.hasNotch
            ? PhysicalShape(
                elevation: widget.elevation ?? 8.0,
                color: widget.backgroundColor ?? Colors.white,
                clipper: BubbleBarClipper(
                  shape: CircularNotchedRectangle(),
                  geometry: _geometryListenable!,
                  notchMargin: 8,
                ),
                child: _innerWidgets(additionalBottomPadding),
              )
            : Material(
                elevation: widget.elevation ?? 8.0,
                color: widget.backgroundColor != null
                    ? widget.backgroundColor
                    : Colors.white,
                child: _innerWidgets(additionalBottomPadding),
                borderRadius: widget.borderRadius != null
                    ? widget.borderRadius
                    : BorderRadius.zero,
              ));
  }
}
