import 'package:flutter/material.dart';
import 'package:stylish_bottom_bar/helpers/enums.dart';
import 'package:stylish_bottom_bar/model/bar_items.dart';
import 'package:stylish_bottom_bar/src/widgets/icon_widget.dart';
import 'package:stylish_bottom_bar/src/widgets/label_widget.dart';

class BubbleNavigationTile extends StatelessWidget {
  const BubbleNavigationTile(
    this.item,
    this.opacity,
    this.animation,
    this.iconSize,
    this.unselectedIconColor,
    this.barStyle, {
    super.key,
    this.onTap,
    required this.flex,
    this.selected = false,
    this.indexLabel,
    this.ink = false,
    this.inkColor = Colors.grey,
    this.padding,
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
  final Color? unselectedIconColor;
  final EdgeInsets? padding;
  final BubbleBarStyle? barStyle;
  final BubbleFillStyle? fillStyle;
  final BorderRadius? itemBorderRadius;

  @override
  Widget build(BuildContext context) {
    ///flex size
    var flexSize = (flex * 1000.0).round();

    ///Label Widget
    var label = LabelWidget(
      animation: animation,
      item: item,
      // color: item.backgroundColor,
    );

    var outlined = selected && fillStyle == BubbleFillStyle.outlined;
    var fill = selected && fillStyle == BubbleFillStyle.fill;
    final height = barStyle == BubbleBarStyle.horizotnal
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
        child: Stack(
          children: [
            Padding(
              padding: padding!,
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
                  height: height,
                  decoration: BoxDecoration(
                    borderRadius: itemBorderRadius ??
                        const BorderRadius.horizontal(
                          right: Radius.circular(52),
                          left: Radius.circular(52),
                        ),
                    border: Border.all(
                        width: outlined ? 1 : 0,
                        color: item.borderColor,
                        style: outlined ? BorderStyle.solid : BorderStyle.none),
                    color: fill
                        ? item.backgroundColor?.withOpacity(opacity)
                        : Colors.transparent,
                  ),
                  child: barStyle == BubbleBarStyle.horizotnal
                      ? Row(
                          crossAxisAlignment: CrossAxisAlignment.center,

                          ///Add space around selected item
                          mainAxisAlignment: selected
                              ? MainAxisAlignment.spaceEvenly
                              : MainAxisAlignment.center,
                          // children: items(label),
                          children: items(label).map((child) {
                            return selected ? Expanded(child: child) : child;
                          }).toList(),
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
            Semantics(
              label: indexLabel,
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> items(label) {
    return [
      IconWidget(
        animation: animation,
        iconSize: iconSize,
        selected: selected,
        unselectedIconColor: unselectedIconColor,
        item: item,
      ),
      AnimatedCrossFade(
        alignment: const Alignment(0, 0),
        firstChild: label,
        secondChild: Container(),
        duration: const Duration(milliseconds: 250),
        sizeCurve: Curves.fastOutSlowIn,
        firstCurve: Curves.fastOutSlowIn,
        secondCurve: Curves.fastOutSlowIn.flipped,
        crossFadeState:
            selected ? CrossFadeState.showFirst : CrossFadeState.showSecond,
      ),
    ];
  }
}
