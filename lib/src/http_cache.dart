import 'dart:typed_data';

import 'package:hive/hive.dart';

part 'http_cache.g.dart';

@HiveType(typeId: 1)
class HttpCache {
  HttpCache({
    required this.url,
    required this.statusCode,
    required this.body,
    required this.headers,
    required this.until,
  });

  @HiveField(0)
  final String url;
  @HiveField(1)
  final int statusCode;
  @HiveField(2)
  final Uint8List body;
  @HiveField(3)
  final Map<String, String> headers;
  @HiveField(4)
  final DateTime until;
}
