import 'package:flutter/material.dart';
import 'package:stylish_bottom_bar/helpers/enums.dart';

Widget innerWidget(
  context,
  double additionalBottomPadding,
  fabLocation,
  List<Widget> childs, [
  BarAnimation? barAnimation,
]) {
  return Padding(
    padding: const EdgeInsets.symmetric(
      horizontal: 10,
    ),
    child: ConstrainedBox(
      constraints: BoxConstraints(
          minHeight: kBottomNavigationBarHeight + additionalBottomPadding),
      child: Material(
        type: MaterialType.transparency,
        child: Padding(
          padding: EdgeInsets.only(
              bottom:
                  barAnimation != null && barAnimation == BarAnimation.liquid
                      ? 0
                      : additionalBottomPadding,
              right: fabLocation == StylishBarFabLocation.end ? 72 : 0),
          child: MediaQuery.removePadding(
            context: context,
            removeBottom: true,
            child: _container(childs),
          ),
        ),
      ),
    ),
  );
}

Widget _container(List<Widget> childs) {
  return DefaultTextStyle.merge(
    overflow: TextOverflow.ellipsis,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ...childs,
        // Text('as'),
      ],
    ),
  );
}
