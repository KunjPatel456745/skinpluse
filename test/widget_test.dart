import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:skinpulse_ai/main.dart';

void main() {
  testWidgets('App smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // Verify that our app shows the text.
    expect(find.text('Skinpulse AI'), findsOneWidget);
    expect(find.text('Phase 1 Completed successfully'), findsOneWidget);
  });
}
