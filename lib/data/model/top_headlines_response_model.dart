import '../../domain/entity/article_entity.dart';
import 'package:uuid/uuid.dart';

class TopHeadlinesResponseModel {
  List<TopHeadlineSourceModel> articles;

  TopHeadlinesResponseModel({
    required this.articles,
  });

  factory TopHeadlinesResponseModel.fromJson(Map<String, dynamic> json) {
    return TopHeadlinesResponseModel(
      articles: (json['sources'] as List)
          .map((i) => TopHeadlineSourceModel.fromJson(i))
          .toList(),
    );
  }
}

class TopHeadlineSourceModel extends TopHeadlineSourceEntity {
  const TopHeadlineSourceModel({
    required super.id,
    required super.name,
    required super.description,
    required super.link,
    required super.category,
    required super.language,
    required super.country,
  });

  factory TopHeadlineSourceModel.fromJson(Map<String, dynamic> json) {
    return TopHeadlineSourceModel(
      id: json['id'] ?? const Uuid().v4(),
      name: json['name'],
      description: json['description'],
      link: json['url'],
      category: json['category'],
      language: json['language'],
      country: json['country'],
    );
  }
}
