import 'package:flutter/material.dart';
import 'package:stylish_bottom_bar/src/core/bottom_bar_item.dart';
import 'package:stylish_bottom_bar/src/utils/enums.dart';

/// Abstract base contract for all bottom bar styles.
abstract class BottomBarOption {
  const BottomBarOption();

  /// Sizing / Padding offset applied to the bottom of the navigation bar.
  double get additionalBottomPadding => 4.0;

  /// Custom bar animation type (if supported by the style).
  BarAnimation? get barAnimation => null;

  /// Whether the style animates flex/layout on tick and requires controller listeners.
  bool get requiresControllerListener => false;

  /// Builds the navigation tile for item at index [index].
  Widget buildTile({
    required BuildContext context,
    required BottomBarItem item,
    required bool isSelected,
    required Animation<double> animation,
    required Animatable<double> flexTween,
    required VoidCallback? onTap,
    required String? indexLabel,
    required int index,
    required int totalLength,
  });

  /// Inserts spacing for Center Floating Action Button Docking.
  List<Widget> insertCenterFabSpacer(List<Widget> tiles) {
    final splitIndex = tiles.length ~/ 2;
    tiles.insert(splitIndex, const Spacer());
    return tiles;
  }
}
