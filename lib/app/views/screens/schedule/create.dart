import 'package:flutter/material.dart';

class CreateScheduleScreen extends StatefulWidget {
  const CreateScheduleScreen({super.key, required this.title});

  final String title;

  @override
  State<CreateScheduleScreen> createState() => _CreateScheduleScreenState();
}

class _CreateScheduleScreenState extends State<CreateScheduleScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: const Center());
  }
}
