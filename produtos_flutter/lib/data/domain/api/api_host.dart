import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiHost {
  static String get baseUrl => kDebugMode ? 'https://788f-200-152-81-65.ngrok-free.app' : '';

  static Map<String, dynamic> get defaultHeaders {
    const apiKeyHeaderName = 'x-api-key';

    return {apiKeyHeaderName: dotenv.env['API_KEY']};
  }
}
