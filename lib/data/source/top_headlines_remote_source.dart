import 'package:dio/dio.dart';

import '../../common_platform/dio/exceptions.dart';
import '../../common_platform/i_platform_client.dart';
import '../../domain/entity/article_entity.dart';
import '../model/top_headlines_response_model.dart';

typedef StatusCodeCallback = Future<List<TopHeadlineSourceEntity>> Function();

abstract class TopHeadlineRemoteSource {
  Future<List<TopHeadlineSourceEntity>> getAllTopHeadlinesSources();
}

class TopHeadlinesRemoteSourceImp implements TopHeadlineRemoteSource {
  TopHeadlinesRemoteSourceImp({
    required IPlatformClient platformClient,
  }) : dio = platformClient.dioClient;

  final Dio dio;

  @override
  Future<List<TopHeadlineSourceEntity>> getAllTopHeadlinesSources() async {
    try {
      final response = await dio.get('/top-headlines/sources');
      final statusCode = response.statusCode ?? 0;

      return validateStatusCode(
        statusCode,
        () {
          final articles = TopHeadlinesResponseModel.fromJson(response.data);
          return Future.value(articles.articles);
        },
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<List<TopHeadlineSourceEntity>> validateStatusCode(
    int statusCode,
    StatusCodeCallback callback,
  ) {
    switch (statusCode) {
      case >= 200 && < 300:
        return callback();
      case 400:
        throw BadRequestException();
      case 401:
        throw UnauthorizedException();
      case 429:
        throw TooManyRequestException();
      default:
        throw ServerException();
    }
  }
}
