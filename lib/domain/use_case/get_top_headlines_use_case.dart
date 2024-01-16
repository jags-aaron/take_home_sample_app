import '../../data/repository/top_headlines_repository.dart';
import '../entity/article_entity.dart';

class GetTopHeadlinesUseCase {
  GetTopHeadlinesUseCase({required this.repository});

  final TopHeadlinesRepository repository;

  Future<List<TopHeadlineSourceEntity>> call() {
    return repository.getAllTopHeadlinesSources();
  }
}
