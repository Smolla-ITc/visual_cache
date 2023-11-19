# Visual Cache

A Flutter package for easily obtaining the size of the application cache. `VisualCache` allows you to retrieve the cache size in a human-readable format (MB or GB), making it suitable for displaying cache-related information in your app's UI.

## Features

- Get the cache size of your Flutter application.
- Display cache size in MB or GB.
- Easy to integrate and use in any Flutter app.

## Getting Started

To use the `visual_cache` package, follow these simple steps:

### Installation

Add `visual_cache` as a dependency in your `pubspec.yaml` file:

```yaml
dependencies:
  flutter:
    sdk: flutter
  visual_cache: ^0.1.0-alpha
```

## Usage

``` dart
// IMPORT PACKAGE
import 'package:visual_cache/visual_cache.dart';

FutureBuilder<String>(
  future: VisualCache().getCacheSize(),
  builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
    if (snapshot.connectionState == ConnectionState.waiting) {
      return CircularProgressIndicator();
    } else if (snapshot.hasError) {
      return Text('Error: ${snapshot.error}');
    } else {
      return Text(
        snapshot.data ?? 'Cache size not available',
        style: Theme.of(context).textTheme.headlineMedium,
      );
    }
  },
)
```
 
Available temporarily only for `Android`