import 'package:flutter/material.dart';
import 'bubble_item.dart';

const activeFontSize = 14.0;

class LabelWidget extends StatelessWidget {
  LabelWidget({
    Key? key,
    required this.animation,
    required this.item,
    required this.color,
  }) : super(key: key);

  final Animation<double> animation;
  final BubbleBarItem item;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      heightFactor: 1.0,
      child: Container(
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
      ),
    );
  }
}
