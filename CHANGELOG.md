## 1.0.0
* Release.
* bug fixed.

## 1.0.0-rc.1
* Code formatted for dart.

## 1.0.0-betta.4

* Added real-time cache display/updates.
* Added the ability to disable or enable real-time cache displays. Example:
```dart
isRealTime: false, // Enable disable realtime cache
```
* Rewritten comments for better understanding of the code.
* Minor bugs fixed.
* Updated README.md file.

## 1.0.0-betta.3
* Now you need to call `VisualCache()` instead of `VisualCacheWidget()`.
* Added the ability to add names to your subdirectories, example: 
```dart
// 'Path to subdirectories ': 'Custom name subdirectories'
namedSubdirectories: {
  'NewFolder': 'Images',
  'NewFolder2': 'Videos',
  'NewFolder3': 'File',
},
```
* Added the ability to use your own colors for an example diagram:
```dart
colorSubdirectories: [
  Colors.amberAccent, // Images color
  Colors.deepOrange, // Videos color
  Colors.deepPurpleAccent, // File color
  Colors.teal, // Add a final color for "Rest Cache" if you don't want it to be determined by itself
],
```
* Added the ability to hide subdirectory names example:
```dart
showLegends: true, // Enable disable display of directory names
```
* Added display "Rest Cache" is displayed itself if there are cache files in the /cache folder.
* Fixed MB and GB formatting.
* Error and bug fixes.
* Updated README.md file.

## 1.0.0-betta.2

* Update README.md;
* Update CHANGELOG.md;

## 1.0.0-betta.1

* Now you don’t need to write a grammar construct, now you just need to call the VisualCacheWidget() widget;
* Added visual cache viewing using the pie_chart 5.4.0 library;
* Added the ability to add your own directory. Example:
```dart 
VisualCacheWidget(subdirectories: ['NewFolder','NewFolder2', 'NewFolder3'],)
```
* Update README.md;
* Bug fixes;

## 0.1.3-alpha

* Platform support updates
* Update README.md

## 0.1.0-alpha

* First release.