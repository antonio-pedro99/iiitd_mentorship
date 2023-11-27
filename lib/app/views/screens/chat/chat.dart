import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:iiitd_mentorship/app/data/model/chat/conversation.dart';
import 'package:iiitd_mentorship/app/data/model/user.dart';
import 'package:iiitd_mentorship/app/views/screens/chat/chat_page.dart';
import 'package:iiitd_mentorship/app/views/screens/search/search.dart';
import 'package:iiitd_mentorship/app/views/widgets/conversation_tile.dart';
import 'package:iiitd_mentorship/app/views/widgets/custom_button.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key, required this.title});

  final String title;

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final currentUser = FirebaseAuth.instance.currentUser;
  late DBUser receiverUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const SearchScreen(
                        forMessage: true,
                      ),
                    ),
                  );
                },
                icon: const Icon(Icons.search)),
          ],
        ),
        body: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('chat_rooms')
                .where("users", arrayContains: currentUser!.uid)
                .orderBy("lastMessageTime", descending: true)
                .snapshots(),
            builder: (context, snapshot) {
              Widget child;

              switch (snapshot.connectionState) {
                case ConnectionState.waiting:
                  child = const Center(child: CircularProgressIndicator());
                  break;
                default:
                  if (snapshot.hasError) {
                    child = Center(child: Text(snapshot.error.toString()));
                  } else {
                    final data = snapshot.data!.docs;
                    if (data.isEmpty) {
                      child = Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Center(child: Text("No chats yet")),
                            const SizedBox(height: 20),
                            CustomButton(
                              rounded: true,
                              onPressed: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => const SearchScreen(
                                      forMessage: true,
                                    ),
                                  ),
                                );
                              },
                              width: 200,
                              child: const Text('Find someone to chat with'),
                            )
                          ],
                        ),
                      );
                    } else {
                      child = ListView.builder(
                        itemCount: data.length,
                        itemBuilder: (context, index) {
                          final chatRoom = ChatConversation.fromJson(
                              data[index].data() as Map<String, dynamic>);
                          return InkResponse(
                            child: ConversationTile(
                              chat: chatRoom,
                              
                            ),
                            onTap: () {
                              final otherUser = chatRoom.users.firstWhere(
                                  (element) => element != currentUser!.uid);

                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => ChatPage(
                                    chatConversation: chatRoom,
                                    receiverId: otherUser,
                                  ),
                                ),
                              );
                            },
                          );
                        },
                      );
                    }
                  }
              }

              return child;
            }));
  }
}
