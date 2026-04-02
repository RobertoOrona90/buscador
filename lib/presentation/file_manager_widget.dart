import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class FileManagerWidget extends StatefulWidget {
  const FileManagerWidget({super.key});

  @override
  State<FileManagerWidget> createState() => _FileManagerWidgetState();
}

class _FileManagerWidgetState extends State<FileManagerWidget> {
  String? _selectedSourceFolderPath;
  String? _selectedDestinationFolderPath;
  bool _isLoading = false;
  bool _copyFolderStructure = false;
  final TextEditingController _textController = TextEditingController();

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  void _showMessage(String message) {
    if (!mounted) return;
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text('OK'),
          )
        ],
      ),
    );
  }

  Future<void> _selectSourceFolder() async {
    setState(() {
      _isLoading = true;
    });

    final directoryPath = await FilePicker.platform.getDirectoryPath();

    setState(() {
      _isLoading = false;
      if (directoryPath != null) {
        _selectedSourceFolderPath = directoryPath;
      }
    });
  }

  Future<void> _selectDestinationFolder() async {
    setState(() {
      _isLoading = true;
    });

    final directoryPath = await FilePicker.platform.getDirectoryPath();

    setState(() {
      _isLoading = false;
      if (directoryPath != null) {
        _selectedDestinationFolderPath = directoryPath;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey.shade300,
      padding: const EdgeInsets.all(24.0),
      child: Center(
        child: Card(
          elevation: 4.0,
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: childrenCard(context),
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> childrenCard(BuildContext context) {
    return [
              copyStructureCheckbox(),
              selectedFolder(),
              if (_isLoading) ...[
                const SizedBox(height: 16.0),
                const Center(child: CircularProgressIndicator()),
              ],
              const SizedBox(height: 16.0),
              // Leyenda
              labelInputMultiline(),
              const SizedBox(height: 16.0),
              // Input de texto multilinea
              inputMultiline(),
              const SizedBox(height: 16.0),
              // Botón Aceptar
              btnAccept(),
            ];
  }
 

  ElevatedButton btnAccept() {
    return ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 14.0),
                ),
                onPressed: _moveFiles,
                child: const Text('Aceptar'),
              );
  }

  Text labelInputMultiline() {
    return const Text(
                'Seleccione la carpeta y agregue los archivos que desee buscar',
                style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500),
                textAlign: TextAlign.center,
              );
  }

  TextField inputMultiline() {
    return TextField(
                controller: _textController,
                maxLines: 5,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  hintText: 'Ingrese los archivos...',
                  contentPadding: const EdgeInsets.all(12.0),
                ),
              );
  }

  Widget selectedFolder() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SizedBox(height: 8.0),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    _selectedSourceFolderPath == null
                        ? 'Origen: no seleccionado'
                        : 'Origen: ${_folderNameFromPath(_selectedSourceFolderPath)}',
                    style: TextStyle(fontSize: 14.0, color: Colors.grey.shade700),
                  ),
                  const SizedBox(height: 8.0),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 14.0),
                    ),
                    onPressed: _selectSourceFolder,
                    child: const Text('Seleccionar carpeta origen'),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    _selectedDestinationFolderPath == null
                        ? 'Destino: no seleccionado'
                        : 'Destino: ${_folderNameFromPath(_selectedDestinationFolderPath)}',
                    style: TextStyle(fontSize: 14.0, color: Colors.grey.shade700),
                  ),
                  const SizedBox(height: 8.0),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 14.0),
                    ),
                    onPressed: _selectDestinationFolder,
                    child: const Text('Seleccionar carpeta destino'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  String _folderNameFromPath(String? path) {
    if (path == null || path.isEmpty) return 'no seleccionado';
    final segments = path.split(RegExp(r'[\\/]+'));
    return segments.isNotEmpty ? segments.last : path;
  }

  Widget copyStructureCheckbox() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Checkbox(
            value: _copyFolderStructure,
            onChanged: (value) {
              if (value == null) return;
              setState(() {
                _copyFolderStructure = value;
              });
            },
          ),
          const SizedBox(width: 8.0),
          const Flexible(
            child: Text('Copiar estructura de carpetas'),
          ),
        ],
      ),
    );
  }

  Future<void> _moveFiles() async {
    if (_selectedSourceFolderPath == null || _selectedDestinationFolderPath == null) {
      _showMessage('Por favor seleccione las carpetas de origen y destino');
      return;
    }

    final inputNames = _textController.text
        .split(RegExp(r'\n|,|;'))
        .map((e) => e.trim().toLowerCase())
        .where((e) => e.isNotEmpty)
        .toList();

    if (inputNames.isEmpty) {
      _showMessage('Por favor ingrese los nombres de los archivos a mover');
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      final sourceDir = Directory(_selectedSourceFolderPath!);
      final destDir = Directory(_selectedDestinationFolderPath!);

      if (await sourceDir.exists()) {
        final List<FileSystemEntity> entities = await sourceDir.list().toList();

        for (var entity in entities) {
          if (entity is File) {
            final String fileName = _folderNameFromPath(entity.path);
            final String baseName = fileName.contains('.') 
                ? fileName.substring(0, fileName.lastIndexOf('.'))
                : fileName;
            
            final String normalizedBaseName = baseName.toLowerCase();

            if (inputNames.contains(normalizedBaseName)) {
              final newPath = '${destDir.path}${Platform.pathSeparator}$fileName';
              try {
                await entity.rename(newPath);
              } catch (e) {
                // Fallback si dart:io lanza OS Error tratando de renombrar entre discos/particiones
                await entity.copy(newPath);
                await entity.delete();
              }
            }
          }
        }
      }
      
      if (mounted) {
        _showMessage('Archivos movidos con éxito');
      }
    } catch (e) {
      if (mounted) {
        _showMessage('Error al mover archivos: $e');
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }
}
