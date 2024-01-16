import 'package:equatable/equatable.dart';

class TopHeadlineSourceEntity extends Equatable {
  const TopHeadlineSourceEntity({
    required this.id,
    required this.name,
    required this.description,
    required this.link,
    required this.category,
    required this.language,
    required this.country,
  });

  final String id;
  final String name;
  final String description;
  final String link;
  final String category;
  final String language;
  final String country;

  factory TopHeadlineSourceEntity.fromJson(Map<String, dynamic> json) {
    return TopHeadlineSourceEntity(
        id: json['id'],
        name: json['name'],
        description: json['description'],
        link: json['url'],
        category: json['category'],
        language: json['language'],
        country: json['country']);
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'link': link,
      'category': category,
      'language': language,
      'country': country,
    };
  }

  @override
  String toString() {
    return 'Article{id: $id, name: $name, description: $description, link: $link, category: $category, language: $language, country: $country}';
  }

  @override
  List<Object?> get props => [
        id,
        name,
        description,
        link,
        category,
        language,
        country,
      ];
}
