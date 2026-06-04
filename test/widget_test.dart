// Basic smoke test for Bubble Pop.

import 'package:flutter_test/flutter_test.dart';

import 'package:bubble_pop/main.dart';

void main() {
  testWidgets('App builds without crashing', (WidgetTester tester) async {
    await tester.pumpWidget(const BubblePopApp());
    expect(find.byType(BubblePopApp), findsOneWidget);
  });
}
