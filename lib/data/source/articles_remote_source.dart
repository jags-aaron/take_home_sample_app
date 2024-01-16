import 'package:dio/dio.dart';

import '../../common_platform/dio/exceptions.dart';
import '../../common_platform/i_platform_client.dart';
import '../model/article_response_model.dart';

abstract class ArticlesRemoteSource {
  Future<List<ArticleModel>> getArticles(String? query);
}

class ArticlesRemoteSourceImp implements ArticlesRemoteSource {

  ArticlesRemoteSourceImp({
    required this.platformClient,
  }): dio = platformClient.dioClient;

  final IPlatformClient platformClient;
  final Dio dio;

  @override
  Future<List<ArticleModel>> getArticles(String? query) async {
    try {
      final response = await dio.get('/everything?q=$query');
      final statusCode = response.statusCode ?? 0;

      switch (statusCode) {
        case >=200 && <300:
          final articles = ArticlesResponseModel.fromJson(response.data);
          return Future.value(articles.articles);
        case 400:
          throw BadRequestException();
        case 401:
          throw UnauthorizedException();
        case 429:
          throw TooManyRequestException();
        default:
          throw ServerException();
      }
    } catch (e) {
      rethrow;
    }
  }

}