import 'package:flutter/material.dart';
import 'package:stylish_bottom_bar/src/core/bottom_bar_item.dart';
import 'package:stylish_bottom_bar/src/utils/enums.dart';

class AnimatedIconWidget extends StatelessWidget {
  const AnimatedIconWidget({
    super.key,
    required this.item,
    required this.selected,
    required this.iconSize,
    required this.barAnimation,
    this.animation,
  });

  final BottomBarItem item;
  final bool selected;
  final double iconSize;
  final BarAnimation barAnimation;
  final Animation<double>? animation;

  @override
  Widget build(BuildContext context) {
    if (barAnimation == BarAnimation.transform3D) {
      return _buildTransform3D();
    }

    if (animation == null) {
      return _buildStaticIcon();
    }

    final curve = barAnimation == BarAnimation.blink
        ? Curves.bounceIn
        : Curves.ease;

    final colorTween = ColorTween(
      begin: item.backgroundColor ?? item.unSelectedColor,
      end: item.selectedColor,
    );

    return AnimatedBuilder(
      animation: animation!,
      builder: (context, child) {
        final curvedValue = curve.transform(animation!.value);
        final currentColor =
            item.backgroundColor ??
            colorTween.transform(curvedValue) ??
            (selected ? item.selectedColor : item.unSelectedColor);

        return IconTheme(
          data: IconThemeData(
            color: currentColor,
            size: selected ? iconSize + 4 : iconSize,
          ),
          child: selected ? (item.selectedIcon ?? item.icon) : item.icon,
        );
      },
    );
  }

  Widget _buildTransform3D() {
    return IconTheme(
      data: IconThemeData(
        color:
            item.backgroundColor ??
            (selected ? item.selectedColor : item.unSelectedColor),
        size: selected ? iconSize + 4 : iconSize,
      ),
      child: selected
          ? Transform(
              transform: Matrix4.identity()
                ..setEntry(3, 0, 0.002)
                ..rotateY(0),
              child: item.selectedIcon ?? item.icon,
            )
          : item.icon,
    );
  }

  Widget _buildStaticIcon() {
    return IconTheme(
      data: IconThemeData(
        color:
            item.backgroundColor ??
            (selected ? item.selectedColor : item.unSelectedColor),
        size: selected ? iconSize + 4 : iconSize,
      ),
      child: selected ? (item.selectedIcon ?? item.icon) : item.icon,
    );
  }
}
