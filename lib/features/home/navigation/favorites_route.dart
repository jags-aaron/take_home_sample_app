import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:take_home_sample_app/common_platform/i_platform_client.dart';
import 'package:take_home_sample_app/data/source/top_headlines_local_source_imp.dart';
import 'package:take_home_sample_app/domain/use_case/get_saved_articles_use_case.dart';
import 'package:take_home_sample_app/features/detail/navigation/detail_route.dart';
import 'package:take_home_sample_app/features/home/screen/bloc/home_bloc.dart';

import '../../../data/repository/top_headlines_repository.dart';
import '../../../data/source/top_headlines_remote_source.dart';
import '../../../domain/entity/article_entity.dart';
import '../../../domain/use_case/get_top_headlines_use_case.dart';
import '../screen/home_controller.dart';

class FavoritesRoute extends GoRoute {
  static const routePath = 'favorites';

  FavoritesRoute()
      : super(
          path: routePath,
          name: routePath,
          builder: (BuildContext context, GoRouterState state) {
            return const FavoriteScreen();
          },
        );
}

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {

  @override
  Widget build(BuildContext context) {
    final platformClient = IPlatformClient.of(context);
    final localSource = TopHeadlinesLocalSourceImp(
      platformClient: platformClient,
    );

    return FutureBuilder<List<TopHeadlineSourceEntity>>(
      future: localSource.getArticles(), // async work
      builder: (BuildContext context,
          AsyncSnapshot<List<TopHeadlineSourceEntity>> snapshot) {
        var articles = snapshot.data ?? [];

        if(articles.isEmpty) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Favorites'),
            ),
            body: const Center(
              child: Text('No articles saved'),
            ),
          );
        }

        return Scaffold(
          appBar: AppBar(
            title: const Text('Favorites'),
          ),
          body: Center(
            child: ListView.builder(
              itemCount: articles.length,
              itemBuilder: (context, index) {
                final article = articles[index];
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    elevation: 2,
                    child: ListTile(
                      title: Text(
                        article.name,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      trailing: FloatingActionButton(
                        onPressed: () async => {
                          await localSource.deleteArticle(article).then(
                                (value) => ScaffoldMessenger.of(context)
                                .showSnackBar(
                              const SnackBar(
                                content: Text('Article deleted'),
                              ),
                            ),
                          ).whenComplete(() => setState(() {
                              articles.remove(article);
                            })
                          )
                        },
                        child: const Icon(Icons.delete),
                      ),
                      subtitle: Text(
                        article.description,
                      ),
                      onTap: () => {
                        showModalBottomSheet(context: context, builder: (BuildContext context) {
                          return Column(
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
                          );
                        })
                      },
                    ),
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }
}

