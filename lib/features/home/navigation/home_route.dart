import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:take_home_sample_app/common_platform/i_platform_client.dart';
import 'package:take_home_sample_app/features/detail/navigation/detail_route.dart';

import '../../../data/source/articles_remote_source.dart';
import 'search_route.dart';

class HomeRoute extends GoRoute {
  static const routePath = '/';

  HomeRoute()
      : super(
            path: routePath,
            builder: (BuildContext context, GoRouterState state) {
              final platformClient = IPlatformClient.of(context);
              final remoteSource = ArticlesRemoteSourceImp(
                platformClient: platformClient
              );

              return Scaffold(
                appBar: AppBar(
                  title: const Text('Home'),
                ),
                body: Center(
                  child: TextButton(
                    onPressed: () {
                      // GoRouter.of(context).goNamed(SearchRoute.routePath);
                      remoteSource.getArticles('google pixel 8 pro');
                    },
                    onLongPress: () {
                      GoRouter.of(context).goNamed(DetailRoute.routePath);
                    },
                    child: const Text('Go to Search'),
                  ),
                ),
              );
            },
            routes: <RouteBase>[
              SearchRoute(),
            ]);
}
