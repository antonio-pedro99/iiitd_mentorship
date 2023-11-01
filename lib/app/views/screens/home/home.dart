import 'package:flutter/material.dart';

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
                onPressed: () => Navigator.pushNamed(context, "/home/schedule"),
                icon: const Icon(Icons.event)),
          ],
        ),
        body: const Column(
          children: [],
        ));
  }
}
