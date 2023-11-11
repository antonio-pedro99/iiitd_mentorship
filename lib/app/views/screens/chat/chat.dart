import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:iiitd_mentorship/app/views/screens/chat/chat_page.dart';
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
  final FirebaseAuth _auth = FirebaseAuth.instance;

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
    _connections.insert(0, "Connection2");
    _connections.insert(0, "Connection1");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: _userList(),

      // CustomScrollView(
      //     physics: const BouncingScrollPhysics(),
      //     slivers: <Widget>[
      //       SliverPadding(
      //         padding: const EdgeInsets.all(8.0),
      //         sliver: SliverList(
      //           delegate: SliverChildListDelegate([
      //             SizedBox(
      //               height: MediaQuery
      //                   .of(context)
      //                   .size
      //                   .height * 0.7,
      //               child: ListView.builder(
      //                 itemCount: _connections.length,
      //                 itemBuilder: (context, index) {
      //                   return GestureDetector(
      //                     onTap: () =>
      //                     {
      //                       Navigator.pushNamed(context, "/Connection1"),
      //                     },
      //                     child: ConversationTile(
      //                       connectionName: _connections[index],),
      //                   );
      //                 },
      //               ),
      //             ),
      //           ]),
      //         ),
      //       )
      //     ]
      // )
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

  //  building a list of user except current user
  Widget _userList() {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('users').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Text('error');
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Text('loading..');
          }
          return ListView(
            children: snapshot.data!.docs
                .map<Widget>((doc) => _userListItem(doc))
                .toList(),
          );
        });
  }

  // building individual user list item
  Widget _userListItem(DocumentSnapshot document) {
    Map<String, dynamic> data = document.data()! as Map<String, dynamic>;

    // display all users except current user
    if (_auth.currentUser!.email != data['email']) {
      return ListTile(
        title: ConversationTile(
          receiverName: data['name']),
        onTap: () {
          // pass the clicked user's UID to the chat page
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ChatPage(
              receiverUserEmail: data['email'],
              receiverUserID:  data['uid'],
              receiverName: data['name'],
            ))
          );
        },
      );
    }
    else{
      return Container();
    }
  }
}
