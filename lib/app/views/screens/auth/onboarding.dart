import 'package:flutter/material.dart';

class OnBoardsScreen extends StatefulWidget {
  const OnBoardsScreen({super.key, required this.title});

  final String title;

  @override
  State<OnBoardsScreen> createState() => _OnBoardsScreenState();
}

class _OnBoardsScreenState extends State<OnBoardsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text(widget.title),
        ),
        body: const Center());
  }
}
