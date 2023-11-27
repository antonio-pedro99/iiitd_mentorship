import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:iiitd_mentorship/app/data/model/chat/conversation.dart';
import 'package:iiitd_mentorship/app/views/widgets/rounded_photo.dart';
import 'package:intl/intl.dart';

class ConversationTile extends StatelessWidget {
  const ConversationTile(
      {super.key, this.showDetails = true, required this.chat});

  final bool? showDetails;

  final ChatConversation chat;

  bool imSender(uid) => chat.users.first == uid;

  @override
  Widget build(BuildContext context) {
    final currentUser = FirebaseAuth.instance.currentUser;
    var lastMessageTimeDateTime = chat.lastMessageTime != null
        ? (chat.lastMessageTime as Timestamp).toDate()
        : DateTime.now();
    var now = DateTime.now();
    var difference = now.difference(lastMessageTimeDateTime);

    return Container(
      padding: const EdgeInsets.all(8),
      child: Row(
        children: [
          RoundedPhoto(
            url: imSender(currentUser!.uid)
                ? chat.receiverImage
                : chat.senderImage,
          ),
          const SizedBox(
            width: 10,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: (showDetails == true)
                ? [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                            imSender(currentUser.uid)
                                ? chat.receiverName!
                                : chat.senderName!,
                            style:
                                const TextStyle(fontWeight: FontWeight.bold)),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                            difference.inDays > 0
                                ? DateFormat('dd/MM/yyyy')
                                    .format(lastMessageTimeDateTime)
                                : DateFormat('hh:mm a')
                                    .format(lastMessageTimeDateTime),
                            style: const TextStyle(
                                color: Colors.grey,
                                fontSize: 11,
                                fontWeight: FontWeight.w100)),
                      ],
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    SizedBox(
                        width: MediaQuery.of(context).size.width * 0.7,
                        child: Text(
                          chat.lastMessage!,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                          ),
                        )),
                  ]
                : [
                    Text(
                        imSender(currentUser.uid)
                            ? chat.receiverName!
                            : chat.senderName!,
                        style: const TextStyle(fontWeight: FontWeight.bold)),
                  ],
          )
        ],
      ),
    );
  }
}
