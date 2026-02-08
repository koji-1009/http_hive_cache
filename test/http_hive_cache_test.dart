import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:hive_ce/hive.dart';
import 'package:http_hive_cache/http_hive_cache.dart';
import 'package:http_hive_cache/src/internal.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late Directory tempDir;

  setUp(() async {
    tempDir = Directory.systemTemp.createTempSync('http_hive_cache_test_');
    Hive.init(tempDir.path);
  });

  tearDown(() async {
    await HttpHiveCache.close();
    if (tempDir.existsSync()) {
      tempDir.deleteSync(recursive: true);
    }
  });

  group('HttpHiveCache', () {
    test('open() registers adapter', () async {
      await HttpHiveCache.open(boxName: 'test_box');
      expect(Hive.isAdapterRegistered(201), isTrue);
    });

    test('get() with CacheStrategy.client caches response', () async {
      await HttpHiveCache.open(boxName: 'test_box_client');
      int callCount = 0;

      // Mock Client
      HttpHiveCache.client = (url, {headers}) async {
        callCount++;
        return HttpHiveResponse(
          bodyBytes: Uint8List.fromList(utf8.encode('{"data": "value"}')),
          statusCode: 200,
          headers: const {},
        );
      };

      final url = Uri.parse('https://example.com/client');

      // 1. First call (Network)
      final res1 = await HttpHiveCache.get(
        url,
        strategy: const CacheStrategy.client(
          cacheControl: Duration(milliseconds: 100),
        ),
      );
      expect(callCount, 1);
      expect(utf8.decode(res1.bodyBytes), '{"data": "value"}');

      // 2. Second call (Cache)
      final res2 = await HttpHiveCache.get(
        url,
        strategy: const CacheStrategy.client(
          cacheControl: Duration(milliseconds: 100),
        ),
      );
      expect(callCount, 1); // Should not increase
      expect(utf8.decode(res2.bodyBytes), '{"data": "value"}');

      // 3. Wait for expire
      await Future.delayed(const Duration(milliseconds: 200));

      // 4. Third call (Network - Expired)
      final res3 = await HttpHiveCache.get(
        url,
        strategy: const CacheStrategy.client(
          cacheControl: Duration(milliseconds: 100),
        ),
      );
      expect(callCount, 2); // Should increase
      expect(utf8.decode(res3.bodyBytes), '{"data": "value"}');
    });

    test('get() with CacheStrategy.server respects max-age', () async {
      await HttpHiveCache.open(boxName: 'test_box_server');
      int callCount = 0;

      HttpHiveCache.client = (url, {headers}) async {
        callCount++;
        return HttpHiveResponse(
          bodyBytes: Uint8List.fromList(utf8.encode('server data')),
          statusCode: 200,
          headers: const {'cache-control': 'public, max-age=1'},
        );
      };

      final url = Uri.parse('https://example.com/server');

      // 1. First call
      await HttpHiveCache.get(url, strategy: const CacheStrategy.server());
      expect(callCount, 1);

      // 2. Second call (Cache)
      await HttpHiveCache.get(url, strategy: const CacheStrategy.server());
      expect(callCount, 1);

      // 3. Wait
      await Future.delayed(const Duration(milliseconds: 1100));

      // 4. Third call (Expired)
      await HttpHiveCache.get(url, strategy: const CacheStrategy.server());
      expect(callCount, 2);
    });

    test('get() with CacheStrategy.none does not cache', () async {
      await HttpHiveCache.open(boxName: 'test_box_none');
      int callCount = 0;

      HttpHiveCache.client = (url, {headers}) async {
        callCount++;
        return HttpHiveResponse(
          bodyBytes: Uint8List.fromList([]),
          statusCode: 200,
          headers: const {},
        );
      };

      final url = Uri.parse('https://example.com/none');

      await HttpHiveCache.get(url, strategy: const CacheStrategy.none());
      expect(callCount, 1);

      await HttpHiveCache.get(url, strategy: const CacheStrategy.none());
      expect(callCount, 2);
    });

    test('forceRefresh ignores cache', () async {
      await HttpHiveCache.open(boxName: 'test_box_force');
      int callCount = 0;

      HttpHiveCache.client = (url, {headers}) async {
        callCount++;
        return HttpHiveResponse(
          bodyBytes: Uint8List.fromList([]),
          statusCode: 200,
          headers: const {},
        );
      };

      final url = Uri.parse('https://example.com/force');

      // Populate cache
      await HttpHiveCache.get(
        url,
        strategy: const CacheStrategy.client(
          cacheControl: Duration(minutes: 1),
        ),
      );
      expect(callCount, 1);

      // Force Refresh
      await HttpHiveCache.get(
        url,
        strategy: const CacheStrategy.client(
          cacheControl: Duration(minutes: 1),
        ),
        forceRefresh: true,
      );
      expect(callCount, 2);
    });

    test('delete() removes specific cache', () async {
      await HttpHiveCache.open(boxName: 'test_box_delete');
      int callCount = 0;

      HttpHiveCache.client = (url, {headers}) async {
        callCount++;
        return HttpHiveResponse(
          bodyBytes: Uint8List.fromList([]),
          statusCode: 200,
          headers: const {},
        );
      };

      final url = Uri.parse('https://example.com/delete');

      // Cache
      await HttpHiveCache.get(
        url,
        strategy: const CacheStrategy.client(
          cacheControl: Duration(minutes: 1),
        ),
      );
      expect(callCount, 1);

      // Delete
      await HttpHiveCache.delete(url: url);

      // Fetch again -> Network
      await HttpHiveCache.get(
        url,
        strategy: const CacheStrategy.client(
          cacheControl: Duration(minutes: 1),
        ),
      );
      expect(callCount, 2);
    });

    test('deleteAll() respects prefix', () async {
      await HttpHiveCache.open(
        boxName: 'test_box_prefix',
        prefix: 'my_prefix.',
      );

      // Manually add a key with DIFFERENT prefix
      final box = Hive.lazyBox<HttpCache>('test_box_prefix');
      await box.put(
        'other_prefix.key',
        HttpCache(
          url: 'other',
          statusCode: 200,
          body: Uint8List(0),
          headers: {},
          until: DateTime.now().add(const Duration(days: 1)),
        ),
      );

      // Add a key with CORRECT prefix (via get)
      final url = Uri.parse('https://example.com/prefix');
      HttpHiveCache.client = (url, {headers}) async => HttpHiveResponse(
        bodyBytes: Uint8List(0),
        statusCode: 200,
        headers: const {},
      );
      await HttpHiveCache.get(
        url,
        strategy: const CacheStrategy.client(
          cacheControl: Duration(minutes: 1),
        ),
      );

      expect(box.keys.length, 2);

      // Delete All
      await HttpHiveCache.deleteAll();

      // Verify 'other_prefix.key' still exists
      expect(box.containsKey('other_prefix.key'), isTrue);
      // Verify correct prefix key is gone
      expect(box.keys.length, 1);
    });
  });
}
