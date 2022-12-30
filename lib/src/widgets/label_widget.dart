import 'package:flutter/material.dart';
import 'package:stylish_bottom_bar/helpers/constant.dart';
import 'package:stylish_bottom_bar/model/bubble_item.dart';

class LabelWidget extends StatelessWidget {
  const LabelWidget({
    super.key,
    required this.animation,
    required this.item,
    required this.color,
  });

  final Animation<double> animation;
  final BubbleBarItem item;
  final Color color;

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
            color: color,
          ),
          child: item.title!,
        ),
      ),
    );
  }
}
