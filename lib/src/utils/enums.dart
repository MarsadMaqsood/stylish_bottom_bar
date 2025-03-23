/// Defines the location of the FloatingActionButton in the Stylish Bottom Bar.
enum StylishBarFabLocation {
  /// Places the FAB at the center of the bottom bar.
  center,

  /// Places the FAB at the end (typically the right side) of the bottom bar.
  end,
}

/// Specifies the animation style for bar items.
enum BarAnimation {
  /// Fades the bar item in and out.
  fade,

  /// Blinks the bar item.
  blink,

  /// Applies a 3D transformation to the bar item.
  transform3D,

  /// Adds a liquid-like effect to the icon. When clicked, the icon hides,
  /// and a rectangular shape with circular radius appears with the title.
  ///
  /// Note: This animation is not yet fully customized.
  liquid,

  /// Adds a water drop effect to the icon.
  drop,
}

/// Defines the style of icons in the bottom bar.
enum IconStyle {
  /// Both the icon and title widgets are visible, and the color of the selected item changes.
  ///
  /// Note: This is the default style.
  // ignore: constant_identifier_names
  Default,

  /// Displays simple style icons without any animation.
  simple,

  /// Displays icons with animations.
  animated,
}

/// Determines the alignment of bubble bar items.
enum BubbleBarStyle {
  /// Aligns bubble bar items vertically.
  vertical,

  /// Aligns bubble bar items horizontally.
  horizontal,
}

/// Specifies the fill style of bubble bar items.
enum BubbleFillStyle {
  /// Fills the background of the bubble bar item.
  fill,

  /// Outlines the border of the bubble bar item.
  outlined,
}

/// Indicates the movement direction or status.
enum MovingStatus {
  /// Moving to the right.
  right,

  /// Moving to the left.
  left,
}

//
enum DotStyle {
  circle,
  tile,
}

enum NotchStyle {
  circle,
  square,
  themeDefault,
}
