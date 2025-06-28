import 'package:dio/dio.dart';

import '../models/api_response.dart';
import '../models/endpoint.dart';
import 'api_host.dart';

abstract class ApiProviderProtocol {
  Future<ApiResponse<T>> request<T>(Endpoint endpoint);
}

class ApiProvider extends ApiProviderProtocol {
  static final ApiProviderProtocol instance = ApiProvider._();

  ApiProvider._();

  final Dio _dio = Dio();

  @override
  Future<ApiResponse<T>> request<T>(Endpoint endpoint) async {
    _dio.options.method = endpoint.method;
    _dio.options.baseUrl = ApiHost.baseUrl;
    _dio.options.headers = ApiHost.defaultHeaders;

    try {
      final response = await _dio.request(
        endpoint.path,
        data: endpoint.data,
        queryParameters: endpoint.queryParameters,
      );

      return ApiResponse.success(response.data);
    } on DioException catch (_) {
      return ApiResponse.failure(Exception('Houve um erro na requisição'));
    }
  }
}
