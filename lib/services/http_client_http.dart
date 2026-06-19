import 'dart:async';

import 'package:weather_app/core/exceptions.dart';
import 'package:weather_app/services/http_client.dart';
import 'package:http/http.dart' as http;

class HttpClientHttp implements HttpClient {
  final client = http.Client();

  @override
  Future<HttpResponse<String>> getRaw(
    Uri url, {
    Map<String, String>? headers,
    Duration? timeout,
  }) async {
    try {
      final response = await client
          .get(url, headers: headers)
          .timeout(timeout ?? const Duration(seconds: 10));

      if (response.statusCode < 200 || response.statusCode >= 300) {
        throw ApiException(
          'HTTP: ${response.statusCode}',
          body: response.body,
          statusCode: response.statusCode,
        );
      }
      return HttpResponse<String>(
        statusCode: response.statusCode,
        body: response.body,
        headers: response.headers,
      );
    } on TimeoutException {
      throw CustomTimeoutException();
    }
  }
}
