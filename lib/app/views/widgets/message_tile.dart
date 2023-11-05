import 'package:flutter/material.dart';

class MessageTile extends StatelessWidget {
  const MessageTile(
      {super.key,
      this.isMe,
      this.message,
      this.time,
      this.isRead,
      this.containsImage = false});

  final bool? isMe;
  final String? message;
  final String? time;
  final bool? isRead;
  final bool? containsImage;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          alignment:
              isMe == true ? Alignment.centerRight : Alignment.centerLeft,
          child: Container(
            constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width * 0.7,
            ),
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
                color: isMe == true
                    ? Theme.of(context).primaryColor
                    : Colors.grey[200],
                borderRadius: BorderRadius.only(
                  topLeft:
                      isMe == true ? const Radius.circular(10) : Radius.zero,
                  topRight:
                      isMe == true ? Radius.zero : const Radius.circular(10),
                  bottomLeft: const Radius.circular(10),
                  bottomRight: const Radius.circular(10),
                )),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (containsImage == true)
                  Image.network(
                    message!,
                    fit: BoxFit.cover,
                  ),
                if (containsImage == false)
                  Text(
                    message!,
                    style: TextStyle(
                      color: isMe == true ? Colors.white : Colors.black,
                    ),
                  ),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  children: [
                    Text(
                      time!,
                      style: TextStyle(
                        color: isMe == true ? Colors.white : Colors.black,
                        fontSize: 11,
                        fontWeight: FontWeight.w100,
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    isRead == true
                        ? Icon(
                            Icons.done_all,
                            size: 15,
                            color: isMe == true
                                ? Colors.white
                                : Theme.of(context).primaryColor,
                          )
                        : const SizedBox.shrink(),
                  ],
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
