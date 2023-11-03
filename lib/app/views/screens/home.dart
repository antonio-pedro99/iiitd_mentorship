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
          title: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Welcome"),
              SizedBox(
                height: 5,
              ),
              Text(
                "Find IIITD Mentors around the world",
                style: TextStyle(fontSize: 12),
              )
            ],
          ),
          toolbarHeight: kToolbarHeight + 10,
          actions: [
            IconButton(
                onPressed: () => Navigator.pushNamed(context, "/profile"),
                icon: const Icon(Icons.person)),
          ],
        ),
        body: const Column(
          children: [],
        ));
  }
}
