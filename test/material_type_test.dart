import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:stylish_bottom_bar/stylish_bottom_bar.dart';

void main() {
  final boundaryKey = GlobalKey();
  const gradient = LinearGradient(colors: [Colors.red, Colors.orange]);
  const radius = BorderRadius.all(Radius.circular(20));

  Future<void> pumpBar(
    WidgetTester tester, {
    MaterialType? materialType,
    bool hasNotch = false,
    Gradient? backgroundGradient,
    ValueChanged<int>? onTap,
  }) async {
    final bar = StylishBottomBar(
      items: [
        BottomBarItem(icon: const Icon(Icons.home), title: const Text('Home')),
        BottomBarItem(
          icon: const Icon(Icons.search),
          title: const Text('Search'),
        ),
      ],
      option: const AnimatedBarOptions(),
      materialType: materialType ?? MaterialType.canvas,
      elevation: 16,
      backgroundColor: Colors.transparent,
      gradient: backgroundGradient,
      borderRadius: radius,
      hasNotch: hasNotch,
      onTap: onTap,
    );
    await tester.pumpWidget(
      RepaintBoundary(
        key: boundaryKey,
        child: MaterialApp(
          theme: ThemeData(useMaterial3: false),
          home: Scaffold(
            backgroundColor: Colors.blue,
            bottomNavigationBar: bar,
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();
  }

  Finder barMaterial() => find
      .descendant(
        of: find.byType(StylishBottomBar),
        matching: find.byType(Material),
      )
      .first;

  Future<List<int>> pixelAboveBar(WidgetTester tester) async {
    final rect = tester.getRect(find.byType(StylishBottomBar));
    final boundary =
        boundaryKey.currentContext!.findRenderObject()!
            as RenderRepaintBoundary;
    return (await tester.runAsync(() async {
      final image = await boundary.toImage();
      final data = (await image.toByteData(
        format: ui.ImageByteFormat.rawRgba,
      ))!;
      final offset =
          ((rect.top.toInt() - 2) * image.width + rect.center.dx.toInt()) * 4;
      final pixel = data.buffer.asUint8List(offset, 4).toList();
      image.dispose();
      return pixel;
    }))!;
  }

  testWidgets('Default surface retains its canvas type and elevation', (
    tester,
  ) async {
    expect(
      StylishBottomBar(
        items: [
          BottomBarItem(
            icon: const Icon(Icons.home),
            title: const Text('Home'),
          ),
          BottomBarItem(
            icon: const Icon(Icons.search),
            title: const Text('Search'),
          ),
        ],
        option: const AnimatedBarOptions(),
      ).materialType,
      MaterialType.canvas,
    );
    await pumpBar(tester);
    final material = tester.widget<Material>(barMaterial());
    expect(material.type, MaterialType.canvas);
    expect(material.elevation, 16);
    expect(
      find.descendant(of: barMaterial(), matching: find.byType(PhysicalShape)),
      findsOneWidget,
    );
  });

  testWidgets('Transparent surface removes the drawn elevation shadow', (
    tester,
  ) async {
    final previousDisableShadows = debugDisableShadows;
    debugDisableShadows = false;
    try {
      await pumpBar(tester);
      final defaultPixel = await pixelAboveBar(tester);
      await pumpBar(tester, materialType: MaterialType.transparency);
      expect(
        tester.widget<Material>(barMaterial()).type,
        MaterialType.transparency,
      );
      expect(
        find.descendant(
          of: barMaterial(),
          matching: find.byType(PhysicalShape),
        ),
        findsNothing,
      );
      expect(await pixelAboveBar(tester), [33, 150, 243, 255]);
      expect(defaultPixel, isNot([33, 150, 243, 255]));
    } finally {
      debugDisableShadows = previousDisableShadows;
    }
  });

  testWidgets('Transparent surface preserves gradient and rounded container', (
    tester,
  ) async {
    await pumpBar(
      tester,
      materialType: MaterialType.transparency,
      backgroundGradient: gradient,
    );
    final containers = tester.widgetList<Container>(
      find.descendant(
        of: barMaterial(),
        matching: find.byType(Container),
      ),
    );
    final decoration = containers
        .map((container) => container.decoration)
        .whereType<BoxDecoration>()
        .singleWhere((decoration) => decoration.gradient == gradient);
    expect(decoration.borderRadius, radius);
    expect(decoration.gradient, gradient);
  });

  testWidgets('Transparent surface keeps navigation taps working', (
    tester,
  ) async {
    int? selected;
    await pumpBar(
      tester,
      materialType: MaterialType.transparency,
      onTap: (index) => selected = index,
    );
    await tester.tap(find.byIcon(Icons.search));
    await tester.pumpAndSettle();
    expect(selected, 1);
    expect(tester.takeException(), isNull);
  });

  testWidgets('Notched bars retain their PhysicalShape elevation', (
    tester,
  ) async {
    await pumpBar(
      tester,
      materialType: MaterialType.transparency,
      hasNotch: true,
    );
    final shape = tester.widget<PhysicalShape>(
      find
          .descendant(
            of: find.byType(StylishBottomBar),
            matching: find.byType(PhysicalShape),
          )
          .first,
    );
    expect(shape.elevation, 16);
  });
}
