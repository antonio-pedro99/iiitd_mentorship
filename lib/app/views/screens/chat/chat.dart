import 'package:flutter/material.dart';
import 'package:iiitd_mentorship/app/views/screens/chat/my_chat.dart';
import 'package:iiitd_mentorship/app/views/widgets/conversation_tile.dart';
import 'package:iiitd_mentorship/app/views/widgets/custom_textbox.dart';
import 'package:iiitd_mentorship/app/views/widgets/message_tile.dart';
import 'package:iiitd_mentorship/app/views/widgets/rounded_photo.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key, required this.title});

  final String title;

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _textController = TextEditingController();
  final List<String> _connections = [];

  // void _handleSubmittedMessage(String text) {
  //   setState(() {
  //     _connections.insert(0, text); // Add the message to the list
  //     _textController.clear(); // Clear the text input field
  //   });
  // }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _connections.insert(0,"Connection2");
    _connections.insert(0,"Connection1");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme
            .of(context)
            .colorScheme
            .inversePrimary,
        title: Text(widget.title),
      ),
      body: Column(
        children: <Widget>[
          Flexible(
            child: ListView.builder(
              reverse: false, // Start from the bottom of the list
              itemCount: _connections.length,
              itemBuilder: (context, index) {
                return IconButton(
                    onPressed: () =>
                        Navigator.pushNamed(context, "/chat/mychat"),
                    icon: ConversationTile(
                      connectionName: _connections[index],));
              },
            ),
          ),
        ],
      ),
    );

    // return MaterialApp(
    //     routes: <String, WidgetBuilder>{
    //       '/Connection1': (BuildContext context) => const MyChats(title: "Connection1"),
    //       '/Connection2': (BuildContext context) => const MyChats(title: "Connection2"),
    //     },
    //     home: Scaffold(
    //       appBar: AppBar(
    //         backgroundColor: Theme
    //             .of(context)
    //             .colorScheme
    //             .inversePrimary,
    //         title: Text(widget.title),
    //       ),
    //       body: Column(
    //         children: <Widget>[
    //           Flexible(
    //             child: ListView.builder(
    //               reverse: false, // Start from the bottom of the list
    //               itemCount: _connections.length,
    //               itemBuilder: (context, index) {
    //                 return IconButton(
    //                     onPressed: () =>
    //                         Navigator.pushNamed(context, "/Connection1"),
    //                     icon: ConversationTile(
    //                       connectionName: _connections[index],));
    //               },
    //             ),
    //           ),
    //         ],
    //       ),
    //     )
    // );
  }
}
