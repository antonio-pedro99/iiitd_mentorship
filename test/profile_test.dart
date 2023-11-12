import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:iiitd_mentorship/app/views/screens/profile/profile.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

void main() {
  group('ProfileScreen Tests', () {
    testWidgets('Initial State Test', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: ProfileScreen()));
      expect(find.text('Antonio Pedro'), findsOneWidget);
      expect(find.text('tonio.pedro99@gmail.com'), findsOneWidget);
      expect(find.byType(TextFormField), findsNWidgets(3));
      expect(find.byType(CircleAvatar), findsOneWidget);
    });

    testWidgets('Edit Name Test', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: ProfileScreen()));
      await tester.tap(find.byIcon(Icons.edit).first);
      await tester.pump();
      expect(find.widgetWithText(TextFormField, 'Antonio Pedro'), findsOneWidget);
      await tester.enterText(find.widgetWithText(TextFormField, 'Antonio Pedro'), 'New Name');
      await tester.pump();
      expect(find.text('New Name'), findsNothing);
    });

    testWidgets('Edit Email Test', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: ProfileScreen()));
      await tester.tap(find.byIcon(Icons.edit).last);
      await tester.pump();
      expect(find.widgetWithText(TextFormField, 'tonio.pedro99@gmail.com'), findsOneWidget);
      await tester.enterText(find.widgetWithText(TextFormField, 'tonio.pedro99@gmail.com'), 'new.email@example.com');
      await tester.tap(find.byIcon(Icons.check));
      await tester.pump();
      expect(find.text('new.email@example.com'), findsOneWidget);
    });

    testWidgets('Form Validation Test', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: ProfileScreen()));
      // Test for empty name field
      await tester.tap(find.byIcon(Icons.edit).first);
      await tester.pump();
      await tester.enterText(find.widgetWithText(TextFormField, 'Antonio Pedro'), '');
      await tester.pump();
      expect(find.text('Name cannot be empty'), findsNothing);

      // Test for invalid email
      await tester.tap(find.byIcon(Icons.edit).last);
      await tester.pump();
      await tester.enterText(find.widgetWithText(TextFormField, 'tonio.pedro99@gmail.com'), 'invalid-email');
      await tester.tap(find.byIcon(Icons.check));
      await tester.pump();
      expect(find.text('Please enter a valid email'), findsOneWidget);
    });

    // Additional tests can be written for image picking and other functionalities
  });
}
