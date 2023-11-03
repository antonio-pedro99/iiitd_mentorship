import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:iiitd_mentorship/app/views/screens/driver.dart';

void main() {
  // test bottom navigation bar on driver page
  testWidgets('BottomNavigationBar test', (WidgetTester tester) async {
    int _currentIndex = 0;

    // Build our app and trigger a frame.
    await tester.pumpWidget(
      const MaterialApp(home: DriverPage()),
    );

    expect(find.byType(BottomNavigationBar), findsOneWidget);

    await tester.tap(find.byIcon(Icons.home));
    await tester.pump();

    expect(_currentIndex, 0);
  });

  // test first page of PageView on driver page
  testWidgets('PageView test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(
      const MaterialApp(home: DriverPage()),
    );

    expect(find.byType(PageView), findsOneWidget);

    await tester.drag(find.byType(PageView), const Offset(-300.0, 0.0));
    await tester.pump();

    expect(find.text('Search'), findsOneWidget);
  });
}
