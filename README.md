[![Hello](https://img.shields.io/badge/Hello-Sweet%20World-teal)](https://github.com/MarsadMaqsood) [![stylish_bottom_bar](https://img.shields.io/badge/Flutter-Stylish%20Bottom%20Bar-blueviolet)](https://pub.dev/packages/stylish_bottom_bar) [![Version](https://img.shields.io/pub/v/stylish_bottom_bar?color=%2354C92F&logo=dart)](https://pub.dev/packages/stylish_bottom_bar/install)


A collection of stylish bottom navigation bar like animated bottom bar and bubble bottom bar for flutter.

## ⭐  Installing

    dependencies:
        stylish_bottom_bar: ^0.0.5
        
## ⚡ Import

```dart
import 'package:stylish_bottom_bar/stylish_nav.dart';
```

## 📙 How To Use
```dart
items:
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
```

## Properties

```dart
items → List<AnimatedBarItems>
items → List<BubbleBarItem>
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
```

### Event
```dart
onTap: (index){
    
}
```

## Examples

**AnimatedNavigationBar**

`BarAnimation.fade`

<img src="https://github.com/MarsadMaqsood/stylish_bottom_bar/raw/master/showcase/9.gif?raw=true">
<img src="https://github.com/MarsadMaqsood/stylish_bottom_bar/raw/master/showcase/10.gif?raw=true">

`BarAnimation.blink`

<img src="https://github.com/MarsadMaqsood/stylish_bottom_bar/raw/master/showcase/11.gif?raw=true">

```dart

AnimatedNavigationBar(
    items: [
        AnimatedBarItems(
            icon: Icon(
                Icons.home,
            ),
            selectedColor: Colors.deepPurple,
            backgroundColor: Colors.amber,
            title: Text('Home'),
        ),
        AnimatedBarItems(
            icon: Icon(
                Icons.add_circle_outline,
            ),
            selectedColor: Colors.green,
            backgroundColor: Colors.amber,
            title: Text('Add'),
        ),
    ],
    fabLocation: StylishBarFabLocation.end,
    hasNotch: false,
    iconSize: 32,
    barAnimation: BarAnimation.fade,
    //barAnimation: BarAnimation.blink,
    //barAnimation: BarAnimation.transform3D
    opacity: 0.3,
    currentIndex: selected ?? 0,
    onTap: (index) {
        setState(() {
            selected = index;
        });
    },
),

```
**BubbleNavigationBar**

`BubbleBarStyle.horizotnal`

<img src="https://github.com/MarsadMaqsood/stylish_bottom_bar/raw/master/showcase/6.gif?raw=true">
<img src="https://github.com/MarsadMaqsood/stylish_bottom_bar/raw/master/showcase/7.gif?raw=true">
<img src="https://github.com/MarsadMaqsood/stylish_bottom_bar/raw/master/showcase/8.gif?raw=true">

`BubbleFillStyle.outlined`

<img src="https://github.com/MarsadMaqsood/stylish_bottom_bar/raw/master/showcase/14.gif?raw=true">
<img src="https://github.com/MarsadMaqsood/stylish_bottom_bar/raw/master/showcase/15.gif?raw=true">


```dart

BubbleNavigationBar(
    items: [
        BubbleBarItem(
            backgroundColor: Colors.deepPurple,
            icon: Icon(
                    Icons.home,
                ),
            activeIcon: Icon(Icons.home),
            title: Text("Home"),
        ),
        
        BubbleBarItem(
            backgroundColor: Colors.green,
            icon: Icon(
                    Icons.add,
                    color: Colors.black,
                ),
            activeIcon: Icon(
                    Icons.add_circle_outline_outlined,
                    color: Colors.green,
                ),
            title: Text("Add"),
        ),
        BubbleBarItem(
            backgroundColor: Colors.pinkAccent,
            icon: Icon(
                Icons.person,
            ),
            title: Text(
              "Profile",
            ),
          ),
    ],
    unselectedIconColor: Colors.
    barStyle: BubbleBarStyle.horizotnal,
    //bubbleFillStyle: BubbleFillStyle.outlined,
    //bubbleFillStyle: BubbleFillStyle.fill,
    currentIndex: selected ?? 0,
    onTap: (index) {
        setState(() {
            selected = index;
        });
    },
    iconSize: 38,
    inkEffect: true,
    inkColor: Colors.purple,
    opacity: 0.2,
    hasNotch: false,
),

```

`BubbleBarStyle.vertical`

<img src="https://github.com/MarsadMaqsood/stylish_bottom_bar/raw/master/showcase/1.gif?raw=true">

<img src="https://github.com/MarsadMaqsood/stylish_bottom_bar/raw/master/showcase/2.gif?raw=true">
<img src="https://github.com/MarsadMaqsood/stylish_bottom_bar/raw/master/showcase/3.gif?raw=true">

<img src="https://github.com/MarsadMaqsood/stylish_bottom_bar/raw/master/showcase/4.gif?raw=true">

<img src="https://github.com/MarsadMaqsood/stylish_bottom_bar/raw/master/showcase/5.gif?raw=true">

`BubbleFillStyle.outlined`

<img src="https://github.com/MarsadMaqsood/stylish_bottom_bar/raw/master/showcase/12.gif?raw=true">

<img src="https://github.com/MarsadMaqsood/stylish_bottom_bar/raw/master/showcase/13.gif?raw=true">



```dart

BubbleNavigationBar(
    items: [
        BubbleBarItem(
            backgroundColor: Colors.deepPurple,
            icon: Icon(
                    Icons.home,
                ),
            activeIcon: Icon(Icons.home),
            title: Text("Home"),
        ),
        
        BubbleBarItem(
            backgroundColor: Colors.green,
            icon: Icon(
                    Icons.add,
                    color: Colors.black,
                ),
            activeIcon: Icon(
                    Icons.add_circle_outline_outlined,
                    color: Colors.green,
                ),
            title: Text("Add"),
        ),
        BubbleBarItem(
            backgroundColor: Colors.pinkAccent,
            icon: Icon(
                Icons.person,
            ),
            title: Text(
              "Profile",
            ),
          ),
    ],
    unselectedIconColor: Colors.
    barStyle: BubbleBarStyle.vertical,
    //bubbleFillStyle: BubbleFillStyle.outlined,
    //bubbleFillStyle: BubbleFillStyle.fill,
    currentIndex: selected ?? 0,
    onTap: (index) {
        setState(() {
            selected = index;
        });
    },
    iconSize: 38,
    inkEffect: true,
    inkColor: Colors.purple,
    opacity: 0.2,
    hasNotch: false,
),

```
