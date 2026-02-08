import 'package:flutter/foundation.dart';

/// Cache strategy
sealed class CacheStrategy {
  const CacheStrategy();

  const factory CacheStrategy.none() = CacheStrategyNone;

  const factory CacheStrategy.client({Duration cacheControl}) =
      CacheStrategyClient;

  const factory CacheStrategy.server() = CacheStrategyServer;
}

@immutable
class CacheStrategyNone extends CacheStrategy {
  const CacheStrategyNone();

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CacheStrategyNone && runtimeType == other.runtimeType;

  @override
  int get hashCode => runtimeType.hashCode;
}

@immutable
class CacheStrategyClient extends CacheStrategy {
  const CacheStrategyClient({this.cacheControl = const Duration(hours: 1)});

  final Duration cacheControl;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CacheStrategyClient &&
          runtimeType == other.runtimeType &&
          cacheControl == other.cacheControl;

  @override
  int get hashCode => cacheControl.hashCode;
}

@immutable
class CacheStrategyServer extends CacheStrategy {
  const CacheStrategyServer();

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CacheStrategyServer && runtimeType == other.runtimeType;

  @override
  int get hashCode => runtimeType.hashCode;
}

@immutable
class HttpHiveResponse {
  const HttpHiveResponse({
    required this.statusCode,
    required this.bodyBytes,
    required this.headers,
  });

  final int statusCode;
  final Uint8List bodyBytes;
  final Map<String, String> headers;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! HttpHiveResponse) return false;
    if (statusCode != other.statusCode) return false;
    if (headers.length != other.headers.length) return false;
    // Simple header check
    for (final key in headers.keys) {
      if (headers[key] != other.headers[key]) return false;
    }
    // Body check
    if (bodyBytes.length != other.bodyBytes.length) return false;
    for (int i = 0; i < bodyBytes.length; i++) {
      if (bodyBytes[i] != other.bodyBytes[i]) return false;
    }
    return true;
  }

  @override
  int get hashCode => Object.hash(
    statusCode,
    Object.hashAll(bodyBytes),
    Object.hashAll(headers.keys),
    Object.hashAll(headers.values),
  );
}

typedef HttpHiveClient =
    Future<HttpHiveResponse> Function(Uri url, {Map<String, String>? headers});
