import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';

import 'test_file.dart';

void main() {
  testWidgets('Test AnimatedBarExample', (WidgetTester tester) async {
    // Create and pump AnimatedBarExample widget to test.
    await tester.pumpWidget(const MaterialApp(home: AnimatedBarExample()));

    // Check if the "Home" icon is displayed.
    expect(find.byIcon(Icons.house_outlined), findsOneWidget);

    // Tap on the "Star" tab and check if the "Star" icon is displayed.
    await tester.tap(find.byIcon(Icons.star_border_rounded));
    await tester.pumpAndSettle();
    expect(find.byIcon(Icons.star_border_rounded), findsOneWidget);
  });
}
