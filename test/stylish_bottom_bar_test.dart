import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'test_file.dart';

void main() {
  testWidgets('Test AnimatedBarExample', (WidgetTester tester) async {
    // Create and pump AnimatedBarExample widget to test.
    await tester.pumpWidget(const MaterialApp(home: AnimatedBarExample()));

    // Check if the "Home" icon is displayed.
    expect(find.byIcon(Icons.house_rounded), findsOneWidget);
    expect(
      find.descendant(
        of: find.byType(PageView),
        matching: find.text('Home'),
      ),
      findsOneWidget,
    );

    // Tap on the "Star" tab and check if the "Star" icon is displayed.
    await tester.tap(find.byIcon(Icons.star_border_rounded));
    await tester.pumpAndSettle();

    expect(find.byIcon(Icons.star_rounded), findsOneWidget);
    expect(
      find.descendant(
        of: find.byType(PageView),
        matching: find.text('Star'),
      ),
      findsOneWidget,
    );
  });

  testWidgets('Test BubbleBarExample', (WidgetTester tester) async {
    // Create and pump AnimatedBarExample widget to test.
    await tester.pumpWidget(const MaterialApp(home: BubbelBarExample()));

    // Check if the "Home" icon is displayed.
    expect(find.byIcon(Icons.abc), findsNothing);

    // Tap on the "Star" tab and check if the "Star" icon is displayed.
    await tester.tap(find.byIcon(Icons.read_more));
    await tester.pumpAndSettle();
    expect(find.byIcon(Icons.star_border_rounded), findsNothing);
  });

  testWidgets('Test DotBarExample', (WidgetTester tester) async {
    // Create and pump AnimatedBarExample widget to test.
    await tester.pumpWidget(const MaterialApp(home: DotBarExample()));

    // Wait for the widget to be rendered.
    await tester.idle();

    expect(find.byWidget(const Text('Home')), findsNothing);

    // Wait for the widget to be updated.
    await tester.pumpAndSettle();

    // Check if the "Star" icon and title are displayed.
    expect(find.text('Star'), findsOneWidget);
  });
}
