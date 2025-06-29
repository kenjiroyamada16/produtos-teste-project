import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiHost {
  static String get baseUrl =>
      kDebugMode ? '[INSIRA A URL DA SUA API AQUI]' : '';

  static Map<String, dynamic> get defaultHeaders {
    const apiKeyHeaderName = 'x-api-key';

    return {apiKeyHeaderName: dotenv.env['API_KEY']};
  }
}
