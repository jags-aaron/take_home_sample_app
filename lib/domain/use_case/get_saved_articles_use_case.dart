import 'package:take_home_sample_app/domain/entity/article_entity.dart';

import '../../data/repository/top_headlines_repository.dart';

class GetSavedArticlesUseCase {
  GetSavedArticlesUseCase({required this.repository});

  final TopHeadlinesRepository repository;

  Future<List<TopHeadlineSourceEntity>> call() {
    return repository.getSavedArticles();
  }
}
