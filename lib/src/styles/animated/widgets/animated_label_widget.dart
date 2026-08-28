import 'package:flutter/material.dart';
import 'package:stylish_bottom_bar/src/core/bottom_bar_constants.dart';
import 'package:stylish_bottom_bar/src/core/bottom_bar_item.dart';
import 'package:stylish_bottom_bar/src/utils/enums.dart';

class AnimatedLabelWidget extends StatelessWidget {
  const AnimatedLabelWidget({
    super.key,
    required this.animation,
    required this.item,
    required this.color,
    required this.iconStyle,
  });

  final Animation<double>? animation;
  final BottomBarItem item;
  final Color color;
  final IconStyle iconStyle;

  @override
  Widget build(BuildContext context) {
    if (item.title == null) return const SizedBox.shrink();

    final text = DefaultTextStyle.merge(
      style: TextStyle(
        fontSize: activeFontSize,
        fontWeight: FontWeight.w600,
        color: color,
      ),
      child: item.title!,
    );

    return Align(
      alignment: Alignment.center,
      heightFactor: 1.0,
      child:
          (iconStyle == IconStyle.Default ||
                  iconStyle == IconStyle.defaultStyle) ||
              animation == null
          ? text
          : FadeTransition(
              alwaysIncludeSemantics: true,
              opacity: animation!,
              child: text,
            ),
    );
  }
}
