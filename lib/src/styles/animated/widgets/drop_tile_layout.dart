import 'package:flutter/material.dart';
import 'package:stylish_bottom_bar/src/core/bottom_bar_item.dart';
import 'package:stylish_bottom_bar/src/styles/animated/widgets/water_drop_painter.dart';

class DropTileLayout extends StatelessWidget {
  const DropTileLayout({
    super.key,
    required this.item,
    required this.selected,
    required this.iconSize,
    required this.itemColor,
  });

  final BottomBarItem item;
  final bool selected;
  final double iconSize;
  final Color itemColor;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: selected
          ? MainAxisAlignment.spaceEvenly
          : MainAxisAlignment.center,
      children: [
        Badge(
          label: item.badge,
          isLabelVisible: item.showBadge,
          backgroundColor: item.badgeColor,
          padding: item.badgePadding,
          alignment: const Alignment(0.17, -1.0),
          child: AnimatedCrossFade(
            firstChild: Align(
              alignment: Alignment.center,
              child: IconTheme(
                data: IconThemeData(color: itemColor, size: iconSize),
                child: selected ? item.selectedIcon ?? item.icon : item.icon,
              ),
            ),
            secondChild: Align(
              alignment: Alignment.center,
              child: WaterDrop(
                top: 0,
                color: item.backgroundColor,
                width: 48,
                height: 48,
                left: 0,
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: IconTheme(
                    data: IconThemeData(color: itemColor, size: iconSize),
                    child: selected && item.selectedIcon != null
                        ? item.selectedIcon!
                        : item.icon,
                  ),
                ),
              ),
            ),
            duration: const Duration(milliseconds: 300),
            sizeCurve: Curves.linear,
            firstCurve: Curves.ease,
            secondCurve: Curves.fastOutSlowIn.flipped,
            crossFadeState: selected
                ? CrossFadeState.showSecond
                : CrossFadeState.showFirst,
          ),
        ),
      ],
    );
  }
}
