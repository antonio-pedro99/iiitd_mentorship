import 'package:flutter_test/flutter_test.dart';
import 'package:iiitd_mentorship/app/data/model/topic.dart';

void main() {
  group('Topic', () {
    test('should create a Topic object with the given parameters', () {
      final topic = Topic(
        title: 'Test Title',
        description: 'Test Description',
        imageUrl: 'https://test.com/image.png',
        id: '1',
      );

      expect(topic.title, 'Test Title');
      expect(topic.description, 'Test Description');
      expect(topic.imageUrl, 'https://test.com/image.png');
      expect(topic.id, '1');
    });

    test('should return a list of Topic objects', () {
      final topics = Topic.topics();

      expect(topics.length, 3);
      expect(topics[0].title, 'Flutter');
      expect(topics[1].title, 'Dart');
      expect(topics[2].title, 'Firebase');
    });
  });
}