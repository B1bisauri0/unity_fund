import 'package:flutter/material.dart';

class RoundedTextField extends StatelessWidget {
  final bool enabled;
  final String hintText;
  final TextEditingController? controller;

  const RoundedTextField({
    Key? key,
    required this.enabled,
    required this.hintText,
    this.controller,
    required VoidCallback onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(color: Colors.grey),
      ),
      child: TextField(
        controller: controller,
        enabled: enabled,
        decoration: InputDecoration(
          hintText: hintText,
          border: InputBorder.none,
          contentPadding:
              EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
        ),
      ),
    );
  }
}
