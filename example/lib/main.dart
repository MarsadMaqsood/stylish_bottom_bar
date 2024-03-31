import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stylish_bottom_bar/stylish_bottom_bar.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Stylish Bottom Navigation Bar Example',
      theme: ThemeData(
        // useMaterial3: true,
        primarySwatch: Colors.green,
      ),
      // home: const BubbelBarExample(),
      home: const AnimatedBarExample(),
    );
  }
}

class AnimatedBarExample extends StatefulWidget {
  const AnimatedBarExample({super.key});

  @override
  State<AnimatedBarExample> createState() => _AnimatedBarExampleState();
}

class _AnimatedBarExampleState extends State<AnimatedBarExample> {
  int selected = 0;
  bool heart = false;
  final controller = PageController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true, //to make floating action button notch transparent

      //to avoid the floating action button overlapping behavior,
      // when a soft keyboard is displayed
      // resizeToAvoidBottomInset: false,

      bottomNavigationBar: StylishBottomBar(
        // option: AnimatedBarOptions(
        //   // iconSize: 32,
        //   barAnimation: BarAnimation.blink,
        //   iconStyle: IconStyle.animated,

        //   // opacity: 0.3,
        // ),
        option: DotBarOptions(
          dotStyle: DotStyle.tile,
          gradient: const LinearGradient(
            colors: [
              Colors.deepPurple,
              Colors.pink,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        items: [
          BottomBarItem(
            icon: const Icon(
              Icons.house_outlined,
            ),
            selectedIcon: const Icon(Icons.house_rounded),
            selectedColor: Colors.teal,
            unSelectedColor: Colors.grey,
            title: const Text('Home'),
            badge: const Text('9+'),
            showBadge: true,
            badgeColor: Colors.purple,
            badgePadding: const EdgeInsets.only(left: 4, right: 4),
          ),
          BottomBarItem(
            icon: const Icon(Icons.star_border_rounded),
            selectedIcon: const Icon(Icons.star_rounded),
            selectedColor: Colors.red,
            // unSelectedColor: Colors.purple,
            // backgroundColor: Colors.orange,
            title: const Text('Star'),
          ),
          BottomBarItem(
              icon: const Icon(
                Icons.style_outlined,
              ),
              selectedIcon: const Icon(
                Icons.style,
              ),
              selectedColor: Colors.deepOrangeAccent,
              title: const Text('Style')),
          BottomBarItem(
              icon: const Icon(
                Icons.person_outline,
              ),
              selectedIcon: const Icon(
                Icons.person,
              ),
              selectedColor: Colors.deepPurple,
              title: const Text('Profile')),
        ],
        hasNotch: true,
        fabLocation: StylishBarFabLocation.end,
        currentIndex: selected,
        notchStyle: NotchStyle.square,
        onTap: (index) {
          if (index == selected) return;
          controller.jumpToPage(index);
          setState(() {
            selected = index;
          });
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            heart = !heart;
          });
        },
        backgroundColor: Colors.white,
        child: Icon(
          heart ? CupertinoIcons.heart_fill : CupertinoIcons.heart,
          color: Colors.red,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      body: SafeArea(
        child: PageView(
          controller: controller,
          children: const [
            Center(child: Text('Home')),
            Center(child: Text('Star')),
            Center(child: Text('Style')),
            Center(child: Text('Profile')),
          ],
        ),
      ),
    );
  }
}

//
//Example to setup Bubble Bottom Bar with PageView
class BubbelBarExample extends StatefulWidget {
  const BubbelBarExample({super.key});

  @override
  State<BubbelBarExample> createState() => _BubbelBarExampleState();
}

class _BubbelBarExampleState extends State<BubbelBarExample> {
  PageController controller = PageController(initialPage: 0);
  var selected = 0;

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: controller,
        children: const [
          // Home(),
          // Add(),
          // Profile(),
        ],
      ),
      bottomNavigationBar: StylishBottomBar(
        option: BubbleBarOptions(
          // barStyle: BubbleBarStyle.vertical,
          barStyle: BubbleBarStyle.horizontal,
          bubbleFillStyle: BubbleFillStyle.fill,
          // bubbleFillStyle: BubbleFillStyle.outlined,
          opacity: 0.3,
        ),
        iconSpace: 12.0,
        items: [
          BottomBarItem(
            icon: const Icon(Icons.abc),
            title: const Text('Abc'),
            backgroundColor: Colors.red,

            // selectedColor: Colors.pink,
            selectedIcon: const Icon(Icons.read_more),
            badge: const Text('1+'),
            badgeColor: Colors.red,
            showBadge: true,
          ),
          BottomBarItem(
            icon: const Icon(Icons.safety_divider),
            title: const Text('Safety'),
            selectedColor: Colors.orange,
            backgroundColor: Colors.orange,
          ),
          BottomBarItem(
            icon: const Icon(Icons.cabin),
            title: const Text('Cabin'),
            backgroundColor: Colors.purple,
          ),
          BottomBarItem(
            icon: const Icon(Icons.cabin),
            title: const Text('Cabin'),
            backgroundColor: Colors.purple,
          ),
        ],
        fabLocation: StylishBarFabLocation.center,
        hasNotch: true,
        currentIndex: selected,
        onTap: (index) {
          setState(() {
            selected = index;
            controller.jumpToPage(index);
          });
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.emoji_emotions),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
