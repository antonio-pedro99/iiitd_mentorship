import 'package:flutter_test/flutter_test.dart';
import 'package:iiitd_mentorship/app/data/model/topic.dart';

void main() {
  group('Topic', () {
    test('Topic constructor initializes properties correctly', () {
      final topic = Topic(
          title: 'Sample Title',
          description: 'Sample Description',
          imageUrl: 'http://example.com/image.jpg',
          id: '1');

      expect(topic.title, 'Sample Title');
      expect(topic.description, 'Sample Description');
      expect(topic.imageUrl, 'http://example.com/image.jpg');
      expect(topic.id, '1');
    });

    test('topics static method returns predefined list of Topics', () {
      final topics = Topic.topics();

      expect(topics, isA<List<Topic>>());
      expect(topics.isNotEmpty, true);
      expect(topics[0].title, 'Flutter');
      expect(topics[1].title, 'Dart');
      expect(topics[2].title, 'Firebase');
    });
  });
  group('Topic Tests', () {
    // Test for verifying null values in Topic constructor
    test('Topic constructor handles null values', () {
      final topic = Topic();

      expect(topic.title, isNull);
      expect(topic.description, isNull);
      expect(topic.imageUrl, isNull);
      expect(topic.id, isNull);
    });

    // Test for verifying the count of topics returned by topics()
    test('topics static method returns correct number of topics', () {
      final topics = Topic.topics();

      expect(topics.length, 3);
    });

    // Test for verifying the content of each topic in the list
    test('topics static method returns topics with correct data', () {
      final topics = Topic.topics();

      expect(topics[0].description, contains('UI toolkit'));
      expect(topics[1].description, contains('client-optimized language'));
      expect(topics[2].description, contains('platform developed by Google'));
    });

    // Test for checking non-null imageUrl in topics
    test('All topics have non-null imageUrls', () {
      final topics = Topic.topics();

      for (var topic in topics) {
        expect(topic.imageUrl, isNotNull);
      }
    });

    // Test for checking specific details in a topic
    test('Specific topic details are correct', () {
      final topics = Topic.topics();
      final firebaseTopic = topics.firstWhere((topic) => topic.title == 'Firebase');

      expect(firebaseTopic.description, contains('platform developed by Google'));
      expect(firebaseTopic.imageUrl, 'https://firebase.google.com/images/brand-guidelines/logo-built_white.png');
      expect(firebaseTopic.id, '3');
    });

    // Test for null values in the list of topics
    test('Topics list does not contain null values', () {
      final topics = Topic.topics();

      expect(topics, isNot(contains(null)));
    });

    // Test for uniqueness of IDs in topics
    test('All topics have unique IDs', () {
      final topics = Topic.topics();
      var ids = topics.map((topic) => topic.id).toSet();

      expect(ids.length, topics.length);
    });
  });
}
