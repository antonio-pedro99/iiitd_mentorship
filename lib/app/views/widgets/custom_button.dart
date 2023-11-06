import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton(
      {super.key,
      required this.onPressed,
      required this.child,
      this.color,
      this.height,
      this.width,
      this.rounded});

  final VoidCallback onPressed;
  final Widget child;
  final Color? color;
  final double? width;
  final double? height;
  final bool? rounded;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
        minWidth: width ?? MediaQuery.of(context).size.width,
        height: height ?? 56,
        color: color ?? Theme.of(context).primaryColor,
        textColor: color == Colors.white ? Colors.black : Colors.white,
        padding: const EdgeInsets.all(16),
        shape: rounded == true
            ? RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18),
              )
            : null,
        onPressed: onPressed,
        child: child);
  }
}
