import 'package:flutter/material.dart';
import 'package:stylish_bottom_bar/src/model/bar_items.dart';
import 'package:stylish_bottom_bar/src/utils/enums.dart';
import 'package:stylish_bottom_bar/src/widgets/icon_widget.dart';
import 'package:stylish_bottom_bar/src/widgets/label_widget.dart';

class BubbleNavigationTile extends StatelessWidget {
  const BubbleNavigationTile(
    this.item,
    this.opacity,
    this.animation,
    this.iconSize,
    // this.unselectedIconColor,
    this.barStyle, {
    super.key,
    this.onTap,
    required this.flex,
    this.selected = false,
    this.indexLabel,
    this.ink = false,
    this.inkColor = Colors.grey,
    required this.padding,
    this.fillStyle,
    required this.itemBorderRadius,
  });

  // final BubbleBarItem item;
  final BottomBarItem item;
  final Animation<double> animation;
  final double iconSize;
  final VoidCallback? onTap;
  final double flex;
  final bool selected;
  final String? indexLabel;
  final double opacity;
  final bool ink;
  final Color? inkColor;
  // final Color? unselectedIconColor;
  final EdgeInsets padding;
  final BubbleBarStyle? barStyle;
  final BubbleFillStyle? fillStyle;
  final BorderRadius? itemBorderRadius;

  @override
  Widget build(BuildContext context) {
    ///flex size
    final flexSize = (flex * 1000.0).round();

    ///Label Widget
    var label = LabelWidget(
      animation: animation,
      item: item,
      // color: item.backgroundColor,
    );

    var isOutlined = selected && fillStyle == BubbleFillStyle.outlined;
    var isFilled = selected && fillStyle == BubbleFillStyle.fill;
    final barHeight = barStyle == BubbleBarStyle.horizontal
        ? 48.0
        : iconSize > 30.0 //decreased to 30 from 32
            ? 50.0 + (iconSize - 30.0) //decreased to 30 from 32
            : 50.0;

    return Expanded(
      flex: flexSize,
      child: Semantics(
        container: true,
        header: true,
        selected: selected,
        label: indexLabel,
        child: Padding(
          padding: padding,
          child: InkWell(
            onTap: onTap,
            borderRadius: itemBorderRadius ??
                const BorderRadius.horizontal(
                  right: Radius.circular(52),
                  left: Radius.circular(52),
                ),
            highlightColor: Colors.transparent,
            splashColor: ink ? inkColor : Colors.transparent,
            child: Container(
              // height: 48,
              height: barHeight,
              decoration: BoxDecoration(
                borderRadius: itemBorderRadius ??
                    const BorderRadius.horizontal(
                      right: Radius.circular(52),
                      left: Radius.circular(52),
                    ),
                border: Border.all(
                    width: isOutlined ? 1 : 0,
                    color: item.borderColor,
                    style: isOutlined ? BorderStyle.solid : BorderStyle.none),
                color: isFilled
                    ? item.backgroundColor?.withValues(alpha: opacity)
                    : Colors.transparent,
              ),
              child: barStyle == BubbleBarStyle.horizontal
                  ? Row(
                      crossAxisAlignment: CrossAxisAlignment.center,

                      ///Add space around selected item
                      mainAxisAlignment: selected
                          ? MainAxisAlignment.spaceEvenly
                          : MainAxisAlignment.center,
                      children: items(label),
                    )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.center,

                      ///Add space around selected item
                      mainAxisAlignment: selected
                          ? MainAxisAlignment.spaceEvenly
                          : MainAxisAlignment.center,
                      children: items(label),
                    ),
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> items(Widget label) {
    return [
      IconWidget(
        animation: animation,
        iconSize: iconSize,
        selected: selected,
        item: item,
      ),
      SizedBox(
        width: selected ? null : 0,
        child: AnimatedCrossFade(
          alignment: Alignment.center,
          firstChild: label,
          secondChild: SizedBox(),
          duration: const Duration(milliseconds: 250),
          sizeCurve: Curves.fastOutSlowIn,
          firstCurve: Curves.fastOutSlowIn,
          secondCurve: Curves.fastOutSlowIn.flipped,
          crossFadeState:
              selected ? CrossFadeState.showFirst : CrossFadeState.showSecond,
        ),
      ),
    ];
  }
}
