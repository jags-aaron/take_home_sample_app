import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:take_home_sample_app/common_platform/dio/exceptions.dart';
import 'package:take_home_sample_app/common_platform/i_platform_client.dart';
import 'package:take_home_sample_app/data/source/articles_remote_source.dart';

import '../fixtures/fixture_reader.dart';

class PlatformClientMock extends Mock implements IPlatformClient {}

class FakeUriGenerator extends Fake implements Uri {}

class DioMock extends Mock implements Dio {}

void main() {
  late IPlatformClient platformClient;
  late ArticlesRemoteSource remoteSource;

  final dioMock = DioMock();

  setUpAll(() {
    registerFallbackValue(FakeUriGenerator());
  });

  setUp(() {
    platformClient = PlatformClientMock();
    when(() => platformClient.dioClient).thenAnswer((_) => dioMock);

    remoteSource = ArticlesRemoteSourceImp(
      platformClient: platformClient,
    );
  });

  group('getArticlesStatus - HTTP status codes', () {
    test(
      '200',
      () async {
        final mockResponse = fixture('positive_response.json');

        when(() => dioMock.get(any())).thenAnswer(
          (_) async => Response(
            data: jsonDecode(mockResponse),
            requestOptions: RequestOptions(path: 'fizz'),
            statusCode: 200,
          ),
        );

        final response = await remoteSource.getArticles('foo');

        expect(response.length, 4);
        expect(response.last.title,
            "Apple is selling its contested Watch models again after import ban pause");
      },
    );

    test(
      '400',
      () async {
        when(() => dioMock.get(any())).thenAnswer(
          (_) async => Response(
            data: {},
            requestOptions: RequestOptions(path: 'fizz'),
            statusCode: 400,
          ),
        );

        final call = remoteSource.getArticles;

        expect(() => call('foo'),
            throwsA(const TypeMatcher<BadRequestException>()));
      },
    );

    test(
      '401',
      () async {
        when(() => dioMock.get(any())).thenAnswer(
          (_) async => Response(
            data: {},
            requestOptions: RequestOptions(path: 'fizz'),
            statusCode: 401,
          ),
        );

        final call = remoteSource.getArticles;

        expect(() => call('foo'),
            throwsA(const TypeMatcher<UnauthorizedException>()));
      },
    );

    test(
      '429',
      () async {
        when(() => dioMock.get(any())).thenAnswer(
          (_) async => Response(
            data: {},
            requestOptions: RequestOptions(path: 'fizz'),
            statusCode: 429,
          ),
        );

        final call = remoteSource.getArticles;

        expect(() => call('foo'),
            throwsA(const TypeMatcher<TooManyRequestException>()));
      },
    );

    test(
      '500',
      () async {
        when(() => dioMock.get(any())).thenAnswer(
          (_) async => Response(
            data: {},
            requestOptions: RequestOptions(path: 'fizz'),
            statusCode: 500,
          ),
        );

        final call = remoteSource.getArticles;

        expect(
            () => call('foo'), throwsA(const TypeMatcher<ServerException>()));
      },
    );
  });
}
