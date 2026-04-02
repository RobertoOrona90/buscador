import 'package:flutter/material.dart';

class LabelInputMultiline extends StatelessWidget {
  const LabelInputMultiline({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text(
      'Seleccione la carpeta y agregue los archivos que desee buscar',
      style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500),
      textAlign: TextAlign.center,
    );
  }
}