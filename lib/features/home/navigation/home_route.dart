import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:take_home_sample_app/common_platform/i_platform_client.dart';
import 'package:take_home_sample_app/data/source/top_headlines_local_source_imp.dart';
import 'package:take_home_sample_app/features/detail/navigation/detail_route.dart';
import 'package:take_home_sample_app/features/home/navigation/favorites_route.dart';
import 'package:take_home_sample_app/features/home/screen/bloc/home_bloc.dart';

import '../../../data/repository/top_headlines_repository.dart';
import '../../../data/source/top_headlines_remote_source.dart';
import '../../../domain/use_case/get_top_headlines_use_case.dart';
import '../screen/home_controller.dart';

class HomeRoute extends GoRoute {
  static const routePath = '/';

  HomeRoute()
      : super(
          path: routePath,
          builder: (BuildContext context, GoRouterState state) {
            final platformClient = IPlatformClient.of(context);
            final remoteSource =
                TopHeadlinesRemoteSourceImp(platformClient: platformClient);
            final localSource =
                TopHeadlinesLocalSourceImp(platformClient: platformClient);
            final getTopHeadUseCase = GetTopHeadlinesUseCase(
              repository: TopHeadlinesRepositoryImp(
                remoteSource: remoteSource,
                localSource: localSource,
              ),
            );

            return BlocProvider(
              create: (context) => HomeBloc(
                getTopHeadUseCase: getTopHeadUseCase,
              ),
              child: const HomeController(),
            );
          },
          routes: <RouteBase>[
            DetailRoute(),
            FavoritesRoute(),
          ],
        );
}
