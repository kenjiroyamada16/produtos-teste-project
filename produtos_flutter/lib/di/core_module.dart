import '../data/domain/api/api_provider.dart';
import '../support/utils/injector.dart';

class CoreModule extends AppModule {
  @override
  void registerDependencies() {
    injector.registerSingleton<ApiProviderProtocol>(ApiProvider.instance);
  }
}
