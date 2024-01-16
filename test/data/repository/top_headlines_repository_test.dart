import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:take_home_sample_app/data/model/top_headlines_response_model.dart';
import 'package:take_home_sample_app/data/repository/top_headlines_repository.dart';
import 'package:take_home_sample_app/data/source/top_headlines_local_source_imp.dart';
import 'package:take_home_sample_app/data/source/top_headlines_remote_source.dart';

import '../fixtures/fixture_reader.dart';

class MockRemoteSource extends Mock implements TopHeadlineRemoteSource {}

class MockLocalSource extends Mock implements TopHeadlinesLocalSource {}

void main() {
  late TopHeadlinesRepositoryImp repository;
  late MockRemoteSource remote;
  late MockLocalSource local;
  final mockResponse = fixture('positive_response.json');

  setUp(
    () {
      remote = MockRemoteSource();
      local = MockLocalSource();
      repository = TopHeadlinesRepositoryImp(
        remoteSource: remote,
        localSource: local,
      );
    },
  );

  group(
    'getAllTopHeadlinesSources',
    () {
      test('returns source list when succeeds', () async {
        final responseModel = TopHeadlinesResponseModel.fromJson(
          jsonDecode(
            mockResponse,
          ),
        );

        when(() => remote.getAllTopHeadlinesSources())
            .thenAnswer((_) async => responseModel.articles);

        final actual = await repository.getAllTopHeadlinesSources();

        verify(() => remote.getAllTopHeadlinesSources());
        expect(actual, responseModel.articles);
      });

      test(
        'returns error when Exception',
        () async {
          when(() => remote.getAllTopHeadlinesSources()).thenThrow(Exception());

          final actual = repository.getAllTopHeadlinesSources();
          expect(actual, throwsA(isInstanceOf<Exception>()));
        },
      );
    },
  );

  group(
    'saveArticle',
    () {
      final article = TopHeadlinesResponseModel.fromJson(
        jsonDecode(
          mockResponse,
        ),
      ).articles.first;

      test('complete when succeeds', () async {
        when(() => local.saveArticle(article)).thenAnswer((_) async {});

        final actual = repository.saveArticle(article);

        expect(actual, completes);
      });

      test(
        'returns error when Exception',
        () async {
          when(() => local.saveArticle(article)).thenThrow(Exception());

          final actual = repository.saveArticle(article);
          expect(actual, throwsA(isInstanceOf<Exception>()));
        },
      );
    },
  );

  group(
    'deleteArticle',
    () {
      final article = TopHeadlinesResponseModel.fromJson(
        jsonDecode(
          mockResponse,
        ),
      ).articles.first;

      test('completes when succeeds', () async {
        when(() => local.deleteArticle(article)).thenAnswer((_) async {});

        final actual = repository.removeArticle(article);

        expect(actual, completes);
      });

      test(
        'error when Exception',
        () async {
          when(() => local.deleteArticle(article)).thenThrow(Exception());

          final actual = repository.removeArticle(article);
          expect(actual, throwsA(isInstanceOf<Exception>()));
        },
      );
    },
  );

  group(
    'getArticles',
    () {
      test('get articles when succeeds', () async {

        final articles = TopHeadlinesResponseModel.fromJson(
          jsonDecode(
            mockResponse,
          ),
        ).articles;

        when(() => local.getArticles())
            .thenAnswer((_) async => articles);

        final actual = await repository.getSavedArticles();

        verify(() => local.getArticles());
        expect(actual, articles);
      });

      test(
        'error when Exception',
        () async {
          when(() => local.getArticles()).thenThrow(Exception());

          final actual = repository.getSavedArticles();
          expect(actual, throwsA(isInstanceOf<Exception>()));
        },
      );
    },
  );

}
