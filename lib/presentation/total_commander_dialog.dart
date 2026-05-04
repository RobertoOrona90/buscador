import 'package:flutter/material.dart';

class TotalCommanderDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 720,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFC0C0C0),
        border: Border.all(color: Colors.black),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Header
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title + Subtitle
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'Buscador Pro Max alfa versión',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Arial',
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Copyright © 1993-2026 by Roberto Orona - All Rights Reserved',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 18),

          // Description
          const Text(
              'Este programa es Shareware, es decir, puede probar esta versión demo\n'
  'completamente funcional durante un mes. Después de este período de prueba,\n'
  'deberá registrarlo o eliminar el programa de su disco duro. También puede\n'
  'redistribuir libremente este programa. Presione "Información de registro"\n'
  'para obtener más información.\n\n'
  'Este cuadro de diálogo no aparecerá en la versión registrada.',
            style: TextStyle(
              fontSize: 16,
              color: Colors.black,
              height: 1.3,
            ),
          ),

          const SizedBox(height: 20),

          // Buttons
          Row(
            children: [
              Expanded(
                child: _win95Button(
                  text: 'Program information',
                  onPressed: () {},
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _win95Button(
                  text: 'Registration info',
                  onPressed: () {},
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _win95Button({
    required String text,
    required VoidCallback onPressed,
  }) {
    return SizedBox(
      height: 42,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFFC0C0C0),
          foregroundColor: Colors.black,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.zero,
            side: const BorderSide(color: Colors.black),
          ),
        ),
        onPressed: onPressed,
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
