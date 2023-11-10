import 'package:flutter/material.dart';

class CustomDropdown extends StatelessWidget {
  final String labelText;
  final String? value;
  final List<DropdownMenuItem<String>> items;
  final Function(String?) onChanged;
  final String? Function(String?)? validator;

  const CustomDropdown({
    Key? key,
    required this.labelText,
    required this.value,
    required this.items,
    required this.onChanged,
    this.validator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(
        labelText: labelText,
        contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 15), // Customize padding here
        border: OutlineInputBorder(),
      ),
      value: value,
      items: items,
      onChanged: onChanged,
      validator: validator,
    );
  }
}
