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
  ///Show simple style icons without any animation
  simple,

  ///Show icons with animations
  animated,
}

enum BubbleBarStyle { vertical, horizotnal }

enum BubbleFillStyle { fill, outlined }
