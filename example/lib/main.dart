import 'dart:async';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stylish_bottom_bar/stylish_bottom_bar.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Stylish Bottm Navigation Bar Example',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({
    Key? key,
  }) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var selected;

  late Timer timer;
  var bgColor;
  var heart = false;

  @override
  void initState() {
    super.initState();
    Random random = new Random();

    // timer = Timer.periodic(
    //     Duration(seconds: 5),
    //     (Timer t) => {
    //           setState(() {
    //             bgColor = Color.fromARGB(
    //                 random.nextInt(256),
    //                 random.nextInt(255),
    //                 random.nextInt(255),
    //                 random.nextInt(255));
    //           }),
    //         });
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedContainer(
        duration: Duration(milliseconds: 2000),
        color: bgColor ?? Colors.white,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(top: 30.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                BubbleNavigationBar(
                  items: [
                    BubbleBarItem(
                      backgroundColor: Colors.deepPurple,
                      icon: Icon(
                        Icons.home,
                      ),
                      badge: Text(
                        ' 1 ',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      badgeRadius: BorderRadius.circular(12),
                      showBadge: true,
                      badgeColor: Colors.red,
                      activeIcon: Icon(Icons.home),
                      title: Text("Home"),
                      borderColor: Colors.purple,
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
                        title: Text(
                          "Add",
                        )),
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
                  // inkColor: Colors.yellow,
                  barStyle: BubbleBarStyle.vertical,
                  currentIndex: selected ?? 0,
                  onTap: (index) {
                    setState(() {
                      selected = index;
                    });
                  },

                  iconSize: 38,
                  inkEffect: true,
                  opacity: 0.2,
                  hasNotch: false,
                  bubbleFillStyle: BubbleFillStyle.fill,
                  padding: EdgeInsets.all(4),
                ),
                SizedBox(
                  height: 30.0,
                ),
                BubbleNavigationBar(
                  items: [
                    BubbleBarItem(
                        backgroundColor: Colors.deepPurple,
                        icon: Icon(
                          Icons.home,
                        ),
                        activeIcon: Icon(Icons.home),
                        title: Text("Home")),
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
                        title: Text(
                          "Add",
                        )),
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
                  unselectedIconColor: Colors.black,
                  // inkColor: Colors.yellow,
                  barStyle: BubbleBarStyle.horizotnal,
                  currentIndex: selected ?? 0,
                  onTap: (index) {
                    setState(() {
                      selected = index;
                    });
                  },
                  iconSize: 38,
                  inkEffect: true,
                  opacity: 0.2,
                  hasNotch: false,
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: AnimatedNavigationBar(
        fabLocation: StylishBarFabLocation.end,
        hasNotch: true,
        items: [
          AnimatedBarItems(
              icon: Icon(
                Icons.home,
              ),
              selectedColor: Colors.deepPurple,
              backgroundColor: Colors.amber,
              title: Text('Home')),
          AnimatedBarItems(
              icon: Icon(
                Icons.add_circle_outline,
              ),
              selectedColor: Colors.green,
              backgroundColor: Colors.amber,
              title: Text('Add')),
          AnimatedBarItems(
              icon: Icon(
                Icons.person,
              ),
              backgroundColor: Colors.amber,
              selectedColor: Colors.pinkAccent,
              title: Text('Profile')),
        ],
        iconSize: 32,
        barAnimation: BarAnimation.transform3D,
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
      backgroundColor:
          bgColor != null ? bgColor.withOpacity(1.0) : Colors.white,
    );
  }
}
