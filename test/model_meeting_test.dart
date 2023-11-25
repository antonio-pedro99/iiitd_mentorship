import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:iiitd_mentorship/app/data/model/meeting.dart';

void main() {
  group('Meeting', () {
    test('Meeting constructor initializes properties correctly', () {
      final meeting = Meeting(
          'Event Name',
          'Title',
          'Description',
          'email@example.com',
          DateTime(2023, 1, 1, 9, 0),
          DateTime(2023, 1, 1, 10, 0),
          Colors.blue,
          false,
          'userId123');

      expect(meeting.eventName, 'Event Name');
      expect(meeting.title, 'Title');
      expect(meeting.description, 'Description');
      expect(meeting.emailIDs, 'email@example.com');
      expect(meeting.from, DateTime(2023, 1, 1, 9, 0));
      expect(meeting.to, DateTime(2023, 1, 1, 10, 0));
      expect(meeting.background, Colors.blue);
      expect(meeting.isAllDay, false);
      expect(meeting.userId, 'userId123');
    });

    test('fromMap creates a Meeting from Map', () {
      final map = {
        'eventName': 'Event Name',
        'title': 'Title',
        'description': 'Description',
        'emailIDs': 'email@example.com',
        'from': Timestamp.fromDate(DateTime(2023, 1, 1, 9, 0)),
        'to': Timestamp.fromDate(DateTime(2023, 1, 1, 10, 0)),
        'background': Colors.blue.value,
        'isAllDay': false,
        'userId': 'userId123'
      };

      final meeting = Meeting.fromMap(map, 'eventId123');

      expect(meeting.eventId, 'eventId123');
      expect(meeting.eventName, 'Event Name');
      expect(meeting.title, 'Title');
      expect(meeting.description, 'Description');
      expect(meeting.emailIDs, 'email@example.com');
      expect(meeting.from, DateTime(2023, 1, 1, 9, 0));
      expect(meeting.to, DateTime(2023, 1, 1, 10, 0));
      expect(meeting.isAllDay, false);
    });

    test('toMap converts a Meeting to Map', () {
      final meeting = Meeting(
          'Event Name',
          'Title',
          'Description',
          'email@example.com',
          DateTime(2023, 1, 1, 9, 0),
          DateTime(2023, 1, 1, 10, 0),
          Colors.blue,
          false,
          'userId123');

      final map = meeting.toMap();

      expect(map, isA<Map<String, dynamic>>());
      expect(map['eventName'], 'Event Name');
      expect(map['title'], 'Title');
      expect(map['description'], 'Description');
      expect(map['emailIDs'], 'email@example.com');
      expect(map['from'], DateTime(2023, 1, 1, 9, 0));
      expect(map['to'], DateTime(2023, 1, 1, 10, 0));
      expect(map['background'], Colors.blue.value);
      expect(map['isAllDay'], false);
    });
  });
}
