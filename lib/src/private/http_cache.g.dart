// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'http_cache.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class HttpCacheAdapter extends TypeAdapter<HttpCache> {
  @override
  final int typeId = 201;

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
