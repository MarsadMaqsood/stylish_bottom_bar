enum StylishBarFabLocation { center, end }

enum BarAnimation {
  fade,
  blink,
  transform3D,

  ///Adds liquid type effect on icon hides when clicked
  /// and a rectangular shape with circle radius is appeared with the title
  ///
  /// This animation is not yet fully customized
  liquid,

  ///Adds the water drop effect on the icon
  drop,
}

enum IconStyle {
  ///Both the icon and title widgets are visible and change the color of the selected item
  // ignore: constant_identifier_names
  Default,

  ///Show simple style icons without any animation
  simple,

  ///Show icons with animations
  animated,
}

enum BubbleBarStyle {
  ///Align bubble bar items vertically
  vertical,

  ///Align bubble bar items horizontally
  horizotnal
}

enum BubbleFillStyle {
  ///Fill the bubble bar item backgound
  fill,

  ///Outline this border of the bubble bar item
  outlined
}

enum MovingStatus {
  right,
  left,
  none,
}
