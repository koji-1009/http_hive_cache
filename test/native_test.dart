import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:http_hive_cache/src/http/native.dart';

class MockHttpClient extends Fake implements HttpClient {
  @override
  Future<HttpClientRequest> getUrl(Uri url) async {
    return MockHttpClientRequest();
  }
}

class MockHttpClientRequest extends Fake implements HttpClientRequest {
  @override
  final HttpHeaders headers = MockHttpHeaders();

  @override
  Future<HttpClientResponse> close() async {
    return MockHttpClientResponse();
  }
}

class MockHttpHeaders extends Fake implements HttpHeaders {
  final Map<String, String> _headers = {};

  @override
  void add(String name, Object value, {bool preserveHeaderCase = false}) {
    _headers[name] = value.toString();
  }

  @override
  void forEach(void Function(String name, List<String> values) f) {
    _headers.forEach((key, value) => f(key, [value]));
  }
}

class MockHttpClientResponse extends Fake implements HttpClientResponse {
  @override
  int get statusCode => 200;

  @override
  HttpHeaders get headers => MockHttpHeaders();

  @override
  Future<E> fold<E>(
    E initialValue,
    E Function(E previous, List<int> element) combine,
  ) async {
    // Simulate body "ok"
    final body = utf8.encode('ok');
    return combine(initialValue, body);
  }
}

void main() {
  test('performGet uses HttpClient via HttpOverrides', () async {
    await HttpOverrides.runZoned(() async {
      final response = await performGet(Uri.parse('https://example.com'));
      expect(response.statusCode, 200);
      expect(utf8.decode(response.bodyBytes), 'ok');
    }, createHttpClient: (_) => MockHttpClient());
  });
}
