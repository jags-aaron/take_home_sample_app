import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:take_home_sample_app/common_platform/i_platform_client.dart';

import '../../../data/repository/top_headlines_repository.dart';
import '../../../data/source/top_headlines_local_source_imp.dart';
import '../../../data/source/top_headlines_remote_source.dart';
import '../../../domain/entity/article_entity.dart';
import '../../../domain/use_case/save_article_use_case.dart';

// ⚠️ TODO this screen has a lot of improvements to be done ⚠️
// ⚠️ TODO Leave it as it is for now in order to focus on the main goal of this sample ⚠️
class DetailRoute extends GoRoute {
  static const routePath = 'detail';

  DetailRoute()
      : super(
          path: routePath,
          name: routePath,
          builder: (BuildContext context, GoRouterState state) {
            final platformClient = IPlatformClient.of(context);
            final remoteSource =
                TopHeadlinesRemoteSourceImp(platformClient: platformClient);
            final localSource =
                TopHeadlinesLocalSourceImp(platformClient: platformClient);
            final saveArticleUseCase = SaveArticleUseCase(
              repository: TopHeadlinesRepositoryImp(
                remoteSource: remoteSource,
                localSource: localSource,
              ),
            );

            final article =
                GoRouterState.of(context).extra! as TopHeadlineSourceEntity;

            return Scaffold(
              appBar: AppBar(
                title: Text(article.name),
              ),
              floatingActionButton: FloatingActionButton(
                onPressed: () async => {
                  await saveArticleUseCase.call(article).then(
                        (value) => ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Article saved'),
                          ),
                        ),
                      )
                },
                child: const Icon(Icons.favorite_border),
              ),
              body: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Data',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Text(
                    article.toMap().toString(),
                  ),
                ],
              ),
            );
          },
        );
}
