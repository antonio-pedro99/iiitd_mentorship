import 'package:flutter/material.dart';
import 'package:iiitd_mentorship/app/views/widgets/circle_button.dart';
import 'package:iiitd_mentorship/app/views/widgets/custom_textbox.dart';
import 'package:iiitd_mentorship/app/views/widgets/message_tile.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text(widget.title),
        ),
        body: const Column(
          children: [
              MessageTile(
              isMe: true,
              message: "This message is too long, I did not read it at all",
              time: "10:00",
              isRead: true,
              containsImage: false,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleButton(icon: Icons.add),
                  Expanded(
                  child: CustomTextBox(
                    hintText: "Type here",
                    suffixIcon: Icon(Icons.mic),
                  ),
                ),
              ],
            ),
          ],
        ));
  }
}
