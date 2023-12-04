import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iiitd_mentorship/app/data/model/chat/conversation.dart';
import 'package:iiitd_mentorship/app/data/model/chat/message.dart';
import 'package:iiitd_mentorship/app/data/model/user.dart';
import 'package:iiitd_mentorship/app/views/widgets/conversation_tile.dart';
import 'package:iiitd_mentorship/app/views/widgets/custom_textbox.dart';
import 'package:iiitd_mentorship/app/views/widgets/message_tile.dart';
import 'package:intl/intl.dart';

class ChatPage extends StatefulWidget {
  const ChatPage(
      {super.key, this.chatConversation, this.receiverUser, this.receiverId});

  final ChatConversation? chatConversation;
  final DBUser? receiverUser;
  final String? receiverId;

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _messageController = TextEditingController();

  var isNewChat = false;
  final currentUser = FirebaseAuth.instance.currentUser;
  final db = FirebaseFirestore.instance;
  String currentChatId = "";
  bool reported = false;

  @override
  void initState() {
    super.initState();
    setState(() {
      if (widget.chatConversation == null) {
        isNewChat = true;
      } else {
        currentChatId = widget.chatConversation!.id!;
      }
    });
  }

  void sendMessage() async {
    final Message newMessage = Message(
        senderId: currentUser!.uid,
        senderEmail: currentUser!.email.toString(),
        receiverId: widget.receiverUser == null
            ? widget.receiverId!
            : widget.receiverUser!.uid!,
        timestamp: Timestamp.now(),
        message: _messageController.text);
    _messageController.clear();
    final chatId = isNewChat ? await createChatRoom() : currentChatId;

    // add message to chat room
    await db
        .collection('chat_rooms')
        .doc(chatId)
        .collection("messages")
        .add(newMessage.toJson());
    setState(() {
      isNewChat = false;
      currentChatId = chatId;
    });

    // update chat room
    await db.collection('chat_rooms').doc(chatId).update({
      'lastMessage': newMessage.message,
      'lastMessageTime': newMessage.timestamp,
      'hasUnreadMessages': false,
      'unreadMessagesCount': 0,
    });
  }

  Future<String> createChatRoom() async {
    final chatRoomDB = await db.collection('chat_rooms').add({});

    final chatRoom = ChatConversation.fromJson({
      'id': chatRoomDB.id,
      'senderName': currentUser!.displayName,
      'receiverName': widget.receiverUser!.name,
      'senderImage': widget.receiverUser!.photoUrl,
      'receiverImage': widget.receiverUser!.photoUrl,
      'lastMessage': _messageController.text,
      'lastMessageTime': Timestamp.now(),
      'hasUnreadMessages': false,
      'users': [currentUser!.uid, widget.receiverUser!.uid],
      'unreadMessagesCount': 0,
    });

    // update chat room
    await chatRoomDB.update(chatRoom.toJson());

    return chatRoomDB.id;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: ConversationTile(
            chat: widget.chatConversation != null
                ? ChatConversation.copyWithConversation(
                    widget.chatConversation!,
                  )
                : ChatConversation.copyWithReceiver(
                    widget.receiverUser!,
                  ),
            showDetails: false,
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.flag),
              onPressed: () {
                // show dialog with a list of reason to report the chat
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: const Text('Report Chat'),
                      content: reported == false
                          ? Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                ListTile(
                                  title: const Text('Inappropriate Content'),
                                  onTap: () {
                                    Navigator.pop(context, 'Inappropriate');
                                  },
                                ),
                                ListTile(
                                  title: const Text('Spam'),
                                  onTap: () {
                                    Navigator.pop(context, 'Spam');
                                  },
                                ),
                                // abusive language
                                ListTile(
                                  title: const Text('Abusive Language'),
                                  onTap: () {
                                    Navigator.pop(context, 'Abusive');
                                  },
                                ),
                                ListTile(
                                  title: const Text('Harassment'),
                                  onTap: () {
                                    Navigator.pop(context, 'Harassment');
                                  },
                                ),
                                ListTile(
                                  title: const Text('Other'),
                                  onTap: () {
                                    Navigator.pop(context, 'Other');
                                  },
                                ),
                              ],
                            )
                          : const SizedBox(
                              height: 100,
                              child: Center(
                                child: Column(
                                  children: [
                                    Icon(Icons.check_circle_outline,
                                        color: Colors.green),
                                    Text(
                                        'You have reported this chat.\nWe will look into it.'),
                                  ],
                                ),
                              ),
                            ),
                    );
                  },
                ).then((value) {
                  if (value != null) {
                    // add report to database
                    db.collection('reported_users').add({
                      'reported': currentChatId,
                      'reporter': currentUser!.uid,
                      'reason': value,
                      'date': Timestamp.now(),
                    }).then((value) {
                      setState(() {
                        reported = true;
                      });
                    }).onError((error, stackTrace) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(error.toString()),
                        ),
                      );
                    });
                  }
                });
              },
            ),
          ],
        ),
        body: isNewChat ? _buildNewChat() : _buildChat());
  }

  Widget _buildNewChat() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Spacer(),
        const Icon(Icons.chat_bubble_outline),
        const SizedBox(height: 20),
        const Text('Start a conversation'),
        const Spacer(),
        _buildMessageInput()
      ],
    );
  }

  Widget _buildChat() {
    return Column(
      children: [
        Expanded(
          child: _buildMessageList(currentChatId),
        ),
        _buildMessageInput(),
      ],
    );
  }

  Widget _buildMessageList(String chatId) {
    return StreamBuilder<QuerySnapshot>(
        stream: db
            .collection("chat_rooms")
            .doc(chatId)
            .collection('messages')
            .orderBy('timestamp', descending: false)
            .snapshots(),
        builder: (context, snapshot) {
          Widget child;
          if (snapshot.hasError) {
            child = Center(child: Text(snapshot.error.toString()));
          } else if (snapshot.hasData) {
            final data = snapshot.data!.docs
                .map<Message>(
                    (e) => Message.fromJson(e.data() as Map<String, dynamic>))
                .toList();
            if (data.isEmpty) {
              child = const Center(child: Text("No chats yet"));
            } else {
              child = ListView.builder(
                itemCount: data.length,
                itemBuilder: (context, index) {
                  return _buildMessageItem(data[index]);
                },
              );
            }
          } else {
            child = const Center(child: CircularProgressIndicator());
          }

          return child;
        });
  }

  // build message item
  Widget _buildMessageItem(Message message) {
    var dateTime = message.timestamp.toDate();

    //align message to left for received message and right for sent ones
    var isMe = message.senderId == currentUser!.uid;

    return InkWell(
      onLongPress: () {
        Clipboard.setData(ClipboardData(text: message.message));
      },
      child: MessageTile(
        isMe: isMe,
        message: message.message,
        time: DateFormat('kk:mm').format(dateTime),
      ),
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
                onPressed: () {
                  if (_messageController.text.isNotEmpty) {
                    sendMessage();
                  }
                }),
          ],
        ),
      ),
    );
  }
}
