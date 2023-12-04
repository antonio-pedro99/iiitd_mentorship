import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:iiitd_mentorship/app/data/model/user.dart';

class ChatConversation {
  final String? id;
  final String? receiverName;
  final String? receiverImage;
  final String? senderName;
  final String? senderImage;
  final String? lastMessage;
  final Timestamp? lastMessageTime;
  final bool? isOnline;
  final bool? hasUnreadMessages;
  final List<dynamic> users;
  final int? unreadMessagesCount;

  ChatConversation({
    this.id,
    this.receiverName,
    this.senderName,
    this.receiverImage,
    this.senderImage,
    this.lastMessage,
    this.lastMessageTime,
    this.isOnline,
    this.hasUnreadMessages,
    required this.users,
    this.unreadMessagesCount,
  });

  factory ChatConversation.fromJson(Map<String, dynamic> json) {
    return ChatConversation(
      id: json['id'],
      receiverName: json['receiverName'],
      receiverImage: json['receiverImage'],
      senderName: json['senderName'],
      senderImage: json['senderImage'],
      lastMessage: json['lastMessage'],
      lastMessageTime: json['lastMessageTime'],
      isOnline: json['isOnline'],
      hasUnreadMessages: json['hasUnreadMessages'],
      users: json['users'],
      unreadMessagesCount: json['unreadMessagesCount'],
    );
  }

  factory ChatConversation.copyWithConversation(
      ChatConversation chatConversation,
      {String? id,
      String? receiverName,
      String? receiverImage,
      String? senderName,
      String? senderImage,
      String? lastMessage,
      Timestamp? lastMessageTime,
      bool? isOnline,
      bool? hasUnreadMessages,
      List<dynamic>? users,
      int? unreadMessagesCount}) {
    return ChatConversation(
      id: id ?? chatConversation.id,
      receiverName: receiverName ?? chatConversation.receiverName,
      receiverImage: receiverImage ?? chatConversation.receiverImage,
      senderName: senderName ?? chatConversation.senderName,
      senderImage: senderImage ?? chatConversation.senderImage,
      lastMessage: lastMessage ?? chatConversation.lastMessage,
      lastMessageTime: lastMessageTime ?? chatConversation.lastMessageTime,
      isOnline: isOnline ?? chatConversation.isOnline,
      hasUnreadMessages:
          hasUnreadMessages ?? chatConversation.hasUnreadMessages,
      users: users ?? chatConversation.users,
      unreadMessagesCount:
          unreadMessagesCount ?? chatConversation.unreadMessagesCount,
    );
  }

  factory ChatConversation.copyWithReceiver(DBUser receiver) {
    return ChatConversation(
      receiverName: receiver.name,
      receiverImage: receiver.photoUrl,
      users: [receiver.uid],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'receiverName': receiverName,
      'receiverImage': receiverImage,
      'senderName': senderName,
      'senderImage': senderImage,
      'lastMessage': lastMessage,
      'lastMessageTime': lastMessageTime,
      'isOnline': isOnline,
      'hasUnreadMessages': hasUnreadMessages,
      'users': users,
      'unreadMessagesCount': unreadMessagesCount,
    };
  }
}
