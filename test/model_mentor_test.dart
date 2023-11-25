import 'package:flutter_test/flutter_test.dart';
import 'package:iiitd_mentorship/app/data/model/mentor.dart';

void main() {
  group('Mentor', () {
    test('fromJson creates a Mentor from JSON', () {
      final json = {
        'bio': 'Sample Bio',
        'name': 'Sample Name',
        'photoUrl': 'http://example.com/photo.jpg',
        'stars': 4
      };

      final mentor = Mentor.fromJson(json);

      expect(mentor, isA<Mentor>());
      expect(mentor.bio, 'Sample Bio');
      expect(mentor.name, 'Sample Name');
      expect(mentor.photoUrl, 'http://example.com/photo.jpg');
      expect(mentor.stars, 4);
    });

    test('fromJsonList creates a list of Mentors from JSON list', () {
      final jsonList = [
        {
          'bio': 'Bio 1',
          'name': 'Name 1',
          'photoUrl': 'http://example.com/photo1.jpg',
          'stars': 5
        },
        {
          'bio': 'Bio 2',
          'name': 'Name 2',
          'photoUrl': 'http://example.com/photo2.jpg',
          'stars': 3
        }
      ];

      final mentors = Mentor.fromJsonList(jsonList);

      expect(mentors, isA<List<Mentor>>());
      expect(mentors.length, 2);
      expect(mentors[0].name, 'Name 1');
      expect(mentors[1].name, 'Name 2');
    });

    test('toJson converts a Mentor to JSON', () {
      final mentor = Mentor(
          bio: 'Sample Bio',
          name: 'Sample Name',
          photoUrl: 'http://example.com/photo.jpg',
          stars: 4);

      final json = mentor.toJson();

      expect(json, isA<Map<String, dynamic>>());
      expect(json['bio'], 'Sample Bio');
      expect(json['name'], 'Sample Name');
      expect(json['photoUrl'], 'http://example.com/photo.jpg');
      expect(json['stars'], 4);
    });

    test('getMentors returns a predefined list of Mentors', () {
      final mentors = Mentor.getMentors();

      expect(mentors, isA<List<Mentor>>());
      expect(mentors.isNotEmpty, true);
    });
  });
}
