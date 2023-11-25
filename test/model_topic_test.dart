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
}
