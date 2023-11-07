import 'package:flutter/material.dart';
import 'package:iiitd_mentorship/app/data/model/mentor.dart';

class MentorResultTile extends StatelessWidget {
  const MentorResultTile({super.key, required this.mentor});

  final Mentor mentor;

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
                  image: NetworkImage(mentor.photoUrl),
                ),
              ),
            ),
            const SizedBox(width: 10.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    mentor.name,
                    style: const TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(mentor.bio,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      style: const TextStyle(
                        fontSize: 11.0,
                        color: Colors.grey,
                      )),
                  Row(
                    children: [
                      Row(
                        children: <Widget>[
                          const Icon(Icons.star, color: Colors.yellow),
                          Text(mentor.stars.toString()),
                        ],
                      ),
                      const SizedBox(width: 10),
                      const Row(
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
                      const Spacer(),
                      IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.favorite_border,
                            size: 18,
                          ))
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
