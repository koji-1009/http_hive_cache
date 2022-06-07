<!-- 
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/guides/libraries/writing-package-pages). 

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-library-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/developing-packages). 
-->

The response can be cached during HTTP GET.

## Features

Three patterns are supported: no cache, response headers, and client specification.

## Getting started

TODO: List prerequisites and provide or point to information on how to
start using the package.

## Usage

```dart
final response = await HttpHiveCache.get(
  Uri.parse(url),
);
```
