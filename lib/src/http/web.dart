import 'dart:js_interop';

import 'package:http_hive_cache/src/types.dart';
import 'package:web/web.dart' as web;

Future<HttpHiveResponse> performGet(
  Uri url, {
  Map<String, String>? headers,
}) async {
  final requestInit = web.RequestInit(method: 'GET');

  if (headers != null) {
    final headersJs = web.Headers();
    headers.forEach((key, value) {
      headersJs.append(key, value);
    });
    requestInit.headers = headersJs;
  }

  final response = await web.window
      .fetch(url.toString().toJS, requestInit)
      .toDart;
  final arrayBuffer = await response.arrayBuffer().toDart;
  final bodyBytes = arrayBuffer.toDart.asUint8List();

  final responseHeaders = <String, String>{};

  final cacheControl = response.headers.get('cache-control');
  if (cacheControl != null) {
    responseHeaders['cache-control'] = cacheControl;
  }

  return HttpHiveResponse(
    statusCode: response.status,
    bodyBytes: bodyBytes,
    headers: responseHeaders,
  );
}
