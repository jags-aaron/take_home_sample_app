import 'package:take_home_sample_app/data/source/top_headlines_remote_source.dart';

import '../../domain/entity/article_entity.dart';
import '../source/top_headlines_local_source_imp.dart';

abstract class TopHeadlinesRepository {
  Future<List<TopHeadlineSourceEntity>> getAllTopHeadlinesSources();
  Future<void> saveArticle(TopHeadlineSourceEntity article);
  Future<void> removeArticle(TopHeadlineSourceEntity article);
  Future<List<TopHeadlineSourceEntity>> getSavedArticles();
}

class TopHeadlinesRepositoryImp implements TopHeadlinesRepository {
  TopHeadlinesRepositoryImp({
    required this.remoteSource,
    required this.localSource,
  });

  final TopHeadlineRemoteSource remoteSource;
  final TopHeadlinesLocalSource localSource;

  @override
  Future<List<TopHeadlineSourceEntity>> getAllTopHeadlinesSources() async {
    return await remoteSource.getAllTopHeadlinesSources();
  }

  @override
  Future<void> removeArticle(TopHeadlineSourceEntity article) async {
    return await localSource.deleteArticle(article);
  }

  @override
  Future<List<TopHeadlineSourceEntity>> getSavedArticles() async {
    return await localSource.getArticles();
  }

  @override
  Future<void> saveArticle(TopHeadlineSourceEntity article) async {
    return await localSource.saveArticle(article);
  }
}