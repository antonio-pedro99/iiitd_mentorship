import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:iiitd_mentorship/app/data/model/meeting.dart';
import 'package:iiitd_mentorship/app/views/screens/schedule/meeting_details_page.dart';
import 'package:mockito/mockito.dart';

class MockNavigatorObserver extends Mock implements NavigatorObserver {}

class MockRoute extends Mock implements Route<dynamic> {}

void main() {
  group('MeetingDetailsPage Tests', () {
    late Meeting testMeeting;
    late MockNavigatorObserver mockObserver;

    setUp(() {
      testMeeting = Meeting('eventName', 'title', 'description', 'emailIDs',
          DateTime.now(), DateTime.now(), Colors.blue, true, 'userId');
      mockObserver = MockNavigatorObserver();
    });

    testWidgets('should display meeting details correctly', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: MeetingDetailsPage(meeting: testMeeting),
          navigatorObservers: [mockObserver],
        ),
      );

      expect(find.text('Meeting Details'), findsOneWidget);
      expect(find.text('Title'), findsOneWidget);
      expect(find.text('Description'), findsOneWidget);
      expect(find.text('Email IDs'), findsOneWidget);
      expect(find.text('Start'), findsOneWidget);
      expect(find.text('End'), findsOneWidget);
      expect(find.text(testMeeting.title), findsOneWidget);
      expect(find.text(testMeeting.description), findsOneWidget);
      expect(find.text(testMeeting.emailIDs), findsOneWidget);
    });

    testWidgets('should navigate back on meeting cancellation', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: MeetingDetailsPage(meeting: testMeeting),
          navigatorObservers: [mockObserver],
        ),
      );

      await tester.pumpAndSettle();
    });
  });
}
