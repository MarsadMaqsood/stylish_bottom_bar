## 1.2.0-beta
- Added: New `BarBlurOptions` style for floating translucent, frosted, and glassmorphic navigation:
  - `BarBlurOptions()`: Default standard frosted backdrop blur.
  - `BarBlurOptions.frosted()`: Convenience preset with single `sigma` configuration.
  - `BarBlurOptions.liquidGlass()`: Optical liquid glass with refraction, chromatic dispersion, and specular highlights.
  - `BarBlurOptions.custom()`: Allows loading custom `FragmentShader` programs and fine-tuning optical parameters.
- Added: Hardware-accelerated fragment shader (`shaders/liquid_glass.frag`) for realistic glass refraction and chromatic dispersion.
- Refactored: `AnimatedNavigationTiles` into modular sub-widgets (`AnimatedIconWidget`, `AnimatedLabelWidget`, `LiquidTileLayout`, `DropTileLayout`) for cleaner maintainability.
- Optimized: `AnimatedIconWidget` to reuse the parent `Animation<double>` object for synchronized animations and improved performance.
- Improved: `BubbleBarOptions` default opacity and border alpha blending in `BubbleNavigationTile`.
- Corrected `Semantics(enabled: true)` across `DotNavigationTiles`, ensuring unselected navigation items are fully announced and interactive in TalkBack / VoiceOver.
- Deduplicated `IconWidget` and `LabelWidget` declarations into single canonical widgets under `lib/src/widgets/`.
- Added constructor assertions across `BubbleBarOptions`, `AnimatedBarOptions`, and `DotBarOptions` for `iconSize > 0` and valid `opacity` ranges.
- Updated: Example application showcasing frosted blur, liquid glass shaders, and custom shader integration.
- Fixed: [#45](https://github.com/MarsadMaqsood/stylish_bottom_bar/issues/45)

## 1.1.1
- Fixed: [#40](https://github.com/MarsadMaqsood/stylish_bottom_bar/issues/40)
- Fixed: Animation issue in horizontal mode for BubbleBarItem
- Fixed: BubbleBarItem unselected color not updating correctly
- Fixed: [#30](https://github.com/MarsadMaqsood/stylish_bottom_bar/issues/30)
- Fixed: [#33](https://github.com/MarsadMaqsood/stylish_bottom_bar/issues/33)
- Fixed: [#37](https://github.com/MarsadMaqsood/stylish_bottom_bar/issues/37) 
- Fixed: [#38](https://github.com/MarsadMaqsood/stylish_bottom_bar/issues/38)
- Improved: Drop style
  - Eliminated visual glitch where the child icon appeared twice due to BlendMode.overlay.
  - Refactored child rendering to ensure a single, properly clipped instance.
  - Implemented multi-layered gradient effect for a realistic water drop look.
  - Adjusted transparency levels for smoother blending.
  - Improved shadow and depth effects for better realism.
- Thanks to PR [#32](https://github.com/MarsadMaqsood/stylish_bottom_bar/pull/32), [#34](https://github.com/MarsadMaqsood/stylish_bottom_bar/pull/34)


## 1.1.1-beta-2
- Fixed: [#40](https://github.com/MarsadMaqsood/stylish_bottom_bar/issues/40)
- Fixed: Animation issue in horizontal mode for BubbleBarItem
- Fixed: BubbleBarItem unselected color not updating correctly
- Improved: Drop style
  - Eliminated visual glitch where the child icon appeared twice due to BlendMode.overlay.
  - Refactored child rendering to ensure a single, properly clipped instance.
  - Implemented multi-layered gradient effect for a realistic water drop look.
  - Adjusted transparency levels for smoother blending.
  - Improved shadow and depth effects for better realism.


## 1.1.1-beta-1
- Fixed: [#30](https://github.com/MarsadMaqsood/stylish_bottom_bar/issues/30)
- Fixed: [#33](https://github.com/MarsadMaqsood/stylish_bottom_bar/issues/33)
- Fixed: [#37](https://github.com/MarsadMaqsood/stylish_bottom_bar/issues/37) 
- Fixed: [#38](https://github.com/MarsadMaqsood/stylish_bottom_bar/issues/38)

- Thanks to PR [#32](https://github.com/MarsadMaqsood/stylish_bottom_bar/pull/32), [#34](https://github.com/MarsadMaqsood/stylish_bottom_bar/pull/34)

## 1.1.0
- Added new style `DotBarOptions`
- Improved `BarAnimation.liquid`
- Updated documentation
- Removed unnecessary code

## 1.1.0-beta-3
- Updated documentation

## 1.1.0-beta-2
- Optimized the performance of `DotBarOptions` style
- Fixed: `Badge` padding issue [#22](https://github.com/MarsadMaqsood/stylish_bottom_bar/issues/22#issue-2029833633)
- Removed redundant code for increased efficiency.

## 1.1.0-beta
- Added new style `DotBarOptions`
- Added `NotchStyle`

## 1.0.3
- Fix: badge display issue when using `AnimatedBarOptions`
- Removed unnecessary code

## 1.0.2
- Fix: [#11](https://github.com/MarsadMaqsood/stylish_bottom_bar/issues/11)

## 1.0.1
- Fix: background color is not changing issue [#10](https://github.com/MarsadMaqsood/stylish_bottom_bar/issues/10)
- Fix: Bug fixes

## 1.0.0
- Changed: `items: List<dynamic>` to `List<BottomBarItem>`
- Added: `option:` `BubbleBarOptions` and `AnimatedBarOptions`
- Fix: Flutter 3.7 compatibility issue [#8](https://github.com/MarsadMaqsood/stylish_bottom_bar/issues/8). Thanks to PR [#7](https://github.com/MarsadMaqsood/stylish_bottom_bar/pull/7)

## 0.1.5
- Fix: issue [#5](https://github.com/MarsadMaqsood/stylish_bottom_bar/issues/5) where hover effect is not working properly

## 0.1.4
- Added `BarAnimation.drop`
- Performance Improvements

## 0.1.3
- Added support for Material3 design 
- Fixed height issue
- Fixed lint warnings
- Performance Improvements

## 0.1.2
- Removed unnecessary code
- Performance Improvements

## 0.1.1
- Removed unnecessary code
- Updated README.md

## 0.1.0
- Fixed issue [#2](https://github.com/MarsadMaqsood/stylish_bottom_bar/issues/2)

## 0.0.9
- Fix icon size issue
- Added default `IconStyle.Default`
- Updated Example

## 0.0.8
- Added `selectedIcon` in `AnimatedBarItems`.

## 0.0.7
- Added `BarAnimation.liquid`
- Merged `AnimatedNavigationBar` and `BubbleNavigationBar` into `StylishBottomBar` [See how to migrate](https://github.com/MarsadMaqsood/stylish_bottom_bar#migrate)
- Fixed some minor performance issues

## 0.0.6
 - Added `iconStyle:`
 - `IconStyle.animated` and `IconStyle.simple`
 - to remove animations and icon title use `IconStyle.simple`

## 0.0.5
 - Updated Example Code

## 0.0.4
 - Added `bubbleFillStyle:`
```dart
BubbleFillStyle.fill
BubbleFillStyle.outlined
```
 - Minor bug fixes

## 0.0.3
 - Added `BarAnimation.transform3D`
 - Performance improvements

## 0.0.2
 - Minor bug fixes

## 0.0.1+1
- Added `badgeRadius: `
- Minor bug fixes

## 0.0.1
- Initial release.
