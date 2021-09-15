import 'package:flutter/material.dart';

class AnimatedBarItems {
  AnimatedBarItems({
    required this.icon,
    required this.title,
    this.backgroundColor = Colors.black,
    this.unSelectedColor = Colors.grey,
    this.selectedColor = Colors.green,
  });

  final Widget? icon;
  final Widget? title;
  final Color? backgroundColor;
  final Color? selectedColor;
  final Color? unSelectedColor;
}
