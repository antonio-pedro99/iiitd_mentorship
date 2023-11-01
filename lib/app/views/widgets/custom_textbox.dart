import 'package:flutter/material.dart';

class CustomTextBox extends StatelessWidget {
  const CustomTextBox(
      {super.key,
      this.controller,
      this.hintText,
      this.suffixIcon,
      this.prefixIcon});

  final TextEditingController? controller;
  final String? hintText;
  final Widget? suffixIcon;
  final Widget? prefixIcon;

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      widthFactor: 0.8,
      child: TextField(
        decoration: InputDecoration(
          hintText: hintText ?? "Enter text",
          contentPadding: const EdgeInsets.all(16),
          hintStyle: TextStyle(
            color: Colors.grey[400],
            fontWeight: FontWeight.w200,
          ),
          border: UnderlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide.none,
          ),
          filled: true,
          fillColor: Colors.grey[200],
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon,
        ),
      ),
    );
  }
}
