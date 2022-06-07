import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:http_hive_cache/src/adapter.dart';
import 'package:http_hive_cache/src/hive_helper.dart';
import 'package:http_hive_cache/src/http_cache.dart';

enum CacheStrategy {
  none,
  client,
  server,
}

class HttpHiveCache {
  static Future<void> init({
    String subDir = 'http_cache',
  }) async {
    await HiveHelper.initFlutter(subDir: subDir);
    Hive
      ..registerAdapter(HttpCacheAdapter())
      ..registerAdapter(DateTimeAdapter());

    await open();
  }

  static Future<void> open() async {
    _box = await Hive.openBox<HttpCache>('HttpHiveCache');
  }

  static Future<void> close() async {
    await _box.close();
  }

  static late Box<HttpCache> _box;

  static Future<http.Response> get(
    Uri url, {
    Map<String, String>? headers,
    CacheStrategy strategy = CacheStrategy.client,
    Duration custom = const Duration(days: 365),
    bool forceRefresh = false,
  }) async {
    if (strategy == CacheStrategy.none) {
      return await http.get(
        url,
        headers: headers,
      );
    }

    final now = DateTime.now();

    final key = url.toString();
    final cache = _box.get(key);
    if (cache != null) {
      if (now.isBefore(cache.until) && !forceRefresh) {
        return http.Response.bytes(
          cache.body,
          cache.statusCode,
          headers: cache.headers,
        );
      } else {
        await clear(url: url);
      }
    }

    final response = await http.get(
      url,
      headers: headers,
    );

    if (response.statusCode >= 200 && response.statusCode < 300) {
      switch (strategy) {
        case CacheStrategy.none:
          throw Exception();
        case CacheStrategy.client:
          final cache = HttpCache(
            url: key,
            statusCode: response.statusCode,
            body: response.bodyBytes,
            headers: response.headers,
            until: now.add(custom),
          );

          _box.put(key, cache);
          break;
        case CacheStrategy.server:
          final headers = response.headers.map(
            (key, value) => MapEntry(key.toLowerCase(), value),
          );

          if (headers.containsKey('cache-control')) {
            final header = response.headers['cache-control']!;

            final param = header
                .split(',')
                .map((element) => element.trim().toLowerCase())
                .firstWhere(
                  (element) =>
                      element.contains('max-age') ||
                      element.contains('s-maxage'),
                  orElse: () => '',
                );
            if (param.isNotEmpty) {
              final age = param.split('=');
              final cacheSeconds = int.tryParse(age[1]) ?? 0;

              if (cacheSeconds > 0) {
                final cache = HttpCache(
                  url: key,
                  statusCode: response.statusCode,
                  body: response.bodyBytes,
                  headers: response.headers,
                  until: now.add(
                    Duration(
                      seconds: cacheSeconds,
                    ),
                  ),
                );

                _box.put(key, cache);
                break;
              }
            }
          } else {
            // no cache
          }
          break;
      }
    }

    return response;
  }

  static Future<void> clear({
    required Uri url,
  }) async {
    final key = url.toString();
    await _box.delete(key);
  }

  static Future<void> clearAll() async {
    await _box.clear();
  }
}
