import 'package:flutter/material.dart';

class SimpleTextField extends StatelessWidget {
  final String hintText;
  final String labelText;
  final FloatingLabelBehavior floatingLabelBehavior;
  final Color textColor;
  final Color accentColor;
  final TextEditingController controller;
  final bool obscureText; // Eklendi

  const SimpleTextField({
    Key? key,
    required this.hintText,
    required this.labelText,
    this.floatingLabelBehavior = FloatingLabelBehavior.auto,
    this.textColor = Colors.black,
    this.accentColor = Colors.purple,
    required this.controller,
    this.obscureText = false, // Eklendi
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: obscureText, // Eklendi
      decoration: InputDecoration(
        hintText: hintText,
        labelText: labelText,
        floatingLabelBehavior: floatingLabelBehavior,
        labelStyle: TextStyle(
          color: accentColor,
        ),
        hintStyle: TextStyle(
          color: Colors.grey,
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: accentColor),
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.grey),
        ),
      ),
      style: TextStyle(
        color: textColor,
      ),
    );
  }
}
