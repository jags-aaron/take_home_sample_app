import '../../data/model/top_headlines_response_model.dart';
import '../../data/repository/top_headlines_repository.dart';

class RemoveArticleUseCase {
  RemoveArticleUseCase({required this.repository});

  final TopHeadlinesRepository repository;

  Future<void> call(TopHeadlineSourceModel article) {
    return repository.removeArticle(article);
  }
}
