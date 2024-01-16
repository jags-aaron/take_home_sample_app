import '../../data/model/top_headlines_response_model.dart';
import '../../data/repository/top_headlines_repository.dart';
import '../entity/article_entity.dart';

class SaveArticleUseCase {
  SaveArticleUseCase({required this.repository});

  final TopHeadlinesRepository repository;

  Future<void> call(TopHeadlineSourceEntity article) {
    return repository.saveArticle(article);
  }
}
