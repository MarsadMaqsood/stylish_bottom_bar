import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:stylish_bottom_bar/src/bubble_nav_bar/cliper.dart';
import 'dart:math' as math;

import 'animated_nav_items.dart';
import 'animated_nav_tiles.dart';

enum AnimatedBarFabLocation { center, end }
enum AnimatedBarStyle {
  easeIn,
  blink,
}
const _BottomMargin = 8.0;

// ignore: must_be_immutable
class AnimatedNavigationBar extends StatefulWidget {
  AnimatedNavigationBar({
    Key? key,
    required this.items,
    this.backgroundColor,
    this.elevation,
    this.currentIndex = 0,
    this.iconSize = 26.0,
    this.padding = EdgeInsets.zero,
    this.inkEffect = false,
    this.inkColor = Colors.grey,
    this.onTap,
    this.opacity = 0.8,
    this.borderRadius,
    this.fabLocation,
    this.hasNotch = false,
    this.barStyle = AnimatedBarStyle.easeIn,
  })  : assert(items.length >= 2,
            'LivenavigationBar must contain 2 or more items'),
        assert(
            (items.every((AnimatedBarItems item) => item.icon != null) == true),
            'Every item must have non-null icon'),
        assert(
            (items.every((AnimatedBarItems item) => item.title != null) ==
                true),
            'Every item must have non-null title'),
        assert((currentIndex! >= items.length) == false,
            'Current index is out of bond Provided: $currentIndex Bond: 0 to ${items.length - 1}'),
        assert((currentIndex! < 0) == false,
            'Current index is out of bond Provided: $currentIndex Bond: 0 to ${items.length - 1}'),
        super(key: key);

  final List<AnimatedBarItems> items;
  final Color? backgroundColor;
  final double? elevation;
  final double? iconSize;
  int? currentIndex;
  final EdgeInsets? padding;
  final bool? inkEffect;
  final bool hasNotch;
  final Color? inkColor;
  final ValueChanged<int?>? onTap;
  final double? opacity;
  final BorderRadius? borderRadius;
  final AnimatedBarFabLocation? fabLocation;
  final AnimatedBarStyle? barStyle;

  @override
  _AnimatedNavigationBarState createState() => _AnimatedNavigationBarState();
}

class _AnimatedNavigationBarState extends State<AnimatedNavigationBar>
    with TickerProviderStateMixin {
  late List<AnimationController> _controllers = <AnimationController>[];
  late List<CurvedAnimation> _animations;
  Color? _backgroundColor;

  ValueListenable<ScaffoldGeometry>? geometryListenable;
  bool fabExists = false;
  AnimatedBarItems? holder;
  Animatable<double>? _flexTween;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    geometryListenable = Scaffold.geometryOf(context);
    _flexTween = widget.hasNotch
        ? Tween<double>(begin: 1.15, end: 2.0)
        : Tween<double>(begin: 1.15, end: 1.75);
  }

  void _state() {
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
  void initState() {
    super.initState();
    _state();
  }

  @override
  void dispose() {
    ///Dispose controllers
    for (AnimationController controller in _controllers) controller.dispose();
    super.dispose();
  }

  double _evaluateFlex(Animation<double> animation) =>
      _flexTween!.evaluate(animation);

  @override
  void didUpdateWidget(AnimatedNavigationBar oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.items.length != oldWidget.items.length) {
      _state();
      return;
    }

    if (widget.currentIndex != oldWidget.currentIndex) {
      _controllers[oldWidget.currentIndex!].reverse();
      _controllers[widget.currentIndex!].forward();

      if (widget.fabLocation == AnimatedBarFabLocation.center) {
        AnimatedBarItems _currentItem = widget.items[oldWidget.currentIndex!];
        AnimatedBarItems _nextItem = widget.items[widget.currentIndex!];

        widget.items[0] = _nextItem;
        widget.items[widget.currentIndex!] = _currentItem;
        _controllers[oldWidget.currentIndex!].reverse();
        _controllers[widget.currentIndex!].forward();
        widget.currentIndex = 0;
        _state();
      }
    } else {
      if (_backgroundColor !=
          widget.items[widget.currentIndex!].backgroundColor)
        _backgroundColor = widget.items[widget.currentIndex!].backgroundColor;
    }
  }

  @override
  Widget build(BuildContext context) {
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
                geometry: geometryListenable!,
                notchMargin: 8,
              ),
              child: _innerWidget(additionalBottomPadding),
            )
          : Material(
              elevation: widget.elevation ?? 8.0,
              color: widget.backgroundColor != null
                  ? widget.backgroundColor
                  : Colors.white,
              child: _innerWidget(additionalBottomPadding),
              borderRadius: widget.borderRadius != null
                  ? widget.borderRadius
                  : BorderRadius.zero,
            ),
    );
  }

  Widget _innerWidget(double additionalBottomPadding) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 10,
      ),
      child: ConstrainedBox(
        constraints: BoxConstraints(
            minHeight:
                kBottomNavigationBarHeight + additionalBottomPadding + 2),
        child: Material(
          type: MaterialType.transparency,
          child: Padding(
            padding: EdgeInsets.only(
                bottom: additionalBottomPadding,
                right:
                    widget.fabLocation == AnimatedBarFabLocation.end ? 72 : 0),
            child: MediaQuery.removePadding(
              context: context,
              removeBottom: true,
              child: _container(_childs()),
            ),
          ),
        ),
      ),
    );
  }

  Widget _container(List<Widget> childs) {
    return DefaultTextStyle.merge(
      overflow: TextOverflow.ellipsis,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: childs,
      ),
    );
  }

  List<Widget> _childs() {
    final List<Widget> list = [];
    final MaterialLocalizations? localizations =
        MaterialLocalizations.of(context);

    for (int i = 0; i < widget.items.length; i += 1) {
      list.add(AnimatedNavigationTiles(
        widget.items[i],
        widget.iconSize!,
        widget.padding!,
        inkEffect: widget.inkEffect,
        inkColor: widget.inkColor,
        selected: widget.currentIndex == i,
        opacity: widget.opacity!,
        animation: _animations[i],
        barStyle: widget.barStyle!,
        onTap: () {
          if (widget.onTap != null) widget.onTap!(i);
        },
        flex: _evaluateFlex(_animations[i]),
        indexLabel: localizations!
            .tabLabel(tabIndex: i + 1, tabCount: widget.items.length),
      ));
    }
    if (widget.fabLocation == AnimatedBarFabLocation.center) {
      list.insert(
          1,
          Spacer(
            flex: 2,
          ));
    }
    return list;
  }
}
