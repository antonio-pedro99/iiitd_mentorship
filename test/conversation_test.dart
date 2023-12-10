import 'package:flutter_test/flutter_test.dart';
import 'package:iiitd_mentorship/app/data/model/chat/conversation.dart';
import 'package:iiitd_mentorship/app/data/model/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() {
  group('ChatConversation Tests', () {
    const String testId = 'testId';
    const String testReceiverName = 'testReceiver';
    const String testSenderName = 'testSender';
    const String testReceiverImage = 'receiverImageUrl';
    const String testSenderImage = 'senderImageUrl';
    const String testLastMessage = 'Hello, Test!';
    final Timestamp testLastMessageTime = Timestamp.now();
    const bool testIsOnline = true;
    const bool testHasUnreadMessages = true;
    final List<dynamic> testUsers = ['user1', 'user2'];
    const int testUnreadMessagesCount = 5;
    final DBUser testReceiver = DBUser(uid: 'uid', name: 'name', photoUrl: 'url', email: 'email');

    // Testing ChatConversation.fromJson
    test('fromJson should return a valid instance of ChatConversation', () {
      final json = {
        'id': testId,
        'receiverName': testReceiverName,
        'senderName': testSenderName,
        'receiverImage': testReceiverImage,
        'senderImage': testSenderImage,
        'lastMessage': testLastMessage,
        'lastMessageTime': testLastMessageTime,
        'isOnline': testIsOnline,
        'hasUnreadMessages': testHasUnreadMessages,
        'users': testUsers,
        'unreadMessagesCount': testUnreadMessagesCount,
      };

      final chatConversation = ChatConversation.fromJson(json);

      expect(chatConversation, isA<ChatConversation>());
      expect(chatConversation.id, testId);
      expect(chatConversation.receiverName, testReceiverName);
      expect(chatConversation.senderName, testSenderName);
      expect(chatConversation.receiverImage, testReceiverImage);
      expect(chatConversation.senderImage, testSenderImage);
      expect(chatConversation.lastMessage, testLastMessage);
      expect(chatConversation.lastMessageTime, testLastMessageTime);
      expect(chatConversation.isOnline, testIsOnline);
      expect(chatConversation.hasUnreadMessages, testHasUnreadMessages);
      expect(chatConversation.users, testUsers);
      expect(chatConversation.unreadMessagesCount, testUnreadMessagesCount);
    });

    // Testing ChatConversation.copyWithConversation
    test('copyWithConversation should return a modified instance of ChatConversation', () {
      final originalChat = ChatConversation(id: testId, users: testUsers);
      final modifiedChat = ChatConversation.copyWithConversation(originalChat, receiverName: 'NewReceiver');

      expect(modifiedChat.receiverName, 'NewReceiver');
      expect(modifiedChat.id, originalChat.id);
      expect(modifiedChat.users, originalChat.users);
      expect(modifiedChat.senderName, originalChat.senderName);
      expect(modifiedChat.receiverImage, originalChat.receiverImage);
      expect(modifiedChat.senderImage, originalChat.senderImage);
      expect(modifiedChat.lastMessage, originalChat.lastMessage);
      expect(modifiedChat.lastMessageTime, originalChat.lastMessageTime);
      expect(modifiedChat.isOnline, originalChat.isOnline);
      expect(modifiedChat.hasUnreadMessages, originalChat.hasUnreadMessages);
      expect(modifiedChat.unreadMessagesCount, originalChat.unreadMessagesCount);
    });

    // Testing ChatConversation.copyWithReceiver
    test('copyWithReceiver should return a new instance with receiver details', () {
      final chatWithReceiver = ChatConversation.copyWithReceiver(testReceiver);

      expect(chatWithReceiver.receiverName, testReceiver.name);
      expect(chatWithReceiver.receiverImage, testReceiver.photoUrl);
      expect(chatWithReceiver.users.contains(testReceiver.uid), isTrue);
    });

    // Testing ChatConversation.toJson
    test('toJson should return a Map<String, dynamic> representation of ChatConversation', () {
      final chatConversation = ChatConversation(
        id: testId,
        receiverName: testReceiverName, users: [testReceiver.uid],
        senderName: testSenderName,
        receiverImage: testReceiverImage,
        senderImage: testSenderImage,
        lastMessage: testLastMessage,
        lastMessageTime: testLastMessageTime,
        isOnline: testIsOnline,
        hasUnreadMessages: testHasUnreadMessages,
        unreadMessagesCount: testUnreadMessagesCount,
      );

      final json = chatConversation.toJson();

      expect(json, isA<Map<String, dynamic>>());
      expect(json['id'], testId);
      expect(json['receiverName'], testReceiverName);
      expect(json['senderName'], testSenderName);
      expect(json['receiverImage'], testReceiverImage);
      expect(json['senderImage'], testSenderImage);
      expect(json['lastMessage'], testLastMessage);
      expect(json['lastMessageTime'], testLastMessageTime);
      expect(json['isOnline'], testIsOnline);
      expect(json['hasUnreadMessages'], testHasUnreadMessages);
      expect(json['unreadMessagesCount'], testUnreadMessagesCount);
    });
  });

  group('Additional ChatConversation Tests', () {
    // Sample data for testing
    const String testId = 'testId2';
    const String testReceiverName = 'testReceiver2';
    const String testSenderName = 'testSender2';
    const String testReceiverImage = 'receiverImageUrl2';
    const String testSenderImage = 'senderImageUrl2';
    const String testLastMessage = 'Hello again, Test!';
    final Timestamp testLastMessageTime = Timestamp.now();
    const bool testIsOnline = false;
    const bool testHasUnreadMessages = false;
    final List<dynamic> testUsers = ['user3', 'user4'];
    const int testUnreadMessagesCount = 0;
    final DBUser testReceiver = DBUser(uid: 'uid', name: 'name', photoUrl: 'url', email: 'email');

    // Testing default values and null safety
    test('ChatConversation with default values should have appropriate fields', () {
      final chatConversation = ChatConversation(users: testUsers);

      expect(chatConversation.id, isNull);
      expect(chatConversation.receiverName, isNull);
      expect(chatConversation.users, isNotEmpty);
    });

    // Testing with partial data
    test('ChatConversation with partial data should have appropriate fields', () {
      final chatConversation = ChatConversation(
        id: testId,
        users: testUsers,
        receiverName: testReceiverName,
      );

      expect(chatConversation.id, testId);
      expect(chatConversation.receiverName, testReceiverName);
      expect(chatConversation.senderName, isNull);
    });

    // Testing copyWithConversation with null values
    test('copyWithConversation with null parameters should not modify original fields', () {
      final originalChat = ChatConversation(id: testId, users: testUsers);
      final modifiedChat = ChatConversation.copyWithConversation(originalChat, receiverName: null);

      expect(modifiedChat.receiverName, originalChat.receiverName);
      expect(modifiedChat.id, originalChat.id);
    });

    // Testing the integrity of the toJson method
    test('toJson should include all fields', () {
      final chatConversation = ChatConversation(
        id: testId,
        receiverName: testReceiverName, users: [testReceiver.uid],
        senderName: testSenderName,
        receiverImage: testReceiverImage,
        senderImage: testSenderImage,
        lastMessage: testLastMessage,
        lastMessageTime: testLastMessageTime,
        isOnline: testIsOnline,
        hasUnreadMessages: testHasUnreadMessages,
        unreadMessagesCount: testUnreadMessagesCount,
      );

      final json = chatConversation.toJson();

      expect(json.keys, containsAll([
        'id', 'receiverName', 'senderName', 'receiverImage', 'senderImage',
        'lastMessage', 'lastMessageTime', 'isOnline', 'hasUnreadMessages',
        'users', 'unreadMessagesCount'
      ]));
    });

    // Testing with dynamic user list
    test('ChatConversation should handle dynamic user list', () {
      final usersList = List.generate(5, (index) => 'user$index');
      final chatConversation = ChatConversation(users: usersList);

      expect(chatConversation.users.length, 5);
      expect(chatConversation.users.first, 'user0');
    });

    // Testing with large data sets (Stress Test)
    test('ChatConversation should handle large data sets', () {
      final largeUsersList = List.generate(1000, (index) => 'user$index');
      final chatConversation = ChatConversation(users: largeUsersList);

      expect(chatConversation.users.length, 1000);
      expect(chatConversation.users[999], 'user999');
    });
  });
}
