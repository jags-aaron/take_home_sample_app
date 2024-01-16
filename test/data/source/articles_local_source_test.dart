import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:take_home_sample_app/common_platform/i_platform_client.dart';
import 'package:take_home_sample_app/common_platform/mobile_platform_client.dart';
import 'package:take_home_sample_app/data/model/top_headlines_response_model.dart';
import 'package:take_home_sample_app/data/source/top_headlines_local_source_imp.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import '../fixtures/fixture_reader.dart';

class PlatformClientMock extends Mock implements IPlatformClient {}

Future main() async {
  late Database database;
  late IPlatformClient platformClient;
  late TopHeadlinesLocalSourceImp source;
  final mockResponse = fixture('positive_response.json');
  final article = TopHeadlinesResponseModel.fromJson(
    jsonDecode(
      mockResponse,
    ),
  ).articles;

  setUpAll(() async {
    sqfliteFfiInit();
    database = await databaseFactoryFfi.openDatabase(inMemoryDatabasePath);
    await database.execute(databaseRules);
    platformClient = PlatformClientMock();
    source = TopHeadlinesLocalSourceImp(
      platformClient: platformClient,
    );
    when(() => platformClient.dbSQL).thenAnswer((_) async => database);
  });

  group('Database Test', () {

    test('sqflite version', () async {
      expect(await database.getVersion(), 0);
    });

    test('add Item to database', () async {
      source.saveArticle(
        article.first
      );
      var p = database.query("news");
      expect(p, completes);
    });

    test('Delete Item from database', () async {
      source.saveArticle(
          article.first
      );

      await Future.delayed(const Duration(milliseconds: 250), (){});

      var p = await database.query("news");
      expect(p.length, 1);

      source.deleteArticle(
          article.first
      );

      await Future.delayed(const Duration(milliseconds: 250), (){});

      var p2 = await database.query("news");
      expect(p2.length, 0);
    });

    test('Get all Items from database', () async {

      source.saveArticle(
          article.first
      );

      source.saveArticle(
          article.last
      );

      await Future.delayed(const Duration(milliseconds: 250), (){});

      var p = await source.getArticles();
      expect(p.length, 2);
    });

  });
}
