import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:iiitd_mentorship/app/data/model/meeting.dart';
import 'package:iiitd_mentorship/app/data/repository/meeting.dart';
import 'package:iiitd_mentorship/app/views/screens/schedule/schedule.dart';

void main() {
  group('MySchedulesScreen Tests', () {
    testWidgets('MySchedulesScreen should display Month Agenda View in AppBar', (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(home: MySchedulesScreen(title: 'Test')));
      expect(find.text('Month Agenda View'), findsOneWidget);
    });

    testWidgets('FloatingActionButton should navigate to ScheduleMeetingScreen', (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(home: MySchedulesScreen(title: 'Test')));
      await tester.tap(find.byType(FloatingActionButton));
      await tester.pumpAndSettle();
    });


  });

  group('MeetingDataSource Tests', () {
    final List<Meeting> testMeetings = [
      Meeting('Event 1', DateTime.now(), DateTime.now().add(const Duration(hours: 1)), Colors.red, false),
    ];

    test('GetStartTime returns correct start time', () {
      final dataSource = MeetingDataSource(testMeetings);
      expect(dataSource.getStartTime(0), testMeetings[0].from);
    });

    test('GetEndTime returns correct end time', () {
      final dataSource = MeetingDataSource(testMeetings);
      expect(dataSource.getEndTime(0), testMeetings[0].to);
    });

    test('GetSubject returns correct subject', () {
      final dataSource = MeetingDataSource(testMeetings);
      expect(dataSource.getSubject(0), testMeetings[0].eventName);
    });

    test('GetColor returns correct color', () {
      final dataSource = MeetingDataSource(testMeetings);
      expect(dataSource.getColor(0), testMeetings[0].background);
    });

    test('IsAllDay returns correct value', () {
      final dataSource = MeetingDataSource(testMeetings);
      expect(dataSource.isAllDay(0), testMeetings[0].isAllDay);
    });
  });
}
