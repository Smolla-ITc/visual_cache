import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class VisualCacheCore {
  /// Gets the cache directory and returns its size in MB or GB.
  /// Gets the specified cache subdirectories and returns their total size in MB or GB.
  /// If no subdirectories are specified, it returns the size of the entire cache directory.
  Future<Map<String, int>> getCacheSizeDetails(
      {List<String>? subdirectories}) async {
    final cacheDir = await getTemporaryDirectory();
    Map<String, int> sizes = {};

    int totalCacheSize = await _calculateDirectorySize(cacheDir);
    int specifiedDirsSize = 0;

    if (subdirectories != null && subdirectories.isNotEmpty) {
      for (var subdir in subdirectories) {
        final subDirPath = Directory('${cacheDir.path}/$subdir');
        if (await subDirPath.exists()) {
          int subdirSize = await _calculateDirectorySize(subDirPath);
          sizes[subdir] = subdirSize;
          specifiedDirsSize += subdirSize;
        } else {
          sizes[subdir] = 0;
        }
      }
    }

    int remainingSize = totalCacheSize - specifiedDirsSize;
    if (remainingSize > 0) {
      sizes['Rest cache'] = remainingSize;
    }
    return sizes;
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
      debugPrint('Error calculating directory size: $e');
    }
    return size;
  }
}
