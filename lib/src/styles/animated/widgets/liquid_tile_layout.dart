import 'package:flutter/material.dart';
import 'package:stylish_bottom_bar/src/core/bottom_bar_item.dart';
import 'package:stylish_bottom_bar/src/styles/animated/widgets/animated_label_widget.dart';
import 'package:stylish_bottom_bar/src/utils/enums.dart';

class LiquidTileLayout extends StatelessWidget {
  const LiquidTileLayout({
    super.key,
    required this.item,
    required this.selected,
    required this.iconSize,
    required this.iconStyle,
    required this.animation,
    required this.itemColor,
    required this.itemColorOnSelected,
  });

  final BottomBarItem item;
  final bool selected;
  final double iconSize;
  final IconStyle iconStyle;
  final Animation<double>? animation;
  final Color itemColor;
  final Color itemColorOnSelected;

  @override
  Widget build(BuildContext context) {
    final label = AnimatedLabelWidget(
      iconStyle: iconStyle,
      animation: animation,
      item: item,
      color: itemColorOnSelected,
    );

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: selected
          ? MainAxisAlignment.spaceBetween
          : MainAxisAlignment.center,
      children: [
        Badge(
          label: item.badge,
          isLabelVisible: item.showBadge,
          backgroundColor: item.badgeColor,
          padding: item.badgePadding,
          alignment: const Alignment(0.175, -1.0),
          child: AnimatedCrossFade(
            firstChild: Padding(
              padding: const EdgeInsets.all(6.0),
              child: label,
            ),
            secondChild: Container(
              alignment: Alignment.center,
              child: IconTheme(
                data: IconThemeData(color: itemColor, size: iconSize),
                child: selected ? item.selectedIcon ?? item.icon : item.icon,
              ),
            ),
            duration: const Duration(milliseconds: 600),
            sizeCurve: Curves.fastOutSlowIn,
            firstCurve: Curves.fastOutSlowIn,
            secondCurve: Curves.fastOutSlowIn.flipped,
            crossFadeState: selected
                ? CrossFadeState.showFirst
                : CrossFadeState.showSecond,
          ),
        ),
        AnimatedCrossFade(
          firstChild: const SizedBox.shrink(),
          secondChild: Container(
            height: 20,
            width: 22,
            decoration: BoxDecoration(
              color: itemColorOnSelected,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.elliptical(12, 20),
                topRight: Radius.elliptical(12, 20),
              ),
            ),
          ),
          duration: const Duration(milliseconds: 300),
          sizeCurve: Curves.linear,
          firstCurve: Curves.fastOutSlowIn,
          secondCurve: Curves.fastOutSlowIn.flipped,
          crossFadeState: selected
              ? CrossFadeState.showSecond
              : CrossFadeState.showFirst,
        ),
      ],
    );
  }
}
