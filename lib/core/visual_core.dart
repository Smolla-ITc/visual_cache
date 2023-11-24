import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class VisualCacheCore {
  /// Provides a stream of cache size details for real-time updates.
  Stream<Map<String, int>> getCacheSizeStream(
      {List<String>? subdirectories,
      Duration interval = const Duration(seconds: 1)}) async* {
    /// Continuously emits cache size details at specified intervals.
    while (true) {
      await Future.delayed(interval); // Wait for the interval duration
      yield await getCacheSizeDetails(subdirectories: subdirectories);
    }
  }

  /// Fetches cache size details once.
  Future<Map<String, int>> getCacheSizeDetails(
      {List<String>? subdirectories}) async {
    final cacheDir = await getTemporaryDirectory();
    Map<String, int> sizes = {};

    /// Total size of the cache directory.
    int totalCacheSize = await _calculateDirectorySize(cacheDir);
    int specifiedDirsSize = 0;

    /// Calculate size for each specified subdirectory.
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

    /// Calculate the size of the remaining cache.
    int remainingSize = totalCacheSize - specifiedDirsSize;
    if (remainingSize > 0) {
      sizes['Rest cache'] = remainingSize;
    }
    return sizes;
  }

  /// Calculates the size of a directory recursively.
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
