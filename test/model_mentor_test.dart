import 'package:flutter_test/flutter_test.dart';
import 'package:iiitd_mentorship/app/data/model/mentor.dart';

void main() {
  group('Mentor', () {
    test('fromJson should return a Mentor object', () {
      final json = {
        'bio': 'Test bio',
        'name': 'Test name',
        'photoUrl': 'Test photoUrl',
        'stars': 5,
      };

      final mentor = Mentor.fromJson(json);

      expect(mentor.bio, 'Test bio');
      expect(mentor.name, 'Test name');
      expect(mentor.photoUrl, 'Test photoUrl');
      expect(mentor.stars, 5);
    });

    test('fromJsonList should return a list of Mentor objects', () {
      final jsonList = [
        {
          'bio': 'Test bio 1',
          'name': 'Test name 1',
          'photoUrl': 'Test photoUrl 1',
          'stars': 5,
        },
        {
          'bio': 'Test bio 2',
          'name': 'Test name 2',
          'photoUrl': 'Test photoUrl 2',
          'stars': 4,
        },
      ];

      final mentors = Mentor.fromJsonList(jsonList);

      expect(mentors.length, 2);
      expect(mentors[0].bio, 'Test bio 1');
      expect(mentors[0].name, 'Test name 1');
      expect(mentors[0].photoUrl, 'Test photoUrl 1');
      expect(mentors[0].stars, 5);
      expect(mentors[1].bio, 'Test bio 2');
      expect(mentors[1].name, 'Test name 2');
      expect(mentors[1].photoUrl, 'Test photoUrl 2');
      expect(mentors[1].stars, 4);
    });

    test('toJson should return a JSON object', () {
      final mentor = Mentor(
        bio: 'Test bio',
        name: 'Test name',
        photoUrl: 'Test photoUrl',
        stars: 5,
      );

      final json = mentor.toJson();

      expect(json['bio'], 'Test bio');
      expect(json['name'], 'Test name');
      expect(json['photoUrl'], 'Test photoUrl');
      expect(json['stars'], 5);
    });

    test('getMentors should return a list of Mentor objects', () {
      final mentors = Mentor.getMentors();

      expect(mentors.length, 6);
      expect(mentors[0].bio,
          'Computer Science Student at UEM, with a passion for technology and innovation. I love to learn new things and share my knowledge with others.');
      expect(mentors[0].name, 'Antonio Pedro');
      expect(mentors[0].photoUrl,
          'https://images.unsplash.com/photo-1531384441138-2736e62e0919?auto=format&fit=crop&q=80&w=1587&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D');
      expect(mentors[0].stars, 5);
    });
  });
}
