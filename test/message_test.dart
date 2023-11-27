import 'package:flutter_test/flutter_test.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:iiitd_mentorship/app/data/model/chat/message.dart';

void main() {
  group('Message class tests', () {
    final timestamp = Timestamp.now();

    // Test for toJson method
    test('toJson returns a map with correct key-value pairs', () {
      final message = Message(
        senderId: 'senderId123',
        senderEmail: 'sender@example.com',
        receiverId: 'receiverId456',
        message: 'Hello, World!',
        timestamp: timestamp,
      );

      final json = message.toJson();

      expect(json['senderId'], 'senderId123');
      expect(json['senderEmail'], 'sender@example.com');
      expect(json['receiverId'], 'receiverId456');
      expect(json['message'], 'Hello, World!');
      expect(json['timestamp'], timestamp);
    });

    // Test for fromJson method
    test('fromJson returns a Message object with correct data', () {
      final json = {
        'senderId': 'senderId123',
        'senderEmail': 'sender@example.com',
        'receiverId': 'receiverId456',
        'message': 'Hello, World!',
        'timestamp': timestamp,
      };

      final message = Message.fromJson(json);

      expect(message.senderId, 'senderId123');
      expect(message.senderEmail, 'sender@example.com');
      expect(message.receiverId, 'receiverId456');
      expect(message.message, 'Hello, World!');
      expect(message.timestamp, timestamp);
    });

    // Test for fromJson with null or missing fields
    test('fromJson handles null or missing fields gracefully', () {
      final json = {
        'senderId': 'senderId123',
        'senderEmail': 'sender@example.com',
        // 'receiverId' is intentionally missing
        'message': 'Hello, World!',
        'timestamp': timestamp,
      };

      expect(() => Message.fromJson(json), throwsA(isA<TypeError>()));
    });

    // Test toJson and fromJson for round-trip consistency
    test('toJson and fromJson are consistent in round-trip', () {
      final originalMessage = Message(
        senderId: 'senderId123',
        senderEmail: 'sender@example.com',
        receiverId: 'receiverId456',
        message: 'Test Message',
        timestamp: timestamp,
      );

      final json = originalMessage.toJson();
      final reconstructedMessage = Message.fromJson(json);

      expect(reconstructedMessage.senderId, originalMessage.senderId);
      expect(reconstructedMessage.senderEmail, originalMessage.senderEmail);
      expect(reconstructedMessage.receiverId, originalMessage.receiverId);
      expect(reconstructedMessage.message, originalMessage.message);
      expect(reconstructedMessage.timestamp, originalMessage.timestamp);
    });

    // Test for handling empty string fields
    test('Handles empty string fields correctly', () {
      final timestamp = Timestamp.now();
      final message = Message(
        senderId: '',
        senderEmail: '',
        receiverId: '',
        message: '',
        timestamp: timestamp,
      );

      expect(message.senderId, isEmpty);
      expect(message.senderEmail, isEmpty);
      expect(message.receiverId, isEmpty);
      expect(message.message, isEmpty);
    });

    // Test for handling very long string fields
    test('Handles long string fields correctly', () {
      final longString = 'a' * 1000; // 1000 character long string
      final timestamp = Timestamp.now();
      final message = Message(
        senderId: longString,
        senderEmail: longString,
        receiverId: longString,
        message: longString,
        timestamp: timestamp,
      );

      expect(message.senderId.length, 1000);
      expect(message.senderEmail.length, 1000);
      expect(message.receiverId.length, 1000);
      expect(message.message.length, 1000);
    });

    // Test for JSON with additional unexpected fields
    test('fromJson ignores extra fields in JSON', () {
      final json = {
        'senderId': 'senderId123',
        'senderEmail': 'sender@example.com',
        'receiverId': 'receiverId456',
        'message': 'Hello, World!',
        'timestamp': Timestamp.now(),
        'extraField': 'unexpected' // Extra field
      };

      final message = Message.fromJson(json);

      expect(message.toJson().containsKey('extraField'), isFalse);
    });

    // Test for JSON with different data types
    test('fromJson handles incorrect data types', () {
      final json = {
        'senderId': 123, // should be a string
        'senderEmail': 'sender@example.com',
        'receiverId': 'receiverId456',
        'message': 'Hello, World!',
        'timestamp': 'not a timestamp', // should be a Timestamp
      };

      expect(() => Message.fromJson(json), throwsA(isA<TypeError>()));
    });

    // Test for handling special characters in string fields
    test('Handles special characters in strings correctly', () {
      final specialCharString = '@#\$%^&*()_+';
      final timestamp = Timestamp.now();
      final message = Message(
        senderId: specialCharString,
        senderEmail: 'test@example.com',
        receiverId: 'receiverId',
        message: specialCharString,
        timestamp: timestamp,
      );

      expect(message.senderId, specialCharString);
      expect(message.message, specialCharString);
    });

    // Test for handling timestamp in the future
    test('Handles future timestamp correctly', () {
      final futureTimestamp = Timestamp.fromDate(DateTime.now().add(Duration(days: 365)));
      final message = Message(
        senderId: 'senderId',
        senderEmail: 'sender@example.com',
        receiverId: 'receiverId',
        message: 'Future message',
        timestamp: futureTimestamp,
      );

      expect(message.timestamp, futureTimestamp);
    });

    // Test for handling timestamp in the distant past
    test('Handles old timestamp correctly', () {
      final oldTimestamp = Timestamp.fromDate(DateTime(2000, 1, 1));
      final message = Message(
        senderId: 'senderId',
        senderEmail: 'sender@example.com',
        receiverId: 'receiverId',
        message: 'Old message',
        timestamp: oldTimestamp,
      );

      expect(message.timestamp, oldTimestamp);
    });

    // Test for handling invalid email formats
    test('Handles invalid email format correctly', () {
      final invalidEmail = 'invalid-email-format';
      final message = Message(
        senderId: 'senderId',
        senderEmail: invalidEmail,
        receiverId: 'receiverId',
        message: 'Test Message',
        timestamp: Timestamp.now(),
      );

      expect(message.senderEmail, invalidEmail); // Assuming no validation in class
    });

    // Test for JSON with boolean values instead of strings
    test('fromJson handles boolean values instead of strings', () {
      final json = {
        'senderId': true, // Incorrect type
        'senderEmail': false, // Incorrect type
        'receiverId': 'receiverId',
        'message': 'Hello, World!',
        'timestamp': Timestamp.now(),
      };

      expect(() => Message.fromJson(json), throwsA(isA<TypeError>()));
    });

  });
}
