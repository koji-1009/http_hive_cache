import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:http_hive_cache/src/internal.dart';
import 'package:http_hive_cache/src/types.dart';

void main() {
  group('CacheStrategy', () {
    test('CacheStrategy.none equality', () {
      expect(const CacheStrategy.none(), const CacheStrategy.none());
      expect(
        const CacheStrategy.none().hashCode,
        const CacheStrategy.none().hashCode,
      );
    });

    test('CacheStrategy.client equality', () {
      expect(
        const CacheStrategy.client(cacheControl: Duration(seconds: 1)),
        const CacheStrategy.client(cacheControl: Duration(seconds: 1)),
      );
      expect(
        const CacheStrategy.client(cacheControl: Duration(seconds: 1)),
        isNot(const CacheStrategy.client(cacheControl: Duration(seconds: 2))),
      );
    });

    test('CacheStrategy.server equality', () {
      expect(const CacheStrategy.server(), const CacheStrategy.server());
    });
  });

  group('HttpHiveResponse', () {
    test('equality', () {
      final res1 = HttpHiveResponse(
        statusCode: 200,
        bodyBytes: Uint8List.fromList([1, 2, 3]),
        headers: const {'a': 'b'},
      );
      final res2 = HttpHiveResponse(
        statusCode: 200,
        bodyBytes: Uint8List.fromList([1, 2, 3]),
        headers: const {'a': 'b'},
      );
      final res3 = HttpHiveResponse(
        statusCode: 404,
        bodyBytes: Uint8List.fromList([1, 2, 3]),
        headers: const {'a': 'b'},
      );

      expect(res1, res2);
      expect(res1.hashCode, res2.hashCode);
      expect(res1, isNot(res3));
    });
  });

  group('HttpCache', () {
    test('equality', () {
      final now = DateTime.now();
      final c1 = HttpCache(
        url: 'a',
        statusCode: 200,
        body: Uint8List.fromList([1]),
        headers: const {},
        until: now,
      );
      final c2 = HttpCache(
        url: 'a',
        statusCode: 200,
        body: Uint8List.fromList([1]),
        headers: const {},
        until: now,
      );

      expect(c1, c2);
      expect(c1.hashCode, c2.hashCode);
    });
  });
}
