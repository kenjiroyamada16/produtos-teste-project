import '../data/domain/api/api_provider.dart';
import '../data/domain/repositories/products_repository.dart';
import '../features/home/home_view.dart';
import '../features/home/home_view_model.dart';
import '../support/utils/injector.dart';

class HomeModule extends AppModule {
  @override
  void registerDependencies() {
    injector.registerFactory<ProductsRepositoryProtocol>(() {
      return ProductsRepository(
        apiProvider: injector.get<ApiProviderProtocol>(),
      );
    });

    injector.registerFactory<HomeViewModelProtocol>(() {
      return HomeViewModel(
        productsRepository: injector.get<ProductsRepositoryProtocol>(),
      );
    });
  }
}
