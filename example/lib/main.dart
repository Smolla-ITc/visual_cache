import 'package:flutter/material.dart';
import 'package:visual_cache/visual_cache.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Visual cache Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.greenAccent),
        useMaterial3: true,
      ),
      home: const VisualCacheDemo(),
    );
  }
}

class VisualCacheDemo extends StatelessWidget {
  const VisualCacheDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Visual cache demo'),
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Cache size',
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 70),
            VisualCache(
              // 'Path to subdirectories ': 'Custom name subdirectories'
              namedSubdirectories: {
                'NewFolder': 'Images',
                'NewFolder2': 'Videos',
                'NewFolder3': 'File',
              },
              // Custom colors subdirectories
              colorSubdirectories: [
                Colors.amberAccent, // Images color
                Colors.deepOrange, // Videos color
                Colors.deepPurpleAccent, // File color
                Colors
                    .teal, // Add a final color for "Rest Cache" if you don't want it to be determined by itself
              ],
              showLegends: true, // Enable disable display of directory names
            )
          ],
        ),
      ),
    );
  }
}
