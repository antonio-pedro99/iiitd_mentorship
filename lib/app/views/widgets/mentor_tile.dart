import 'package:flutter/material.dart';

class MentorTile extends StatelessWidget {
  final String name;
  final String bio;
  final int stars;
  final String photoUrl;

  const MentorTile(
      {super.key,
      required this.name,
      required this.bio,
      required this.stars,
      required this.photoUrl});

  @override
  Widget build(BuildContext context) {
    return Card(
      borderOnForeground: false,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: <Widget>[
            CircleAvatar(
              backgroundImage: NetworkImage(photoUrl),
              radius: 30.0,
            ),
            const SizedBox(width: 10.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    name,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(bio),
                  Row(
                    children: <Widget>[
                      const Icon(Icons.star, color: Colors.yellow),
                      Text(stars.toString()),
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
