import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:iiitd_mentorship/app/data/model/meeting.dart';
import 'package:iiitd_mentorship/app/data/repository/meeting.dart';
import 'package:mockito/mockito.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MockFirebaseFirestore extends Mock implements FirebaseFirestore {}

class MockFirebaseAuth extends Mock implements FirebaseAuth {}

class MockCollectionReference extends Mock implements CollectionReference {}

class MockDocumentReference extends Mock implements DocumentReference {}

class MockQuerySnapshot extends Mock implements QuerySnapshot {}

class MockDocumentSnapshot extends Mock implements DocumentSnapshot {}

class MockUser extends Mock implements User {}

void main() {
  group('MeetingData', () {
    late MockFirebaseFirestore mockFirestore;
    late MockFirebaseAuth mockAuth;
    late MockCollectionReference mockCollection;
    late MockDocumentReference mockDocument;
    late MockQuerySnapshot mockQuerySnapshot;
    late MockUser mockUser;

    setUp(() {
      mockFirestore = MockFirebaseFirestore();
      mockAuth = MockFirebaseAuth();
      mockCollection = MockCollectionReference();
      mockDocument = MockDocumentReference();
      mockQuerySnapshot = MockQuerySnapshot();
      mockUser = MockUser();

      // Setup mock responses
      when(mockCollection.doc(any)).thenReturn(mockDocument);
      when(mockCollection.add(any)).thenAnswer((_) async => mockDocument);
      when(mockCollection.snapshots())
          .thenAnswer((_) => Stream.value(mockQuerySnapshot));
      when(mockAuth.currentUser).thenReturn(mockUser);
      when(mockUser.uid).thenReturn('testUID');
    });
  });

  group('MeetingDataSource', () {
    late List<Meeting> meetings;
    late MeetingDataSource dataSource;

    setUp(() {
      meetings = [
        //String eventName,   String title,   String description,   String emailIDs,   DateTime from,   DateTime to,   Color background,   bool isAllDay,   String userId,
        Meeting(
          'eventName1',
          'title',
          'description',
          'emailIDs',
          DateTime.now(),
          DateTime.now(),
          Colors.red,
          false,
          'userId',
        ),
        Meeting(
          'eventName2',
          'title',
          'description',
          'emailIDs',
          DateTime.now(),
          DateTime.now(),
          Colors.blue,
          false,
          'userId',
        ),
      ];
      dataSource = MeetingDataSource(meetings);
    });

    test('getStartTime returns correct start time for meetings', () {
      expect(dataSource.getStartTime(0), meetings[0].from);
      expect(dataSource.getStartTime(1), meetings[1].from);
    });

    test('getEndTime returns correct end time for meetings', () {
      expect(dataSource.getEndTime(0), meetings[0].to);
      expect(dataSource.getEndTime(1), meetings[1].to);
    });

    test('getSubject returns correct subject for meetings', () {
      expect(dataSource.getSubject(0), meetings[0].eventName);
      expect(dataSource.getSubject(1), meetings[1].eventName);
    });

    test('getColor returns correct color for meetings', () {
      expect(dataSource.getColor(0), meetings[0].background);
      expect(dataSource.getColor(1), meetings[1].background);
    });

    test('isAllDay returns correct all-day status for meetings', () {
      expect(dataSource.isAllDay(0), meetings[0].isAllDay);
      expect(dataSource.isAllDay(1), meetings[1].isAllDay);
    });

    test('DataSource handles empty meeting list', () {
      final emptyDataSource = MeetingDataSource([]);
      expect(emptyDataSource.appointments?.isEmpty, true);
      expect(() => emptyDataSource.getStartTime(0), throwsRangeError);
      expect(() => emptyDataSource.getEndTime(0), throwsRangeError);
      expect(() => emptyDataSource.getSubject(0), throwsRangeError);
      expect(() => emptyDataSource.getColor(0), throwsRangeError);
      expect(() => emptyDataSource.isAllDay(0), throwsRangeError);
    });
  });
}
