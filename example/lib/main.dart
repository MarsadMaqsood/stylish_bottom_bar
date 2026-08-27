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
    Widget body = Stack(
      children: [
        // Vibrant colorful liquid glass backdrop (matching reference image)
        Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFFE91E63), Color(0xFF9C27B0), Color(0xFF3F51B5)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        Positioned(
          left: -40,
          top: 100,
          child: Container(
            width: 220,
            height: 220,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: const Color(0xFFFF4081).withValues(alpha: 0.8),
            ),
          ),
        ),
        Positioned(
          right: -20,
          top: 200,
          child: Container(
            width: 260,
            height: 260,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: const Color(0xFF00E5FF).withValues(alpha: 0.7),
            ),
          ),
        ),
        Positioned(
          right: 40,
          bottom: 40,
          child: Container(
            width: 200,
            height: 200,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: const Color(0xFFFF9100).withValues(alpha: 0.8),
            ),
          ),
        ),
        Positioned(
          left: 20,
          bottom: 60,
          child: Container(
            width: 180,
            height: 180,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: const Color(0xFF7C4DFF).withValues(alpha: 0.8),
            ),
          ),
        ),
        PageView(
          controller: controller,
          children: const [
            Center(
              child: Text(
                'Home Page',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Center(
              child: Text(
                'Feed Page',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Center(
              child: Text(
                'Search Page',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Center(
              child: Text(
                'Settings Page',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ],
    );

    return Scaffold(
      extendBody: true, //to make floating action button notch transparent
      //to avoid the floating action button overlapping behavior,
      // when a soft keyboard is displayed
      // resizeToAvoidBottomInset: false,

      bottomNavigationBar: StylishBottomBar(
        option: const AnimatedBarOptions(
          iconStyle: .animated,
        ),
        // backgroundColor: Colors.transparent,
        // option: const BarBlurOptions.frosted(),
        // margin: const EdgeInsets.only(left: 20, right: 20, bottom: 28),
        // borderRadius: BorderRadius.circular(36),
        currentIndex: selected,
        onTap: (index) {
          if (index == selected) return;
          controller.jumpToPage(index);
          setState(() {
            selected = index;
          });
        },
        items: [
          BottomBarItem(
            icon: const Icon(Icons.home_rounded),
            // selectedColor: Colors.white,
            // unSelectedColor: Colors.white60,
            title: const Text('Home'),
          ),
          BottomBarItem(
            icon: const Icon(Icons.home_rounded),
            // selectedColor: Colors.white,
            // unSelectedColor: Colors.white60,
            title: const Text('Home'),
          ),
          BottomBarItem(
            icon: const Icon(Icons.feed_outlined),
            selectedIcon: const Icon(Icons.feed_rounded),
            // selectedColor: Colors.white,
            // unSelectedColor: Colors.white60,
            title: const Text('Feed'),
          ),
          BottomBarItem(
            icon: const Icon(Icons.search_rounded),
            // selectedColor: Colors.white,
            // unSelectedColor: Colors.white60,
            title: const Text('Search'),
          ),
          BottomBarItem(
            icon: const Icon(Icons.settings_outlined),
            selectedIcon: const Icon(Icons.settings_rounded),
            // selectedColor: Colors.white,
            // unSelectedColor: Colors.white60,
            title: const Text('Settings'),
          ),
        ],
      ),
      body: body,
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
            title: const Text('Safety Divider'),
            selectedColor: Colors.orange,
            backgroundColor: Colors.orange,
          ),
          BottomBarItem(
            icon: const Icon(Icons.cabin),
            title: const Text('Cabin'),
            backgroundColor: Colors.purple,
          ),
          // BottomBarItem(
          //   icon: const Icon(Icons.cabin),
          //   title: const Text('Cabin'),
          //   backgroundColor: Colors.purple,
          // ),
        ],
        hasNotch: true,
        currentIndex: selected,
        onTap: (index) {
          setState(() {
            selected = index;
            controller.jumpToPage(index);
          });
        },

        // fabLocation: StylishBarFabLocation.end,
      ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      // floatingActionButton: FloatingActionButton(onPressed: () {}),
    );
  }
}
