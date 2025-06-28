import '../../../models/products_list.dart';
import '../api/api_provider.dart';
import '../models/api_response.dart';
import '../models/endpoint.dart';

abstract class ProductsRepositoryProtocol {
  Future<ApiResponse<ProductsList>> getProducts({int? page, int? itemsCount});
}

class ProductsRepository extends ProductsRepositoryProtocol {
  final ApiProviderProtocol apiProvider;

  ProductsRepository({required this.apiProvider});

  @override
  Future<ApiResponse<ProductsList>> getProducts({
    int? page,
    int? itemsCount,
  }) async {
    final endpoint = Endpoint(
      method: 'GET',
      path: '/Products',
      queryParameters: {
        if (page != null) 'page': page.toString(),
        if (itemsCount != null) 'pageSize': itemsCount.toString(),
      },
    );

    final response = await apiProvider.request(endpoint);

    switch (response) {
      case Success():
        try {
          return ApiResponse.success(ProductsList.fromJson(response.value));
        } on TypeError catch (_) {
          return ApiResponse.failure(Exception('Houve um erro na requisição'));
        }
      case Failure():
        return ApiResponse.failure(Exception('Houve um erro na requisição'));
    }
  }
}
