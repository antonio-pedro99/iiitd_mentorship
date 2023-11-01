import 'package:flutter/material.dart';

class RoundedPhoto extends StatelessWidget {
  const RoundedPhoto({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50,
      height: 50,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        border: Border.fromBorderSide(
          BorderSide(
            color: Colors.pink,
            width: 2,
          ),
        ),
        image: DecorationImage(
          image: NetworkImage(
              "https://images.unsplash.com/photo-1531384441138-2736e62e0919?auto=format&fit=crop&q=80&w=1587&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
