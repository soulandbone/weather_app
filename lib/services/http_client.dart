abstract class HttpClient {
  Future<HttpResponse<String>> getRaw(
    Uri url, {
    Map<String, String>? headers,
    Duration? timeout,
  });

  // Future<HttpResponse<String>> post(
  //   Uri url, {
  //   Map<String, String>? headers,
  //   Object? body,
  //   Duration? timeout,
  //   Encoding? encoding,
  // });
}

class HttpResponse<T> {
  final int statusCode;
  final T body;
  final Map<String, String> headers;

  const HttpResponse({
    required this.statusCode,
    required this.body,
    this.headers = const {},
  });
}
