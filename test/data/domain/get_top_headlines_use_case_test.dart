import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:take_home_sample_app/data/model/top_headlines_response_model.dart';
import 'package:take_home_sample_app/data/repository/top_headlines_repository.dart';
import 'package:take_home_sample_app/domain/use_case/get_saved_articles_use_case.dart';
import 'package:take_home_sample_app/domain/use_case/get_top_headlines_use_case.dart';

import '../fixtures/fixture_reader.dart';

class MockRepository extends Mock implements TopHeadlinesRepository {}

void main() {
  late GetTopHeadlinesUseCase useCase;
  late MockRepository repository;

  final mockResponse = fixture('positive_response.json');
  final articles = TopHeadlinesResponseModel.fromJson(
    jsonDecode(
      mockResponse,
    ),
  ).articles;

  setUp(() {
    repository = MockRepository();
    useCase = GetTopHeadlinesUseCase(repository: repository);
  });

  final globalException = Exception('Failed to make request to endpoint');

  test('Should return expected result when repository makes success request',
      () async {
    when(() => repository.getAllTopHeadlinesSources())
        .thenAnswer((_) => Future.value(articles));

    expect(await useCase.call(), articles);
  });

  test('Should return an exception when repository fail to make a request', () {
    when(() => repository.getAllTopHeadlinesSources())
        .thenThrow(globalException);

    expect(() => useCase.call(), throwsException);
  });
}
