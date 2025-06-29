import 'package:flutter/material.dart';

import '../../features/home/home_view.dart';

class AppRoutes {
  static const String homeRoute = '/home';

  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  static const String initialRoute = homeRoute;

  static final Map<String, WidgetBuilder> routes = {
    homeRoute: (_) => const HomeView(),
  };
}
