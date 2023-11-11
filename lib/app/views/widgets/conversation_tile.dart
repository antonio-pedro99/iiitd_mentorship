import 'package:flutter/material.dart';
import 'package:iiitd_mentorship/app/views/widgets/rounded_photo.dart';

class ConversationTile extends StatelessWidget {
  const ConversationTile({super.key, this.showDetails = true, this.receiverName = "My Friend"});

  final bool? showDetails;
  final String? receiverName;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      child: Row(
        children: [
          const RoundedPhoto(),
          const SizedBox(
            width: 10,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: (showDetails == true) ?
            [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(receiverName!,
                      style: const TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(
                    width: 5,
                  ),
                  const Text("Oct 30",
                      style: TextStyle(
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
                    child: const Text(
                      "Last message This message its too long and you wont read it all",
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      ),
                    )),
            ]:[
              Text(receiverName!,
                  style: const TextStyle(fontWeight: FontWeight.bold)),
            ],
          )
        ],
      ),
    );
  }
}
