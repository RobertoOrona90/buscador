import 'package:flutter/material.dart';

class FileInputField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final int maxLines;

  const FileInputField({
    super.key,
    required this.controller,
    this.hintText = 'Ingrese los archivos...',
    this.maxLines = 5,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      maxLines: maxLines,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        hintText: hintText,
        contentPadding: const EdgeInsets.all(12.0),
      ),
    );
  }
}
