import 'package:flutter/material.dart';
import 'package:stylish_bottom_bar/src/core/bottom_bar_constants.dart';
import 'package:stylish_bottom_bar/src/core/bottom_bar_item.dart';

class LabelWidget extends StatelessWidget {
  const LabelWidget({
    super.key,
    required this.animation,
    required this.item,
    this.color,
  });

  final Animation<double> animation;
  final BottomBarItem item;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    if (item.title == null) return const SizedBox.shrink();

    return Align(
      alignment: Alignment.center,
      heightFactor: 1.0,
      child: FadeTransition(
        alwaysIncludeSemantics: true,
        opacity: animation,
        child: DefaultTextStyle.merge(
          style: TextStyle(
            fontSize: activeFontSize,
            fontWeight: FontWeight.w600,
            color: color ?? item.backgroundColor ?? item.selectedColor,
          ),
          child: item.title!,
        ),
      ),
    );
  }
}
