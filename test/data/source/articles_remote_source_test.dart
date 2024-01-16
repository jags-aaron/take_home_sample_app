import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:take_home_sample_app/common_platform/dio/exceptions.dart';
import 'package:take_home_sample_app/common_platform/i_platform_client.dart';
import 'package:take_home_sample_app/data/model/top_headlines_response_model.dart';
import 'package:take_home_sample_app/data/source/top_headlines_remote_source.dart';

import '../fixtures/fixture_reader.dart';

class PlatformClientMock extends Mock implements IPlatformClient {}

class FakeUriGenerator extends Fake implements Uri {}

class DioMock extends Mock implements Dio {}

void main() {
  late IPlatformClient platformClient;
  late TopHeadlineRemoteSource remoteSource;

  final dioMock = DioMock();

  setUpAll(() {
    registerFallbackValue(FakeUriGenerator());
  });

  setUp(() {
    platformClient = PlatformClientMock();
    when(() => platformClient.dioClient).thenAnswer((_) => dioMock);

    remoteSource = TopHeadlinesRemoteSourceImp(
      platformClient: platformClient,
    );
  });

  group('getAllTopHeadlinesSourcesStatus - HTTP status codes', () {
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

        final response = await remoteSource.getAllTopHeadlinesSources();

        expect(response, TopHeadlinesResponseModel.fromJson(jsonDecode(mockResponse)).articles);
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

        final call = remoteSource.getAllTopHeadlinesSources;

        expect(() => call(),
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

        final call = remoteSource.getAllTopHeadlinesSources;

        expect(() => call(),
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

        final call = remoteSource.getAllTopHeadlinesSources;

        expect(() => call(),
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

        final call = remoteSource.getAllTopHeadlinesSources;

        expect(
            () => call(), throwsA(const TypeMatcher<ServerException>()));
      },
    );
  });
}
