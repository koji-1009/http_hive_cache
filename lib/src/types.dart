import 'package:flutter/foundation.dart';

/// Cache strategy
/// strategies for caching.
sealed class CacheStrategy {
  const CacheStrategy();

  /// Default strategy: [CacheStrategyNone].
  const factory CacheStrategy.none() = CacheStrategyNone;

  /// Cache strategy that respects client-side cache control.
  const factory CacheStrategy.client({Duration cacheControl}) =
      CacheStrategyClient;

  /// Cache strategy that respects server-side cache control headers.
  const factory CacheStrategy.server() = CacheStrategyServer;
}

/// No caching strategy.
///
/// Requests will always be fetched from the network.
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

/// Client-side caching strategy.
///
/// Uses a fixed [cacheControl] duration to determine cache validity.
@immutable
class CacheStrategyClient extends CacheStrategy {
  const CacheStrategyClient({this.cacheControl = const Duration(hours: 1)});

  /// The duration for which the response should be cached.
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

/// Server-side caching strategy.
///
/// Respects `Cache-Control` headers (e.g., `max-age`, `s-maxage`) sent by the server.
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

/// A response object stored in Hive.
@immutable
class HttpHiveResponse {
  const HttpHiveResponse({
    required this.statusCode,
    required this.bodyBytes,
    required this.headers,
  });

  /// The HTTP status code.
  final int statusCode;

  /// The response body bytes.
  final Uint8List bodyBytes;

  /// The response headers.
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

/// A client function for making HTTP requests.
typedef HttpHiveClient =
    Future<HttpHiveResponse> Function(Uri url, {Map<String, String>? headers});
