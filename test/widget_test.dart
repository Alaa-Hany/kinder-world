import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kinder_world/app.dart';

void main() {
  testWidgets('App starts correctly', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const ProviderScope(child: KinderWorldApp()));

    // Verify that the app starts without errors.
    expect(find.byType(MaterialApp), findsOneWidget);
  });

  testWidgets('Theme is applied correctly', (WidgetTester tester) async {
    await tester.pumpWidget(const ProviderScope(child: KinderWorldApp()));

    // Verify that MaterialApp has a theme
    final materialApp = tester.widget<MaterialApp>(find.byType(MaterialApp));
    expect(materialApp.theme, isNotNull);
  });
}