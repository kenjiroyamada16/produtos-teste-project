import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiHost {
  static const String port = '5258';

  static String get baseUrl => kDebugMode ? 'http://localhost:$port/api' : '';

  static Map<String, dynamic> get defaultHeaders {
    const apiKeyHeaderName = 'x-api-key';

    return {apiKeyHeaderName: dotenv.env['API_KEY']};
  }
}
