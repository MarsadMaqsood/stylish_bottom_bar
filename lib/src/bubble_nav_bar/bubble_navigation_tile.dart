import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'bubble_item.dart';
import 'bubble_navigation_bar.dart';
import 'icon_widget.dart';
import 'label_widget.dart';

class BubbleNavigationTile extends StatelessWidget {
  const BubbleNavigationTile(
    this.item,
    this.opacity,
    this.animation,
    this.iconSize,
    this.unselectedIconColor,
    this.barStyle, {
    this.onTap,
    this.flex,
    this.selected = false,
    this.indexLabel,
    this.ink = false,
    this.inkColor = Colors.grey,
    this.padding,
  });

  final BubbleBarItem item;
  final Animation<double> animation;
  final double iconSize;
  final VoidCallback? onTap;
  final double? flex;
  final bool selected;
  final String? indexLabel;
  final double opacity;
  final bool ink;
  final Color? inkColor;
  final Color? unselectedIconColor;
  final EdgeInsets? padding;
  final BubbleBarStyle? barStyle;

  @override
  Widget build(BuildContext context) {
    ///Size
    var flexSize = (flex! * 1000.0).round();

    ///Label Widget
    var label = LabelWidget(
      animation: animation,
      item: item,
      color: item.backgroundColor!,
    );

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
                borderRadius: BorderRadius.horizontal(
                  right: Radius.circular(52),
                  left: Radius.circular(52),
                ),
                highlightColor: Colors.transparent,
                splashColor: ink
                    ? inkColor
                    // : Theme.of(context).splashColor
                    : Colors.transparent,
                child: Container(
                  // height: 48,
                  height: barStyle == BubbleBarStyle.horizotnal
                      ? 48
                      : iconSize > 32
                          ? 50 + (iconSize - 32)
                          : 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.horizontal(
                      right: Radius.circular(52),
                      left: Radius.circular(52),
                    ),
                    color: selected
                        ? item.backgroundColor!.withOpacity(opacity)
                        : Colors.transparent,
                  ),
                  child: this.barStyle == BubbleBarStyle.horizotnal
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
            Semantics(
              label: indexLabel,
            ),
          ],
        ),
      ),
    );
  }

  items(label) {
    return [
      IconWidget(
        animation: animation,
        iconSize: iconSize,
        selected: selected,
        unselectedIconColor: unselectedIconColor,
        item: item,
      ),
      AnimatedCrossFade(
        alignment: Alignment(0, 0),
        firstChild: label,
        secondChild: Container(),
        duration: Duration(milliseconds: 250),
        sizeCurve: Curves.fastOutSlowIn,
        firstCurve: Curves.fastOutSlowIn,
        secondCurve: Curves.fastOutSlowIn.flipped,
        crossFadeState:
            selected ? CrossFadeState.showFirst : CrossFadeState.showSecond,
      ),
    ];
  }
}
