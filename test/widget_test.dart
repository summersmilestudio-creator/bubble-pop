// Basic smoke test for Bubble Pop.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:bubble_pop/main.dart';

void main() {
  testWidgets('App builds without crashing', (WidgetTester tester) async {
    SharedPreferences.setMockInitialValues({});
    await tester.pumpWidget(const BubblePopApp());
    expect(find.byType(BubblePopApp), findsOneWidget);
    // Let one-shot startup timers (e.g. the upgrader package) fire, then
    // dispose the tree so periodic timers / animations are cancelled before
    // the test framework checks for pending timers.
    await tester.pump(const Duration(seconds: 1));
    await tester.pumpWidget(const SizedBox());
  });
}
