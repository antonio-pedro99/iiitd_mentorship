import 'package:flutter/material.dart';

class CircleButton extends StatelessWidget {
  const CircleButton({super.key, this.icon});

  final IconData? icon;
  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 25,
      backgroundColor: Theme.of(context).colorScheme.primary,
      child: IconButton(
        onPressed: () {},
        icon: Icon(
          icon,
          color: Colors.white,
        ),
      ),
    );
  }
}
