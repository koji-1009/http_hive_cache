import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:http_hive_cache/src/adapter.dart';
import 'package:http_hive_cache/src/hive_helper.dart';
import 'package:http_hive_cache/src/http_cache.dart';

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
    Duration custom = const Duration(days: 365),
    bool forceRefresh = false,
  }) async {
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
        await _box.delete(key);
      }
    }

    final response = await http.get(
      url,
      headers: headers,
    );

    if (response.statusCode >= 200 && response.statusCode < 300) {
      final until = now.add(custom);

      final cache = HttpCache(
        url: key,
        statusCode: response.statusCode,
        body: response.bodyBytes,
        headers: response.headers,
        until: until,
      );

      _box.put(key, cache);
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
