import 'package:example/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:stylish_bottom_bar/stylish_bottom_bar.dart';

void main() {
  testWidgets('StylishBottomBar Example smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());
    await tester.pumpAndSettle();

    // Verify selected home icon exists in bottom bar
    expect(find.byIcon(Icons.house_rounded), findsOneWidget);
    expect(
      find.descendant(
        of: find.byType(StylishBottomBar),
        matching: find.text('Home'),
      ),
      findsOneWidget,
    );
  });
}
