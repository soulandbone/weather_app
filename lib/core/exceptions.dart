class ApiException implements Exception {
  const ApiException(this.message, {this.statusCode, this.body});
  final int? statusCode;
  final String message;
  final String? body;

  @override
  String toString() =>
      'ApiException(status code: $statusCode, message: $message)';
}

class NetworkException implements Exception {
  const NetworkException(this.message);
  final String message;

  @override
  String toString() => 'NetWorkException: $message';
}

class CustomTimeoutException implements Exception {
  const CustomTimeoutException([this.message = 'Request timed out']);
  final String message;

  @override
  String toString() => 'CustomTimeoutException $message';
}

class ParseException implements Exception {
  const ParseException(this.message);
  final String message;

  @override
  String toString() => 'ParseException : $message';
}
