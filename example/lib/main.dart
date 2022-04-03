import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stylish_bottom_bar/stylish_bottom_bar.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Stylish Bottom Navigation Bar Example',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    Key? key,
  }) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  dynamic selected;
  var heart = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true, //to make floating action button notch transparent
      bottomNavigationBar: StylishBottomBar(
        items: [
          AnimatedBarItems(
              icon: const Icon(
                Icons.house_outlined,
              ),
              selectedIcon: const Icon(Icons.house_rounded),
              selectedColor: Colors.deepPurple,
              backgroundColor: Colors.amber,
              title: const Text('Home')),
          AnimatedBarItems(
              icon: const Icon(Icons.star_border_rounded),
              selectedIcon: const Icon(Icons.star_rounded),
              selectedColor: Colors.green,
              backgroundColor: Colors.amber,
              title: const Text('Star')),
          AnimatedBarItems(
              icon: const Icon(
                Icons.style_outlined,
              ),
              selectedIcon: const Icon(
                Icons.style,
              ),
              backgroundColor: Colors.amber,
              selectedColor: Colors.deepOrangeAccent,
              title: const Text('Style')),
          AnimatedBarItems(
              icon: const Icon(
                Icons.person_outline,
              ),
              selectedIcon: const Icon(
                Icons.person,
              ),
              backgroundColor: Colors.amber,
              selectedColor: Colors.pinkAccent,
              title: const Text('Profile')),
          // BubbleBarItem(icon: const Icon(Icons.abc), title: const Text('Abc')),
          // BubbleBarItem(
          //     icon: const Icon(Icons.safety_divider),
          //     title: const Text('Safety')),
          // BubbleBarItem(
          //     icon: const Icon(Icons.cabin), title: const Text('Cabin')),
        ],
        iconSize: 32,
        barAnimation: BarAnimation.fade,
        // iconStyle: IconStyle.animated,

        iconStyle: IconStyle.animated,
        hasNotch: true,
        fabLocation: StylishBarFabLocation.end,
        opacity: 0.3,
        currentIndex: selected ?? 0,
        onTap: (index) {
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
    );
  }
}

//
//Example to setup Stylish Bottom Bar with PageView
class PageExample extends StatefulWidget {
  const PageExample({Key? key}) : super(key: key);

  @override
  _PageExampleState createState() => _PageExampleState();
}

class _PageExampleState extends State<PageExample> {
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
        items: [
          BubbleBarItem(
            icon: const Icon(Icons.abc),
            title: const Text('Abc'),
          ),
          BubbleBarItem(
            icon: const Icon(Icons.safety_divider),
            title: const Text('Safety'),
          ),
          BubbleBarItem(
            icon: const Icon(Icons.cabin),
            title: const Text('Cabin'),
          ),
        ],
        fabLocation: StylishBarFabLocation.end,
        hasNotch: true,
        // iconSize: 32,
        // barStyle: BubbleBarStyle.horizotnal,
        barStyle: BubbleBarStyle.vertical,
        bubbleFillStyle: BubbleFillStyle.fill,
        // bubbleFillStyle: BubbleFillStyle.outlined,
        opacity: 0.3,
        currentIndex: selected,
        onTap: (index) {
          setState(() {
            selected = index!;
            controller.jumpToPage(index);
          });
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.emoji_emotions),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
    );
  }
}
