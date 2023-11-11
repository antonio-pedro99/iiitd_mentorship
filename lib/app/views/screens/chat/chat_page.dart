import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:iiitd_mentorship/app/views/screens/chat/chat_service.dart';
import 'package:iiitd_mentorship/app/views/widgets/conversation_tile.dart';
import 'package:iiitd_mentorship/app/views/widgets/custom_textbox.dart';
import 'package:iiitd_mentorship/app/views/widgets/message_tile.dart';
import 'package:iiitd_mentorship/app/views/widgets/rounded_photo.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';


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
            return Text('Error${snapshot.error}');
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Text('Loading..');
          }
          return ListView(
            children: snapshot.data!.docs
                .map((document) => _buildMessageItem(document))
                .toList(),
          );
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

    //   Container(
    //   alignment: alignment,
    //   child: Column(
    //     children: [
    //       Text(data['senderEmail']),
    //       Text(data['message']),
    //     ],
    //   ),
    // );
  }

  // build message input
  Widget _buildMessageInput() {
    return IconTheme(
      data: IconThemeData(color: Theme.of(context).primaryColor),
      child: Row(
        children: [
          // textField
          Expanded(
            child:CustomTextBox(
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
          Container(
            width: 10,
          )
        ],
      ),
    );
  }

// final List<String> _messages = [];

// void _handleSubmittedMessage(String text) {
//   setState(() {
//     _messages.insert(0, text); // Add the message to the list
//     _messageController.clear(); // Clear the text input field
//   });
// }

// @override
// Widget build(BuildContext context) {
//   return Scaffold(
//     appBar: AppBar(
//       // backgroundColor: Theme.of(context).colorScheme.inversePrimary,
//       title: const ConversationTile(
//         showDetails: false,
//       ), //Text(widget.title),
//     ),
//     body: Column(
//       children: <Widget>[
//         Flexible(
//           child: ListView.builder(
//             reverse: true, // Start from the bottom of the list
//             itemCount: _messages.length,
//             itemBuilder: (context, index) {
//               return ((_messages.length - index) % 2 == 1)
//                   ? MessageTile(
//                       isMe: true,
//                       message: _messages[index],
//                       time: "12:00",
//                       isRead: true,
//                     )
//                   : MessageTile(
//                       isMe: false,
//                       message: _messages[index],
//                       time: "12:00",
//                     );
//             },
//           ),
//         ),
//         Divider(height: 1.0),
//         Container(
//           margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 3.0),
//           decoration: BoxDecoration(
//             color: Theme.of(context).cardColor,
//           ),
//           child: _buildTextComposer(),
//         ),
//       ],
//     ),
//   );
// }
//
//   Widget _buildTextComposer() {
//     return IconTheme(
//       data: IconThemeData(color: Theme.of(context).primaryColor),
//       child: Row(
//         children: <Widget>[
//           Flexible(
//             child: CustomTextBox(
//               validationMessage: "Please enter some text",
//               controller: _messageController,
//               hintText: 'Type a message',
//             ),
//           ),
//           IconButton(
//             icon: Icon(Icons.send),
//             onPressed: () => sendMessage(),
//           ),
//         ],
//       ),
//     );
//   }
}
