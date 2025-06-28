import 'package:get_it/get_it.dart';

import '../di/core_module.dart';

abstract class AppModule {
  void registerDependencies();
}

abstract class Injector {
  void initializeDependencies();
  void registerSingleton<T extends Object>(T instance);
  void registerFactory<T extends Object>(T Function() constructor);
  void registerLazySingleton<T extends Object>(T Function() constructor);
  void registerFactoryParam<T extends Object, P1>(T Function(P1) constructor);

  T get<T extends Object>({dynamic param, String? instanceName});
}

Injector injector = _ServiceLocator();

class _ServiceLocator implements Injector {
  static final GetIt getIt = GetIt.instance;

  @override
  void initializeDependencies() {
    final appModules = <AppModule>[CoreModule()];

    for (final module in appModules) {
      module.registerDependencies();
    }
  }

  @override
  T get<T extends Object>({param, String? instanceName}) {
    return getIt.get<T>(param1: param, instanceName: instanceName);
  }

  @override
  void registerSingleton<T extends Object>(T instance) {
    if (getIt.isRegistered<T>()) return;

    getIt.registerSingleton<T>(instance);
  }

  @override
  void registerFactory<T extends Object>(T Function() constructor) {
    if (getIt.isRegistered<T>()) return;

    getIt.registerFactory<T>(constructor);
  }

  @override
  void registerLazySingleton<T extends Object>(T Function() constructor) {
    if (getIt.isRegistered<T>()) return;

    getIt.registerLazySingleton<T>(constructor);
  }

  @override
  void registerFactoryParam<T extends Object, P1>(T Function(P1) constructor) {
    if (getIt.isRegistered<T>()) return;

    getIt.registerFactoryParam<T, P1, void>((param, _) => constructor(param));
  }
}
