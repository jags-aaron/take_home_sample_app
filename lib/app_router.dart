import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import 'features/detail/navigation/detail_route.dart';
import 'features/home/navigation/home_route.dart';

class AppRouter {
  static AppRouter of(BuildContext context, {bool listen = false}) =>
      Provider.of<AppRouter>(context, listen: listen);

  final router = GoRouter(
    initialLocation: HomeRoute.routePath,
    routes: _appRoutes,
    debugLogDiagnostics: true,
  );

  static get _appRoutes => [
        HomeRoute(),
      ];
}
