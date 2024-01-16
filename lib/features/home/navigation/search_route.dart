import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:take_home_sample_app/common_platform/extensions/go_router_extension.dart';
import 'package:take_home_sample_app/common_platform/i_platform_client.dart';
import 'package:take_home_sample_app/features/detail/navigation/detail_route.dart';
import 'package:take_home_sample_app/features/home/navigation/home_route.dart';

class SearchRoute extends GoRoute {
  static const routePath = 'search';

  SearchRoute()
      : super(
          path: routePath,
          name: routePath,
          builder: (BuildContext context, GoRouterState state) {
            final platformClient = IPlatformClient.of(context);

            return Scaffold(
              appBar: AppBar(
                title: const Text('Search'),
              ),
              body: Center(
                child: TextButton(
                  onPressed: () {
                    GoRouter.of(context).pushNamed(DetailRoute.routePath);
                  },
                  child: const Text('Go to Detail'),
                ),
              ),
            );
          },
          routes: [
            DetailRoute(),
          ],
        );
}
