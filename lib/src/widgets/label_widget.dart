import 'package:flutter/material.dart';
import 'package:stylish_bottom_bar/src/model/bar_items.dart';
import 'package:stylish_bottom_bar/src/utils/constant.dart';

class LabelWidget extends StatelessWidget {
  const LabelWidget({
    super.key,
    required this.animation,
    required this.item,
  });

  final Animation<double> animation;
  final BottomBarItem item;

  @override
  Widget build(BuildContext context) {
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
            color: item.backgroundColor ?? item.selectedColor,
          ),
          child: item.title!,
        ),
      ),
    );
  }
}
