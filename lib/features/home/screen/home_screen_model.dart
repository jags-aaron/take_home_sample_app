import 'package:equatable/equatable.dart';
import 'package:take_home_sample_app/domain/entity/article_entity.dart';

class HomeScreenModel extends Equatable {
  const HomeScreenModel._({
    required this.title,
    required this.articles,
    required this.articlesPressed,
  });

  factory HomeScreenModel.build({
    required String title,
    required List<TopHeadlineSourceEntity> articles,
    required Function(TopHeadlineSourceEntity) articlePressed,
  }) {
    return HomeScreenModel._(
      title: title,
      articles: articles,
      articlesPressed: articlePressed,
    );
  }

  final String title;
  final List<TopHeadlineSourceEntity> articles;
  final Function(TopHeadlineSourceEntity) articlesPressed;

  @override
  List<Object?> get props => [
        title,
        articles,
        articlesPressed,
      ];
}
