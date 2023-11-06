import 'package:flutter/material.dart';

class CustomTextBox extends StatelessWidget {
  const CustomTextBox(
      {super.key,
      this.controller,
      this.hintText,
      this.suffixIcon,
      this.prefixIcon,
      this.obscureText,
      this.borderColor,
      this.backgroundColor,
      required this.validationMessage,
      this.textColor,
      this.onSubmitted});

  final TextEditingController? controller;
  final String? hintText;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final bool? obscureText;
  final Color? borderColor;
  final Color? textColor;
  final Color? backgroundColor;
  final String validationMessage;
  final Function(String)? onSubmitted;

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      child: TextFormField(
        controller: controller,
        obscureText: obscureText ?? false,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return validationMessage ?? "Please enter some text";
          }
          return null;
        },
        style: TextStyle(
          color: textColor ?? Colors.black,
        ),
        decoration: InputDecoration(
          hintText: hintText ?? "Enter text",
          contentPadding: const EdgeInsets.all(16),
          hintStyle: TextStyle(
            color: Colors.grey[400],
            fontWeight: FontWeight.w200,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(18),
            borderSide: BorderSide.none,
          ),
          filled: true,
          fillColor: backgroundColor ?? Colors.grey[200],
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon,
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(18),
            borderSide: BorderSide(
              color: Theme.of(context).primaryColor,
            ),
          ),
        ),
      ),
    );
  }
}
