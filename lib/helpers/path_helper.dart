class PathHelper {
  PathHelper._();

  static String folderNameFromPath(String? path) {
    if (path == null || path.isEmpty) return 'no seleccionado';
    final segments = path.split(RegExp(r'[\\/]+'));
    return segments.isNotEmpty ? segments.last : path;
  }
}
