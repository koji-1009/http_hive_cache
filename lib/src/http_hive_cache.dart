import 'package:hive_ce/hive.dart';
import 'package:http_hive_cache/src/http/http.dart';
import 'package:http_hive_cache/src/internal.dart';
import 'package:http_hive_cache/src/types.dart';

class HttpHiveCache {
  static late LazyBox<HttpCache> _box;
  static late String _prefix;
  static HttpHiveClient client = performGet;

  static Future<void> open({
    String? boxName,
    String? path,
    String prefix = 'http_hive_cache.',
    int typeId = 201,
  }) async {
    _prefix = prefix;
    if (!Hive.isAdapterRegistered(typeId)) {
      Hive.registerAdapter(HttpCacheAdapter(typeId: typeId));
    }
    _box = await Hive.openLazyBox<HttpCache>(
      boxName ?? 'http_hive_cache',
      path: path,
    );
  }

  static Future<void> close() async {
    await _box.close();
  }

  static Future<void> delete({required Uri url}) async {
    await _box.delete(_key(url));
  }

  static Future<void> deleteAll() async {
    final keys = _box.keys.where((k) => k.toString().startsWith(_prefix));
    await _box.deleteAll(keys);
  }

  static String _key(Uri url) => '$_prefix$url';

  static Future<HttpHiveResponse> get(
    Uri url, {
    Map<String, String>? headers,
    CacheStrategy strategy = const CacheStrategy.client(),
    bool forceRefresh = false,
  }) async => await switch (strategy) {
    CacheStrategyNone() => client(url, headers: headers),
    CacheStrategyClient(:final cacheControl) => _request(
      url: url,
      headers: headers,
      cacheControl: cacheControl,
      forceRefresh: forceRefresh,
    ),
    CacheStrategyServer() => _request(
      url: url,
      headers: headers,
      forceRefresh: forceRefresh,
      checkServerHeaders: true,
    ),
  };

  static Future<HttpHiveResponse> _request({
    required Uri url,
    required Map<String, String>? headers,
    Duration? cacheControl,
    required bool forceRefresh,
    bool checkServerHeaders = false,
  }) async {
    final now = DateTime.now();
    final cache = await _findCache(url: url);

    if (cache != null) {
      if (now.isBefore(cache.until) && !forceRefresh) {
        return HttpHiveResponse(
          bodyBytes: cache.body,
          statusCode: cache.statusCode,
          headers: cache.headers,
        );
      } else {
        await delete(url: url);
      }
    }

    final response = await client(url, headers: headers);

    if (response.statusCode >= 200 && response.statusCode < 300) {
      DateTime? until;

      if (checkServerHeaders) {
        final serverCacheControl = response.headers.map(
          (key, value) => MapEntry(key.toLowerCase(), value),
        )['cache-control'];

        if (serverCacheControl != null) {
          final param = serverCacheControl
              .split(',')
              .map((e) => e.trim().toLowerCase())
              .firstWhere(
                (e) => e.contains('max-age') || e.contains('s-maxage'),
                orElse: () => '',
              );

          if (param.isNotEmpty) {
            final age = param.split('=');
            final cacheSeconds =
                int.tryParse(age.length > 1 ? age[1] : '') ?? 0;
            if (cacheSeconds > 0) {
              until = now.add(Duration(seconds: cacheSeconds));
            }
          }
        }
      } else if (cacheControl != null) {
        until = now.add(cacheControl);
      }

      if (until != null) {
        await _saveCache(url: url, response: response, until: until);
      }
    }

    return response;
  }

  static Future<HttpCache?> _findCache({required Uri url}) async =>
      _box.get(_key(url));

  static Future<void> _saveCache({
    required Uri url,
    required HttpHiveResponse response,
    required DateTime until,
  }) async => _box.put(
    _key(url),
    HttpCache.url(
      url: url,
      statusCode: response.statusCode,
      body: response.bodyBytes,
      headers: response.headers,
      until: until,
    ),
  );
}
