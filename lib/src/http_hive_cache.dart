import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:http_hive_cache/src/cache_strategy.dart';
import 'package:http_hive_cache/src/private/adapter.dart';
import 'package:http_hive_cache/src/private/hive_helper.dart';
import 'package:http_hive_cache/src/private/http_cache.dart';

class HttpHiveCache {
  static late Box<HttpCache> _box;

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

  static Future<void> clear({
    required Uri url,
  }) async {
    await _box.delete(url.hashCode);
  }

  static Future<void> clearAll() async {
    await _box.clear();
  }

  static Future<http.Response> get(
    Uri url, {
    Map<String, String>? headers,
    CacheStrategy strategy = const CacheStrategy.client(),
    bool forceRefresh = false,
  }) async =>
      await strategy.when(
        none: () async => await http.get(
          url,
          headers: headers,
        ),
        client: (cacheControl) async => await _getClient(
          url: url,
          headers: headers,
          cacheControl: cacheControl,
          forceRefresh: forceRefresh,
        ),
        server: () async => await _getServer(
          url: url,
          headers: headers,
          forceRefresh: forceRefresh,
        ),
      );

  static Future<http.Response> _getClient({
    required Uri url,
    required Map<String, String>? headers,
    required Duration cacheControl,
    required bool forceRefresh,
  }) async {
    final now = DateTime.now();

    final cache = await _findCache(
      url: url,
    );
    if (cache != null) {
      if (now.isBefore(cache.until) && !forceRefresh) {
        return http.Response.bytes(
          cache.body,
          cache.statusCode,
          headers: cache.headers,
        );
      } else {
        await clear(
          url: url,
        );
      }
    }

    final response = await http.get(
      url,
      headers: headers,
    );

    if (response.statusCode >= 200 && response.statusCode < 300) {
      await _saveCache(
        url: url,
        response: response,
        until: now.add(cacheControl),
      );
    }

    return response;
  }

  static Future<http.Response> _getServer({
    required Uri url,
    required Map<String, String>? headers,
    required bool forceRefresh,
  }) async {
    final now = DateTime.now();

    final cache = await _findCache(
      url: url,
    );
    if (cache != null) {
      if (now.isBefore(cache.until) && !forceRefresh) {
        return http.Response.bytes(
          cache.body,
          cache.statusCode,
          headers: cache.headers,
        );
      } else {
        await clear(
          url: url,
        );
      }
    }

    final response = await http.get(
      url,
      headers: headers,
    );

    final cacheControl = response.headers.map(
        (key, value) => MapEntry(key.toLowerCase(), value))['cache-control'];
    if (cacheControl != null) {
      final param = cacheControl
          .split(',')
          .map((element) => element.trim().toLowerCase())
          .firstWhere(
            (element) =>
                element.contains('max-age') || element.contains('s-maxage'),
            orElse: () => '',
          );
      if (param.isNotEmpty) {
        final age = param.split('=');
        final cacheSeconds = int.tryParse(age[1]) ?? 0;

        if (cacheSeconds > 0) {
          await _saveCache(
            url: url,
            response: response,
            until: now.add(
              Duration(
                seconds: cacheSeconds,
              ),
            ),
          );
        }
      }
    }

    return response;
  }

  static Future<HttpCache?> _findCache({
    required Uri url,
  }) async =>
      _box.get(url.hashCode);

  static Future<void> _saveCache({
    required Uri url,
    required http.Response response,
    required DateTime until,
  }) async =>
      _box.put(
        url.hashCode,
        HttpCache.url(
          url: url,
          statusCode: response.statusCode,
          body: response.bodyBytes,
          headers: response.headers,
          until: until,
        ),
      );
}
