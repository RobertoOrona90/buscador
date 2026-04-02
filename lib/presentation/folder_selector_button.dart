import 'package:flutter/material.dart';

class FolderSelectorButton extends StatelessWidget {
  final bool isLoading;
  final VoidCallback onSelect;

  const FolderSelectorButton({
    super.key,
    required this.isLoading,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity, // Para que ocupe el ancho disponible
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.black,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 14.0),
          // Deshabilitar visualmente si está cargando
          disabledBackgroundColor: Colors.grey[800],
        ),
        onPressed: isLoading ? null : onSelect,
        child: isLoading
            ? const SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(
                  color: Colors.white,
                  strokeWidth: 2,
                ),
              )
            : const Text('Seleccionar carpeta origen'),
      ),
    );
  }
}
