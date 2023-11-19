library visual_cache;

import 'dart:io';
import 'package:path_provider/path_provider.dart';

class VisualCache {
  /// Gets the cache directory and returns its size in MB or GB.
  Future<String> getCacheSize() async {
    final cacheDir = await getTemporaryDirectory();
    final cacheSize = await _calculateDirectorySize(cacheDir);

    // Convert size to MB or GB
    return (cacheSize / (1024 * 1024)) < 1024
        ? '${(cacheSize / (1024 * 1024)).toStringAsFixed(2)} MB'
        : '${(cacheSize / (1024 * 1024 * 1024)).toStringAsFixed(2)} GB';
  }

  /// Recursively calculates the size of a directory and its subdirectories.
  Future<int> _calculateDirectorySize(Directory dir) async {
    int size = 0;
    try {
      final files = dir.listSync(recursive: true);
      for (var file in files) {
        if (file is File) {
          size += await file.length();
        }
      }
    } catch (e) {
      print('Error calculating directory size: $e');
    }
    return size;
  }
}
