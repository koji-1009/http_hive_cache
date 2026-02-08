import 'dart:typed_data';

/// Cache strategy
sealed class CacheStrategy {
  const CacheStrategy();

  const factory CacheStrategy.none() = CacheStrategyNone;

  const factory CacheStrategy.client({Duration cacheControl}) =
      CacheStrategyClient;

  const factory CacheStrategy.server() = CacheStrategyServer;
}

class CacheStrategyNone extends CacheStrategy {
  const CacheStrategyNone();
}

class CacheStrategyClient extends CacheStrategy {
  const CacheStrategyClient({this.cacheControl = const Duration(hours: 1)});

  final Duration cacheControl;
}

class CacheStrategyServer extends CacheStrategy {
  const CacheStrategyServer();
}

class HttpHiveResponse {
  const HttpHiveResponse({
    required this.statusCode,
    required this.bodyBytes,
    required this.headers,
  });

  final int statusCode;
  final Uint8List bodyBytes;
  final Map<String, String> headers;
}

typedef HttpHiveClient =
    Future<HttpHiveResponse> Function(Uri url, {Map<String, String>? headers});
