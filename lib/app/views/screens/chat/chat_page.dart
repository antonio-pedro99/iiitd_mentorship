import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:iiitd_mentorship/app/data/services/chat_service.dart';
import 'package:iiitd_mentorship/app/views/widgets/conversation_tile.dart';
import 'package:iiitd_mentorship/app/views/widgets/custom_textbox.dart';
import 'package:iiitd_mentorship/app/views/widgets/message_tile.dart';
import 'package:intl/intl.dart';

class ChatPage extends StatefulWidget {
  const ChatPage(
      {super.key,
      required this.receiverUserEmail,
      required this.receiverUserID,
      required this.receiverName});

  final String receiverUserEmail;
  final String receiverUserID;
  final String receiverName;

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _messageController = TextEditingController();
  final ChatService _chatService = ChatService();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  void sendMessage() async {
    // send only if there is a message
    if (_messageController.text.isNotEmpty) {
      await _chatService.sendMessage(
          widget.receiverUserID, _messageController.text);

      // clear controller after sending the message
      _messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: ConversationTile(
            receiverName: widget.receiverName,
            showDetails: false,
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.flag),
              onPressed: () {},
            ),
          ],
        ),
        body: Column(
          children: [
            Expanded(
              child: _buildMessageList(),
            ),
            _buildMessageInput(),
          ],
        ));
  }

  // build message list
  Widget _buildMessageList() {
    return StreamBuilder(
        stream: _chatService.getMessage(
            widget.receiverUserID, _firebaseAuth.currentUser!.uid),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Error${snapshot.error}'));
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: Text('Loading..'));
          }
          return snapshot.data != null || snapshot.data!.docs.isNotEmpty
              ? ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  reverse: true,
                  itemBuilder: (context, index) {
                    return _buildMessageItem(snapshot.data!.docs[index]);
                  },
                )
              : const Center(
                  child: Text('No messages yet! Send a message to start chat'));
        });
  }

  // build message item
  Widget _buildMessageItem(DocumentSnapshot document) {
    Map<String, dynamic> data = document.data() as Map<String, dynamic>;

    //align message to left for received message and right for sent ones
    var isMe = (data['senderId'] == _firebaseAuth.currentUser!.uid);
    var dateTime = data['timestamp'].toDate();

    return MessageTile(
      isMe: isMe,
      message: data['message'],
      time: DateFormat('kk:mm').format(dateTime),
    );
  }

  // build message input
  Widget _buildMessageInput() {
    return IconTheme(
      data: IconThemeData(color: Theme.of(context).primaryColor),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            // textField
            Expanded(
              child: CustomTextBox(
                validationMessage: "Please enter some text",
                controller: _messageController,
                hintText: 'Type a message',
                obscureText: false,
              ),
            ),

            // send Icon button
            IconButton(
              icon: const Icon(Icons.send),
              onPressed: sendMessage,
            ),
          ],
        ),
      ),
    );
  }
}
