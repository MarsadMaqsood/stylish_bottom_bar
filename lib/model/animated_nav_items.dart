import 'package:flutter/material.dart';

// class AnimatedBarItems {
//   AnimatedBarItems({
//     required this.icon,
//     required this.title,
//     this.selectedIcon,
//     this.backgroundColor = Colors.black,
//     this.unSelectedColor = Colors.grey,
//     this.selectedColor = Colors.green,
//   });

//   final Widget? icon;
//   final Widget? selectedIcon;
//   final Widget? title;

//   ///Use this to change the background color
//   ///default color is [Colors.black]
//   final Color? backgroundColor;

//   ///Use this to change the selected item's icon color
//   ///default color is [Colors.green]
//   final Color selectedColor;

//   ///Use this to change the unselected item's icon color
//   ///default color is [Colors.grey]
//   final Color unSelectedColor;
// }

class AnimatedBarItems {
  AnimatedBarItems({
    required this.icon,
    required this.title,
    this.selectedIcon,
    this.backgroundColor = Colors.black,
    this.unSelectedColor = Colors.grey,
    this.selectedColor = Colors.green,
  });

  final Widget? icon;
  final Widget? selectedIcon;
  final Widget? title;

  ///Use this to change the background color
  ///default color is [Colors.black]
  final Color? backgroundColor;

  ///Use this to change the selected item's icon color
  ///default color is [Colors.green]
  final Color selectedColor;

  ///Use this to change the unselected item's icon color
  ///default color is [Colors.grey]
  final Color unSelectedColor;
}
