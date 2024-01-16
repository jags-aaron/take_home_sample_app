import '../../domain/entity/article_entity.dart';
import 'package:uuid/uuid.dart';

class ArticlesResponseModel {
  List<ArticleModel> articles;

  ArticlesResponseModel({
    required this.articles,
  });

  factory ArticlesResponseModel.fromJson(Map<String, dynamic> json) {
    return ArticlesResponseModel(
      articles: (json['articles'] as List)
          .map((i) => ArticleModel.fromJson(i))
          .toList(),
    );
  }
}

class ArticleModel extends ArticleEntity {
  const ArticleModel({
    required super.uid,
    required super.content,
    required super.publishedAt,
    required super.image,
    required super.link,
    required super.description,
    required super.title,
    required super.author,
    required super.source,
  });

  factory ArticleModel.fromJson(Map<String, dynamic> json) {
    return ArticleModel(
      uid: const Uuid().v4(),
      content: json['content'],
      publishedAt: json['publishedAt'],
      image: json['urlToImage'],
      link: json['url'],
      description: json['description'],
      title: json['title'],
      author: json['author'],
      source: json['source']['id'],
    );
  }
}
