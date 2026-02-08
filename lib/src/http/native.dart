import 'dart:io';
import 'dart:typed_data';

import 'package:http_hive_cache/src/types.dart';

final _client = HttpClient();

Future<HttpHiveResponse> performGet(
  Uri url, {
  Map<String, String>? headers,
}) async {
  final request = await _client.getUrl(url);

  headers?.forEach((key, value) {
    request.headers.add(key, value);
  });

  final response = await request.close();
  final bodyBytes = await response
      .fold<BytesBuilder>(
        BytesBuilder(),
        (builder, chunk) => builder..add(chunk),
      )
      .then((builder) => builder.takeBytes());

  final responseHeaders = <String, String>{};
  response.headers.forEach((key, values) {
    responseHeaders[key] = values.join(',');
  });

  return HttpHiveResponse(
    statusCode: response.statusCode,
    bodyBytes: bodyBytes,
    headers: responseHeaders,
  );
}
