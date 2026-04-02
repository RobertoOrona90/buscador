import 'package:flutter/material.dart';

class FileManagerBtnAccept extends StatelessWidget {
  final VoidCallback onPress;

  const FileManagerBtnAccept({super.key, required this.onPress});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(vertical: 14.0),
      ),
      onPressed: onPress,
      child: const Text('Aceptar'),
    );
  }
}
