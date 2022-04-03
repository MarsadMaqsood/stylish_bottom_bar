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

enum BubbleBarStyle { vertical, horizotnal }

enum BubbleFillStyle { fill, outlined }
