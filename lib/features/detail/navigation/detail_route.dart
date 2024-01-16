import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:take_home_sample_app/common_platform/extensions/go_router_extension.dart';
import 'package:take_home_sample_app/common_platform/i_platform_client.dart';

import '../../../data/source/articles_remote_source.dart';
import '../../home/navigation/home_route.dart';

class DetailRoute extends GoRoute {
  static const routePath = 'detail';

  DetailRoute()
      : super(
          path: routePath,
          name: routePath,
          builder: (BuildContext context, GoRouterState state) {
            final platformClient = IPlatformClient.of(context);

            return Scaffold(
              appBar: AppBar(
                title: const Text('Detail'),
              ),
              body: Center(
                child: TextButton(
                  onPressed: () {
                    GoRouter.of(context).popUntil(HomeRoute.routePath);
                  },
                  child: const Text('Go to Home'),
                ),
              ),
            );
          },
        );
}
