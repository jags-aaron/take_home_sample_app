import 'package:sqflite/sqflite.dart';

import '../../common_platform/i_platform_client.dart';
import '../../domain/entity/article_entity.dart';
import '../model/top_headlines_response_model.dart';

abstract class TopHeadlinesLocalSource {
  Future<void> saveArticle(TopHeadlineSourceEntity article);
  Future<void> deleteArticle(TopHeadlineSourceEntity article);
  Future<List<TopHeadlineSourceEntity>> getArticles();
}

class TopHeadlinesLocalSourceImp implements TopHeadlinesLocalSource {
  TopHeadlinesLocalSourceImp({
    required this.platformClient,
  });

  final IPlatformClient platformClient;

  @override
  Future<void> saveArticle(TopHeadlineSourceEntity article) async {
    final db = await platformClient.dbSQL;
    await db.insert(
      'news',
      article.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  @override
  Future<List<TopHeadlineSourceEntity>> getArticles() async {
    final db = await platformClient.dbSQL;

    final List<Map<String, dynamic>> maps = await db.query('news');

    return List.generate(maps.length, (i) {
      return TopHeadlineSourceEntity(
        id: maps[i]['id'],
        name: maps[i]['name'],
        description: maps[i]['description'],
        link: maps[i]['link'],
        category: maps[i]['category'],
        language: maps[i]['language'],
        country: maps[i]['country'],
      );
    });
  }

  @override
  Future<void> deleteArticle(TopHeadlineSourceEntity article) async {
    final db = await platformClient.dbSQL;
    await db.delete(
      'news',
      where: 'id = ?',
      whereArgs: [article.id],
    );
  }
}
