import 'package:equatable/equatable.dart';

class ArticleEntity extends Equatable {
  const ArticleEntity({
    required this.uid,
    required this.content,
    required this.publishedAt,
    required this.image,
    required this.link,
    required this.description,
    required this.title,
    required this.author,
    required this.source,
  });

  final String? uid;
  final String? content;
  final String? publishedAt;
  final String? image;
  final String? link;
  final String? description;
  final String? title;
  final String? author;
  final String? source;

  factory ArticleEntity.fromJson(Map<String, dynamic> json) {
    return ArticleEntity(
      uid: json['uid'],
      content: json['content'],
      publishedAt: json['publishedAt'],
      image: json['urlToImage'],
      link: json['url'],
      description: json['description'],
      title: json['title'],
      author: json['author'],
      source: json['source']['name'],
    );
  }

  @override
  List<Object?> get props => [
        uid,
        content,
        publishedAt,
        image,
        link,
        description,
        title,
        author,
        source,
      ];
}
