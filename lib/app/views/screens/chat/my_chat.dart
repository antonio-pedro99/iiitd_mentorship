import 'package:flutter/material.dart';
import 'package:iiitd_mentorship/app/views/widgets/conversation_tile.dart';
import 'package:iiitd_mentorship/app/views/widgets/custom_textbox.dart';
import 'package:iiitd_mentorship/app/views/widgets/message_tile.dart';
import 'package:iiitd_mentorship/app/views/widgets/rounded_photo.dart';

class MyChats extends StatefulWidget {
  const MyChats({super.key, required this.title});

  final String title;

  @override
  State<MyChats> createState() => _MyChatsState();
}

class _MyChatsState extends State<MyChats> {
  final TextEditingController _textController = TextEditingController();
  final List<String> _messages = [];

  void _handleSubmittedMessage(String text) {
    setState(() {
      _messages.insert(0, text); // Add the message to the list
      _textController.clear(); // Clear the text input field
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const ConversationTile(showDetails: false,), //Text(widget.title),
      ),
      body: Column(
        children: <Widget>[
          Flexible(
            child: ListView.builder(
              reverse: true, // Start from the bottom of the list
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                return ((_messages.length - index) % 2 == 1)
                    ? MessageTile(
                  isMe: true,
                  message: _messages[index],
                  time: "12:00",
                  isRead: true,
                )
                    : MessageTile(
                  isMe: false,
                  message: _messages[index],
                  time: "12:00",
                );
              },
            ),
          ),
          Divider(height: 1.0),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 3.0),
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
            ),
            child: _buildTextComposer(),
          ),
        ],
      ),
    );
  }

  Widget _buildTextComposer() {
    return IconTheme(
      data: IconThemeData(color: Colors.blue),
      child: Row(
        children: <Widget>[
          Flexible(
            child: CustomTextBox(
              controller: _textController,
              hintText: 'Type a message',
            ),
          ),
          IconButton(
            icon: Icon(Icons.send),
            onPressed: () => _handleSubmittedMessage(_textController.text),
          ),
        ],
      ),
    );
  }
}
