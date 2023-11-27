import 'package:flutter_test/flutter_test.dart';
import 'package:iiitd_mentorship/app/data/model/user.dart';

void main() {
  group('DBUser', () {
    test('DBUser constructor initializes properties correctly', () {
      final user = DBUser(
          college: 'Example College',
          yearOfGraduation: '2023',
          adminApproval: true,
          yearOfJoining: '2020',
          branch: 'Computer Science',
          uid: 'uid123',
          photoUrl: 'http://example.com/photo.jpg',
          name: 'John Doe',
          course: 'B.Tech',
          company: 'Example Company',
          isMentor: true,
          email: 'john@example.com',
          isProfileComplete: true);

      expect(user.college, 'Example College');
      expect(user.yearOfGraduation, '2023');
      expect(user.adminApproval, true);
      expect(user.yearOfJoining, '2020');
      // Continue for other properties...
    });

    test('fromJson creates a DBUser from JSON', () {
      final json = {
        'college': 'Example College',
        'yearOfGraduation': '2023',
        'adminApproval': true,
        'yearOfJoining': '2020',
        'branch': 'Computer Science',
        'uid': 'uid123',
        'photoUrl': 'http://example.com/photo.jpg',
        'name': 'John Doe',
        'course': 'B.Tech',
        'company': 'Example Company',
        'isMentor': true,
        'email': 'john@example.com',
        'isProfileComplete': true
      };

      final user = DBUser.fromJson(json);

      expect(user, isA<DBUser>());
      expect(user.college, 'Example College');
      expect(user.yearOfGraduation, '2023');
      expect(user.adminApproval, true);
      expect(user.yearOfJoining, '2020');
      expect(user.branch, 'Computer Science');
      expect(user.uid, 'uid123');
      expect(user.photoUrl, 'http://example.com/photo.jpg');
      expect(user.name, 'John Doe');
      expect(user.course, 'B.Tech');
      expect(user.company, 'Example Company');
      expect(user.isMentor, true);
      expect(user.email, 'john@example.com');
      expect(user.isProfileComplete, true);
    });

    test('toJson converts a DBUser to JSON', () {
      final user = DBUser(
          college: 'Example College',
          yearOfGraduation: '2023',
          adminApproval: true,
          yearOfJoining: '2020',
          branch: 'Computer Science',
          uid: 'uid123',
          photoUrl: 'http://example.com/photo.jpg',
          name: 'John Doe',
          course: 'B.Tech',
          company: 'Example Company',
          isMentor: true,
          email: 'john@example.com',
          isProfileComplete: true);

      final json = user.toJson();

      expect(json, isA<Map<String, dynamic>>());
      expect(json['college'], 'Example College');
      expect(json['yearOfGraduation'], '2023');
      expect(json['adminApproval'], true);
      expect(json['yearOfJoining'], '2020');
      expect(json['branch'], 'Computer Science');
      expect(json['uid'], 'uid123');
      expect(json['photoUrl'], 'http://example.com/photo.jpg');
      expect(json['name'], 'John Doe');
      expect(json['course'], 'B.Tech');
      expect(json['company'], 'Example Company');
      expect(json['isMentor'], true);
      expect(json['email'], 'john@example.com');
      expect(json['isProfileComplete'], true);
    });
  });

  group('DBUser additional tests', () {
    test('DBUser constructor with null values', () {
      final user = DBUser();

      expect(user.college, isNull);
      expect(user.yearOfGraduation, isNull);
      expect(user.adminApproval, isNull);
      expect(user.yearOfJoining, isNull);
      expect(user.branch, isNull);
      expect(user.uid, isNull);
      expect(user.photoUrl, isNull);
      expect(user.name, isNull);
      expect(user.course, isNull);
      expect(user.company, isNull);
      expect(user.isMentor, isNull);
      expect(user.email, isNull);
      expect(user.isProfileComplete, isNull);
    });

    test('fromJson with null values', () {
      final json = <String, dynamic>{};

      final user = DBUser.fromJson(json);

      expect(user, isA<DBUser>());
      expect(user.college, isNull);
      expect(user.yearOfGraduation, isNull);
      expect(user.adminApproval, isNull);
      expect(user.yearOfJoining, isNull);
      expect(user.branch, isNull);
      expect(user.uid, isNull);
      expect(user.photoUrl, isNull);
      expect(user.name, isNull);
      expect(user.course, isNull);
      expect(user.company, isNull);
      expect(user.isMentor, isNull);
      expect(user.email, isNull);
      expect(user.isProfileComplete, isNull);
    });

    test('toJson with null values', () {
      final user = DBUser();

      final json = user.toJson();

      expect(json, isA<Map<String, dynamic>>());
      expect(json['college'], isNull);
      expect(json['yearOfGraduation'], isNull);
      expect(json['adminApproval'], isNull);
      expect(json['yearOfJoining'], isNull);
      expect(json['branch'], isNull);
      expect(json['uid'], isNull);
      expect(json['photoUrl'], isNull);
      expect(json['name'], isNull);
      expect(json['course'], isNull);
      expect(json['company'], isNull);
      expect(json['isMentor'], isNull);
      expect(json['email'], isNull);
      expect(json['isProfileComplete'], isNull);
    });

    test('fromJson with incomplete data', () {
      final json = {
        'college': 'Example College',
        'yearOfGraduation': '2023',
        // Missing other fields
      };

      final user = DBUser.fromJson(json);

      expect(user.college, 'Example College');
      expect(user.yearOfGraduation, '2023');
      // Expect other fields to be null
      expect(user.adminApproval, isNull);
      expect(user.yearOfJoining, isNull);
      expect(user.branch, isNull);
      expect(user.uid, isNull);
      expect(user.photoUrl, isNull);
      expect(user.name, isNull);
      expect(user.course, isNull);
      expect(user.company, isNull);
      expect(user.isMentor, isNull);
      expect(user.email, isNull);
      expect(user.isProfileComplete, isNull);
    });

    test('toJson with partial data', () {
      final user = DBUser(college: 'Example College', yearOfGraduation: '2023');

      final json = user.toJson();

      expect(json, isA<Map<String, dynamic>>());
      expect(json['college'], 'Example College');
      expect(json['yearOfGraduation'], '2023');
      // Expect other fields to be null
      expect(json['adminApproval'], isNull);
      expect(json['yearOfJoining'], isNull);
      expect(json['branch'], isNull);
      expect(json['uid'], isNull);
      expect(json['photoUrl'], isNull);
      expect(json['name'], isNull);
      expect(json['course'], isNull);
      expect(json['company'], isNull);
      expect(json['isMentor'], isNull);
      expect(json['email'], isNull);
      expect(json['isProfileComplete'], isNull);
    });
  });

  group('DBUser comprehensive tests', () {
    // Testing constructor with mixed null and non-null values
    test('DBUser constructor with mixed values', () {
      final user = DBUser(
        college: 'Tech University',
        // Intentionally leaving some fields as null
        email: 'tech@example.com',
      );

      expect(user.college, 'Tech University');
      expect(user.yearOfGraduation, isNull);
      expect(user.email, 'tech@example.com');
      // Verifying other fields are null
      expect(user.name, isNull);
      expect(user.isMentor, isNull);
    });

    // Testing fromJson with unexpected data types
    test('fromJson with incorrect data types', () {
      final json = {
        'college': 123, // Incorrect data type
        'yearOfGraduation': '2023',
        'adminApproval': 'true', // Incorrect data type
        'email': null,
      };

      expect(() => DBUser.fromJson(json), throwsA(isA<TypeError>()));
    });

    // Testing toJson with special characters
    test('toJson with special characters in strings', () {
      final user = DBUser(
        name: 'John Doe @2023',
        email: 'john@doe.com',
        college: 'Tech & Research University',
      );

      final json = user.toJson();

      expect(json, isA<Map<String, dynamic>>());
      expect(json['name'], 'John Doe @2023');
      expect(json['email'], 'john@doe.com');
      expect(json['college'], 'Tech & Research University');
    });

    // Testing the effect of changing properties post object creation
    test('Modifying properties after object creation', () {
      final user = DBUser(college: 'Old College');

      // Changing the value post creation
      user.college = 'New College';

      expect(user.college, 'New College');
    });

    // Testing toJson with very long strings
    test('toJson with very long strings', () {
      final longString = 'x' * 1000; // 1000 character long string
      final user = DBUser(name: longString, email: longString);

      final json = user.toJson();

      expect(json, isA<Map<String, dynamic>>());
      expect(json['name'], longString);
      expect(json['email'], longString);
    });
  });
  }
