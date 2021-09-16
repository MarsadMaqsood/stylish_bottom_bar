[![Hello](https://img.shields.io/badge/Hello-Sweet%20World-teal)](https://github.com/MarsadMaqsood) [![stylish_bottom_bar](https://img.shields.io/badge/Flutter-Stylish%20Bottom%20Bar-blueviolet)](https://pub.dev/packages/stylish_bottom_bar) [![Version](https://img.shields.io/pub/v/stylish_bottom_bar?color=%2354C92F&logo=dart)](https://pub.dev/packages/stylish_bottom_bar/install)


A collection of stylish bottom navigation bar like animated bottom bar and bubble bottom bar for flutter.

## ⭐  Installing

    dependencies:
        stylish_bottom_bar: ^0.0.2
        
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

```

### BarStyle
```dart
BubbleBarStyle.vertical
BubbleBarStyle.horizotnal
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
```

### Event
```dart
onTap: (index){
    
}
```

## Examples



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
    opacity: 0.3,
    currentIndex: selected ?? 0,
    onTap: (index) {
        setState(() {
            selected = index;
        });
    },
),

```

//Bubble


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
