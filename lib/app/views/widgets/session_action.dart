import 'package:flutter/material.dart';

class SessionActionButton extends StatelessWidget {
  const SessionActionButton({super.key, required this.action, this.onPressed});

  final String action;
  final VoidCallback? onPressed;
  @override
  Widget build(BuildContext context) {
    return InkResponse(
      onTap: onPressed,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(action,
                  style: const TextStyle(
                      fontSize: 14, fontWeight: FontWeight.w700)),
              const Icon(
                Icons.arrow_forward_ios,
                color: Colors.grey,
                size: 18,
              )
            ],
          ),
        ),
      ),
    );
  }
}
