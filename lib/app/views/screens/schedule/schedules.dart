import 'package:flutter/material.dart';

class MySchedulesScreen extends StatefulWidget {
  const MySchedulesScreen({super.key, required this.title});

  final String title;

  @override
  State<MySchedulesScreen> createState() => _MySchedulesScreenState();
}

class _MySchedulesScreenState extends State<MySchedulesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: const Center());
  }
}
