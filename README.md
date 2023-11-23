[![Pub Version](https://img.shields.io/pub/v/visual_cache?color=orange)](https://pub.dev/packages/visual_cache)

# Visual Cache

A Flutter package for easily obtaining the size of the application cache. `Visual Cache` allows you to retrieve the cache size in a human-readable format (MB or GB), making it suitable for displaying cache-related information in your app's UI.

## Features

- Real-time cache display/updates.
- Get the cache size of your Flutter app.
- Display cache size in MB or GB.
- Easy to integrate and use in any Flutter app.
- Ability to add your own catalogs and your own colors.
- Flexible chart settings.

## Screenshots

<img src="https://raw.githubusercontent.com/Smolla-ITc/visual_cache/release/image/scr2.png" width="350"/>

## Getting Started

To use the `Visual Cache` package, follow these simple steps:

### Installation

Add `Visual Cache` as a dependency in your `pubspec.yaml` file:

```yaml
dependencies:
  flutter:
    sdk: flutter
  visual_cache: ^1.0.0-betta.4
```

## Usage

```dart
// Import package
import 'package:visual_cache/visual_widget.dart';

 /// Show cache chart
 VisualCache(
   /// 'Path to subdirectories (folder)': 'Custom name subdirectories'
   namedSubdirectories: {
     'NewFolder': 'Images',
     'NewFolder2': 'Videos',
     'NewFolder3': 'File',
   },
   /// Custom colors subdirectories
   colorSubdirectories: [
     Colors.amberAccent, // Images color
     Colors.deepOrange, // Videos color
     Colors.deepPurpleAccent, // File color
     Colors.teal, // Add a final color for "Rest Cache" if you don't want it to be determined by itself
   ],
   showLegends: true, // Enable disable display of directory names
   isRealTime: false, // Enable disable realtime cache
) 
            
```

Available temporarily only for `Android`.