# http_hive_cache

[![pub package](https://img.shields.io/pub/v/http_hive_cache.svg)](https://pub.dev/packages/http_hive_cache)
[![analyze](https://github.com/koji-1009/http_hive_cache/actions/workflows/analyze.yaml/badge.svg)](https://github.com/koji-1009/http_hive_cache/actions/workflows/analyze.yaml)
[![codecov](https://codecov.io/gh/koji-1009/http_hive_cache/branch/main/graph/badge.svg)](https://codecov.io/gh/koji-1009/http_hive_cache)

A lightweight, efficient HTTP cache library for Flutter and Dart, powered by **Hive CE** (Community Edition).

It caches HTTP GET responses in a local Hive box, supporting standard `Cache-Control` headers, custom TTL, and offline-first strategies.

## Features

* 🚀 **Fast & Efficient**: Uses `LazyBox` to handle large caches without memory overhead.
* 📦 **Hive CE**: Built on the community-maintained `hive_ce` (v2), free from abandonware.
* 🧩 **Pluggable Client**: Works with `http`, `dio`, or any custom HTTP client.
* 🔒 **Safe**: Supports `sealed class` for type-safe strategy handling.
* 🛠 **Flexible**: Configurable storage path, cache prefix, and TypeId to avoid conflicts.
* 🌐 **Cross-Platform**: Supports iOS, Android, macOS, Windows, Linux, and Web.

## Getting Started

### 1. Installation

Add `http_hive_cache` and `hive_ce` to your `pubspec.yaml`:

```yaml
dependencies:
  http_hive_cache: ^1.0.0
  hive_ce: ^2.19.0
```

### 2. Initialization

Initialize Hive and open the cache box. You can specify a custom path (recommended for mobile/desktop) and optional configuration.

```dart
import 'package:hive_ce_flutter/hive_ce_flutter.dart';
import 'package:http_hive_cache/http_hive_cache.dart';
import 'package:path_provider/path_provider.dart';

void main() async {
  // 1. Initialize Hive
  await Hive.initFlutter();

  // 2. Get cache directory (Optional but recommended)
  final dir = await getApplicationCacheDirectory();

  // 3. Open HttpHiveCache
  await HttpHiveCache.open(
    path: dir.path, // Store in cache directory
    prefix: 'my_app_cache.', // Optional: Prefix for keys
  );

  runApp(const MyApp());
}
```

## Usage

### Basic Request

By default, it uses a standard HTTP GET request with a client-side cache strategy.

```dart
final response = await HttpHiveCache.get(
  Uri.parse('https://api.example.com/data'),
);

print('Status: ${response.statusCode}');
print('Body: ${utf8.decode(response.bodyBytes)}');
```

### Cache Strategies

You can control caching behavior using `CacheStrategy`.

#### 1. Client-Side Cache (Default)

Cache for a specific duration, ignoring server headers.

```dart
await HttpHiveCache.get(
  url,
  strategy: const CacheStrategy.client(
    cacheControl: Duration(minutes: 5), // Cache for 5 mins
  ),
);
```

#### 2. Server-Side Cache

Respects `Cache-Control` headers (e.g., `max-age`) from the server.

```dart
await HttpHiveCache.get(
  url,
  strategy: const CacheStrategy.server(),
);
```

#### 3. No Cache

Always fetch from network.

```dart
await HttpHiveCache.get(
  url,
  strategy: const CacheStrategy.none(),
);
```

### Custom HTTP Client

You can inject your own HTTP client (e.g., for authentication or logging).

```dart
HttpHiveCache.client = (url, {headers}) async {
  final result = await myCustomClient.get(url, headers: headers);
  return HttpHiveResponse(
    bodyBytes: result.bodyBytes,
    statusCode: result.statusCode,
    headers: result.headers,
  );
};
```

### TypeId Conflict

If `typeId: 201` conflicts with another adapter in your app, you can change it:

```dart
await HttpHiveCache.open(typeId: 250);
```

## License

MIT License - see [LICENSE](LICENSE) for details.
