import 'package:flutter/material.dart';
import 'package:iiitd_mentorship/app/data/model/user.dart';

class MentorResultTile extends StatelessWidget {
  const MentorResultTile({super.key, required this.mentor});

  final DBUser mentor;

  @override
  Widget build(BuildContext context) {
    return Card(
      borderOnForeground: false,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              height: 80.0,
              width: 70.0,
              decoration: ShapeDecoration(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage((mentor.photoUrl == null ||
                          mentor.photoUrl!.isEmpty)
                      ? "https://images.unsplash.com/photo-1531384441138-2736e62e0919?auto=format&fit=crop&q=80&w=1587&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"
                      : mentor.photoUrl!),
                ),
              ),
            ),
            const SizedBox(width: 10.0),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  mentor.name!,
                  style: const TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 5),
                Text(mentor.company ?? "No Company",
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    style: const TextStyle(
                      fontSize: 11.0,
                      color: Colors.grey,
                    )),
                const Align(
                  alignment: Alignment.bottomRight,
                  child: Row(
                    children: [
                      Text("Available for"),
                      Icon(
                        Icons.video_call,
                        color: Colors.green,
                        size: 18,
                      ),
                      Icon(
                        Icons.chat,
                        color: Colors.green,
                        size: 18,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
