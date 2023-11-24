import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:iiitd_mentorship/app/data/repository/meeting.dart';
import 'package:iiitd_mentorship/app/views/screens/schedule/create.dart';

void main() {
  testWidgets('ScheduleMeetingScreen UI Test', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: ScheduleMeetingScreen()));

    // Check if all the required widgets are present
    expect(find.byType(TextField), findsNWidgets(3));
    expect(find.byType(ListTile), findsNWidgets(3));
    expect(find.byType(ElevatedButton), findsOneWidget);

    // Specifically find the ElevatedButton with 'Schedule Meeting' text
    expect(find.widgetWithText(ElevatedButton, 'Schedule Meeting'),
        findsOneWidget);

    // Test TextFields
    await tester.enterText(find.byType(TextField).at(0), 'Meeting Title');
    await tester.enterText(find.byType(TextField).at(1), 'Meeting Description');
    await tester.enterText(
        find.byType(TextField).at(2), 'mentor@example.com, mentee@example.com');
    expect(find.text('mentor@example.com, mentee@example.com'), findsOneWidget);

    // Test Date and Time pickers
    await tester.tap(find.byType(ListTile).at(0)); // Tap the Date ListTile
    await tester.pumpAndSettle();
    await tester.tap(find.text('OK'));
    await tester.pumpAndSettle();

    await tester
        .tap(find.byType(ListTile).at(1)); // Tap the Start Time ListTile
    await tester.pumpAndSettle();
    await tester.tap(find.text('OK'));
    await tester.pumpAndSettle();

    await tester.tap(find.byType(ListTile).at(2)); // Tap the End Time ListTile
    await tester.pumpAndSettle();
    await tester.tap(find.text('OK'));
    await tester.pumpAndSettle();

    // Test Schedule Meeting Button
    await tester.tap(find.widgetWithText(ElevatedButton, 'Schedule Meeting'));
    await tester.pumpAndSettle();
  });

  testWidgets('ScheduleMeetingScreen Functionality Test',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: ScheduleMeetingScreen()));

    // Simulate user input
    await tester.enterText(find.byType(TextField).at(0), 'Meeting Title');
    await tester.enterText(find.byType(TextField).at(1), 'Meeting Description');
    await tester.enterText(
        find.byType(TextField).at(2), 'mentor@example.com, mentee@example.com');

    // Simulate scheduling a meeting
    await tester.tap(find.widgetWithText(ElevatedButton, 'Schedule Meeting'));
    await tester.pumpAndSettle();

    // Validate that a meeting was scheduled
    //expect(MeetingData.meetings.isNotEmpty, true);
  });
}
