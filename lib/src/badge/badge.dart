import 'package:flutter/material.dart';
import 'package:stylish_bottom_bar/src/widgets/icon_widget.dart';
import 'badge_positioned.dart';

class Badge extends StatefulWidget {
  final Widget? badgeContent;
  final Color? badgeColor;
  final bool showBadge;
  final Widget? child;
  final BadgeAnimationType? animationType;
  final StackFit stackFit;
  final Alignment alignment;
  final BadgePosition? badgePosition;
  final bool ignorePointer;
  final BadgeShape? badgeShape;
  final BorderSide borderSide;
  final double elevation;
  final BorderRadius borderRadius;
  final EdgeInsets padding;
  final Duration duration;
  final bool toAnimate;

  const Badge({
    super.key,
    this.badgeContent,
    this.badgeColor = Colors.black,
    this.showBadge = true,
    this.child,
    this.animationType = BadgeAnimationType.slide,
    this.stackFit = StackFit.loose,
    this.alignment = Alignment.topRight,
    this.ignorePointer = false,
    this.badgePosition,
    this.badgeShape,
    this.borderSide = BorderSide.none,
    this.elevation = 0,
    this.borderRadius = BorderRadius.zero,
    this.padding = EdgeInsets.zero,
    this.duration = Duration.zero,
    this.toAnimate = true,
  });

  @override
  State<Badge> createState() => _BadgeState();
}

class _BadgeState extends State<Badge> with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  final Tween<Offset> _positionTween = Tween(
    begin: const Offset(-0.5, 0.9),
    end: const Offset(0.0, 0.0),
  );
  final Tween<double> _scaleTween = Tween<double>(begin: 0.1, end: 1);

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: widget.duration,
      vsync: this,
    );

    if (widget.animationType == BadgeAnimationType.slide) {
      _animation = CurvedAnimation(
          parent: _animationController, curve: Curves.elasticOut);
    } else if (widget.animationType == BadgeAnimationType.scale) {
      _animation = _scaleTween.animate(_animationController);
    } else if (widget.animationType == BadgeAnimationType.fade) {
      _animation =
          CurvedAnimation(parent: _animationController, curve: Curves.easeIn);
    }

    _animationController.forward();
  }

  @override
  void didUpdateWidget(Badge oldWidget) {
    if (widget.badgeContent is Text && oldWidget.badgeContent is Text) {
      final newText = widget.badgeContent as Text;
      final oldText = oldWidget.badgeContent as Text;
      if (newText.data != oldText.data) {
        _animationController.reset();
        _animationController.forward();
      }
    }

    if (widget.badgeContent is Icon && oldWidget.badgeContent is Icon) {
      final newIcon = widget.badgeContent as Icon;
      final oldIcon = oldWidget.badgeContent as Icon;
      if (newIcon.icon != oldIcon.icon) {
        _animationController.reset();
        _animationController.forward();
      }
    }

    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child == null
        ? _getBadge()
        : Stack(
            fit: widget.stackFit,
            alignment: widget.alignment,
            clipBehavior: Clip.none,
            children: [
              widget.child!,
              BadgePositioned(
                position: widget.badgePosition,
                child: widget.ignorePointer
                    ? IgnorePointer(child: _getBadge())
                    : _getBadge(),
              ),
            ],
          );
  }

  Widget _getBadge() {
    final border = widget.badgeShape == BadgeShape.circle
        ? CircleBorder(side: widget.borderSide)
        : RoundedRectangleBorder(
            side: widget.borderSide,
            borderRadius: widget.borderRadius,
          );

    Widget badgeView() {
      return AnimatedOpacity(
        opacity: widget.showBadge ? 1 : 0,
        duration: const Duration(milliseconds: 200),
        child: Material(
          shape: border,
          elevation: widget.elevation,
          color: widget.badgeColor,
          child: Padding(
            padding: widget.padding,
            child: widget.badgeContent,
          ),
        ),
      );
    }

    if (widget.toAnimate) {
      if (widget.animationType == BadgeAnimationType.slide) {
        return SlideTransition(
          position: _positionTween.animate(_animation),
          child: badgeView(),
        );
      } else if (widget.animationType == BadgeAnimationType.scale) {
        return ScaleTransition(
          scale: _animation,
          child: badgeView(),
        );
      } else if (widget.animationType == BadgeAnimationType.fade) {
        return FadeTransition(
          opacity: _animation,
          child: badgeView(),
        );
      }
    }

    return badgeView();
  }
}
