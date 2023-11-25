import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:iiitd_mentorship/app/views/screens/schedule/create.dart';
import 'package:mockito/annotations.dart';

@GenerateMocks([FirebaseAuth, User])
void main() {
  group('ScheduleMeetingScreen Tests', () {
    testWidgets('renders correctly', (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(home: ScheduleMeetingScreen()));

      expect(find.text('Schedule Meeting'), findsWidgets);
      expect(find.text('Meeting Title'), findsWidgets);
      expect(find.text('Meeting Description'), findsWidgets);
      expect(find.text('Email IDs'), findsWidgets);
      expect(find.text('Date'), findsWidgets);
      expect(find.text('Start Time'), findsWidgets);
      expect(find.text('End Time'), findsWidgets);
      expect(find.text('Schedule Meeting'), findsWidgets);
    });

    testWidgets('opens date picker when date tile is tapped',
        (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(home: ScheduleMeetingScreen()));
      await tester.tap(find.text('Date'));
      await tester.pumpAndSettle();

      expect(find.byType(DatePickerDialog), findsOneWidget);
    });

    testWidgets('opens time picker when start time tile is tapped',
        (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(home: ScheduleMeetingScreen()));
      await tester.tap(find.text('Start Time'));
      await tester.pumpAndSettle();

      expect(find.byType(TimePickerDialog), findsOneWidget);
    });

    testWidgets('opens time picker when end time tile is tapped',
        (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(home: ScheduleMeetingScreen()));
      await tester.tap(find.text('End Time'));
      await tester.pumpAndSettle();

      expect(find.byType(TimePickerDialog), findsOneWidget);
    });

    // testWidgets('shows error snackbar when attempting to schedule meeting with empty fields', (WidgetTester tester) async {
    //   await tester.pumpWidget(MaterialApp(home: ScheduleMeetingScreen()));
    //   tester.ensureVisible(find.text('Schedule Meeting'));
    //   await tester.tap(find.text('Schedule Meeting'));
    //   await tester.pumpAndSettle();
    //
    //   expect(find.byType(SnackBar), findsOneWidget);
    //   expect(find.text("All fields are required"), findsOneWidget);
    // });
    //
    // testWidgets('shows error when fields are empty and Schedule Meeting button is pressed', (WidgetTester tester) async {
    //   await tester.pumpWidget(MaterialApp(home: ScheduleMeetingScreen()));
    //   tester.ensureVisible(find.text('Schedule Meeting'));
    //   await tester.tap(find.text('Schedule Meeting'));
    //   await tester.pump();
    //   expect(find.text('All fields are required'), findsOneWidget);
    // });
  });
}
