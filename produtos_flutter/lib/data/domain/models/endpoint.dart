class Endpoint {
  final String path;
  final dynamic data;
  final String method;
  final String? contentType;
  final Map<String, String>? queryParameters;

  Endpoint({
    required this.path,
    required this.method,
    this.data,
    this.contentType,
    this.queryParameters,
  });
}
