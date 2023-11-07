import 'package:flutter/material.dart';

class TopicTile extends StatelessWidget {
  const TopicTile({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          Image.asset("assets/business.jpg"),
          const Padding(
              padding: EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Business",
                    style: TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                      "Business is the activity of making one's living or making money by producing or buying and selling products (such as goods and services).",
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      style: TextStyle(
                        fontSize: 11.0,
                        color: Colors.grey,
                      )),
                ],
              )),
        ],
      ),
    );
  }
}
