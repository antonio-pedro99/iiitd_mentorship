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
          isProfileComplete: true
      );

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
          isProfileComplete: true
      );

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
}
