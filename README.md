# Visual Cache

A Flutter package for easily obtaining the size of the application cache. `Visual Cache` allows you to retrieve the cache size in a human-readable format (MB or GB), making it suitable for displaying cache-related information in your app's UI.

## Features

- Get the cache size of your Flutter application.
- Display cache size in MB or GB.
- Easy to integrate and use in any Flutter app.
- Ability to add your own directories.


## Screenshots

<img src="https://github.com/Smolla-ITc/visual_cache/blob/main/image/scr1.png"  width="350"/>

## Getting Started

To use the `Visual Cache` package, follow these simple steps:

### Installation

Add `Visual Cache` as a dependency in your `pubspec.yaml` file:

```yaml
dependencies:
  flutter:
    sdk: flutter
  visual_cache: ^1.0.0-betta.2
```

## Usage

``` dart
// Import package
import 'package:visual_cache/widget/visual_widget.dart';

// Show cache chart
VisualCacheWidget(subdirectories: ['NewFolder','NewFolder2', 'NewFolder3']),

// Or immediately display the entire cache without subdirectories
VisualCacheWidget(),
```
 
Available temporarily only for `Android`
