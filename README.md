[![Hello](https://img.shields.io/badge/Hello-Sweet%20World-teal)](https://github.com/MarsadMaqsood) [![stylish_bottom_bar](https://img.shields.io/badge/Flutter-Stylish%20Bottom%20Bar-blueviolet)](https://pub.dev/packages/stylish_bottom_bar) [![Version](https://img.shields.io/pub/v/stylish_bottom_bar?color=%2354C92F&logo=dart)](https://pub.dev/packages/stylish_bottom_bar/install)


A collection of stylish bottom navigation bars like animated bottom bar and bubble bottom bar for flutter.


## Table of contents
- [Installing](#installing)
- [How To Use](#how_to_use)
- [Showcase](#showcase)
- [Migrate to 1.0.0](#migrate)
- [Example](#example)

## ⭐  Installing <a name="installing"></a>

    dependencies:
        stylish_bottom_bar: ^1.0.3

## ⚡ Import

```dart
import 'package:stylish_bottom_bar/stylish_nav.dart';
```

## 📙 How To Use <a name="how_to_use"></a>
```dart
items:
option:
backgroundColor:
elevation:
currentIndex:
iconSize:
padding:
inkEffect:
inkColor:
onTap:
opacity:
borderRadius:
fabLocation:
hasNotch:
barAnimation:
barStyle:
unselectedIconColor:
bubbleFillStyle:
iconStyle:
selectedIcon:
```

## Properties

```dart
items → List<BottomBarItem>
option → AnimatedBarOptions
option → BubbleBarOptions
backgroundColor → Color
elevation → double
currentIndex → int
iconSize → double
padding → EdgeInsets
inkEffect → bool
inkColor → Color
onTap → Function(int)
opacity → double
borderRadius → BorderRadius
fabLocation → StylishBarFabLocation
hasNotch → bool
barAnimation → BarAnimation
barStyle → BubbleBarStyle
unselectedIconColor → Color
bubbleFillStyle → BubbleFillStyle
iconStyle → IconStyle
```

### BarStyle
```dart
BubbleBarStyle.vertical
BubbleBarStyle.horizotnal
```

### BubbleFillStyle
```dart
BubbleFillStyle.fill
BubbleFillStyle.outlined
```

### FabLocation
```dart
StylishBarFabLocation.center
StylishBarFabLocation.end
```

### BarAnimation
```dart
BarAnimation.fade
BarAnimation.blink
BarAnimation.transform3D
BarAnimation.liquid
BarAnimation.drop
```

### IconStyle
```dart
IconStyle.Default
IconStyle.simple
IconStyle.animated
```

### Event
```dart
onTap: (index){
    
}
```

## Showcase <a name="showcase"></a>

**AnimatedNavigationBar**

`IconStyle.Default`

<img width="356" height="100" src="https://raw.githubusercontent.com/MarsadMaqsood/stylish_bottom_bar/master/showcase/29.gif">

<img width="356" height="100" src="https://raw.githubusercontent.com/MarsadMaqsood/stylish_bottom_bar/master/showcase/27.gif">

<img width="356" height="100" src="https://raw.githubusercontent.com/MarsadMaqsood/stylish_bottom_bar/master/showcase/28.gif">

---

`IconStyle.simple`

<img width="356" height="100" src="https://raw.githubusercontent.com/MarsadMaqsood/stylish_bottom_bar/master/showcase/25.gif">

---

`IconStyle.animated`

<img width="356" height="100" src="https://raw.githubusercontent.com/MarsadMaqsood/stylish_bottom_bar/master/showcase/21.gif">

<img width="356" height="100" src="https://raw.githubusercontent.com/MarsadMaqsood/stylish_bottom_bar/master/showcase/20.gif">


<img width="356" height="100" src="https://raw.githubusercontent.com/MarsadMaqsood/stylish_bottom_bar/master/showcase/26.gif">

---

`BarAnimation.fade`

<img src="https://github.com/MarsadMaqsood/stylish_bottom_bar/raw/master/showcase/9.gif?raw=true">
<img src="https://github.com/MarsadMaqsood/stylish_bottom_bar/raw/master/showcase/10.gif?raw=true">

---

`BarAnimation.blink`

<img src="https://github.com/MarsadMaqsood/stylish_bottom_bar/raw/master/showcase/11.gif?raw=true">

---
`BarAnimation.liquid`

<img width="356" height="100" src="https://raw.githubusercontent.com/MarsadMaqsood/stylish_bottom_bar/master/showcase/23.gif">

<img width="356" height="100" src="https://raw.githubusercontent.com/MarsadMaqsood/stylish_bottom_bar/master/showcase/24.gif">

---

`BarAnimation.drop`

<img width="356" height="70" src="https://raw.githubusercontent.com/MarsadMaqsood/stylish_bottom_bar/master/showcase/1.gif">

<img width="356" height="100" src="https://raw.githubusercontent.com/MarsadMaqsood/stylish_bottom_bar/master/showcase/2.gif">

<img width="356" height="100" src="https://raw.githubusercontent.com/MarsadMaqsood/stylish_bottom_bar/master/showcase/3.gif">


---
**BubbleNavigationBar**

`BubbleBarStyle.horizotnal`

<img src="https://github.com/MarsadMaqsood/stylish_bottom_bar/raw/master/showcase/6.gif?raw=true">
<img src="https://github.com/MarsadMaqsood/stylish_bottom_bar/raw/master/showcase/7.gif?raw=true">

`BubbleFillStyle.outlined`

<img src="https://github.com/MarsadMaqsood/stylish_bottom_bar/raw/master/showcase/14.gif?raw=true">
<img src="https://github.com/MarsadMaqsood/stylish_bottom_bar/raw/master/showcase/15.gif?raw=true">


`BubbleBarStyle.vertical`

<img src="https://github.com/MarsadMaqsood/stylish_bottom_bar/raw/master/showcase/4.gif?raw=true">


`BubbleFillStyle.outlined`

<img src="https://github.com/MarsadMaqsood/stylish_bottom_bar/raw/master/showcase/12.gif?raw=true">

<img src="https://github.com/MarsadMaqsood/stylish_bottom_bar/raw/master/showcase/13.gif?raw=true">

## Migrate to 1.0.0 <a name="migrate"></a>

`List<dynamic> items` is changed to `List<BottomBarItem> items`

From version **1.0.0** `option:` `AnimatedBarOptions` and `BubbleBarOptions` will be used to change the bar items type and properties.

## Example <a name="example"></a>

```dart
StylishBottomBar(
//  option: AnimatedBarOptions(
//    iconSize: 32,
//    barAnimation: BarAnimation.liquid,
//    iconStyle: IconStyle.animated,
//    opacity: 0.3,
//  ),
  option: BubbleBarOptions(
    barStyle: BubbleBarStyle.horizotnal,
    // barStyle: BubbleBarStyle.vertical,
    bubbleFillStyle: BubbleFillStyle.fill,
    // bubbleFillStyle: BubbleFillStyle.outlined,
    opacity: 0.3,
  ),
  items: [
    BottomBarItem(
      icon: const Icon(Icons.abc),
      title: const Text('Abc'),
      backgroundColor: Colors.red,
      selectedIcon: const Icon(Icons.read_more),
    ),
    BottomBarItem(
      icon: const Icon(Icons.safety_divider),
      title: const Text('Safety'),
      backgroundColor: Colors.orange,
    ),
    BottomBarItem(
      icon: const Icon(Icons.cabin),
      title: const Text('Cabin'),
      backgroundColor: Colors.purple,
    ),
  ],
  fabLocation: StylishBarFabLocation.end,
  hasNotch: true,
  currentIndex: selected,
  onTap: (index) {
    setState(() {
      selected = index;
      controller.jumpToPage(index);
    });
  },
)

```


Contributions and pull requests are welcome! We value your input and appreciate any improvements or suggestions you can provide. Feel free to submit a pull request with your changes. Don't forget to star the repository if you find it useful. Thank you for your collaboration!