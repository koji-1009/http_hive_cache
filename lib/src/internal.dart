import 'dart:typed_data';

import 'package:hive_ce/hive.dart';

class HttpCache {
  const HttpCache({
    required this.url,
    required this.statusCode,
    required this.body,
    required this.headers,
    required this.until,
  });

  factory HttpCache.url({
    required Uri url,
    required int statusCode,
    required Uint8List body,
    required Map<String, String> headers,
    required DateTime until,
  }) => HttpCache(
    url: url.toString(),
    statusCode: statusCode,
    body: body,
    headers: headers,
    until: until,
  );

  final String url;
  final int statusCode;
  final Uint8List body;
  final Map<String, String> headers;
  final DateTime until;
}

class HttpCacheAdapter extends TypeAdapter<HttpCache> {
  const HttpCacheAdapter({required this.typeId});

  @override
  final int typeId;

  @override
  HttpCache read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HttpCache(
      url: fields[0] as String,
      statusCode: fields[1] as int,
      body: fields[2] as Uint8List,
      headers: (fields[3] as Map).cast<String, String>(),
      until: fields[4] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, HttpCache obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.url)
      ..writeByte(1)
      ..write(obj.statusCode)
      ..writeByte(2)
      ..write(obj.body)
      ..writeByte(3)
      ..write(obj.headers)
      ..writeByte(4)
      ..write(obj.until);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HttpCacheAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
