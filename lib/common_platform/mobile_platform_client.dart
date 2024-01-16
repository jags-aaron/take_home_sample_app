import 'package:dio/dio.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:http/http.dart' as http;

import 'dio/app_interceptors.dart';
import 'i_platform_client.dart';
import 'dart:async';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

const baseUrlApp = 'https://newsapi.org/v2/';
const databaseRules = 'CREATE TABLE news(id TEXT PRIMARY KEY, name TEXT, description TEXT, link TEXT, category TEXT, language TEXT, country TEXT)';

class MobilePlatformClient extends IPlatformClient {
  @override
  http.Client get httpClient => http.Client();

  @override
  Dio get dioClient => _createDioClient();

  @override
  Future<Database> get dbSQL async => _database();

  Future<Database> _database() async {
    return openDatabase(
      join(await getDatabasesPath(), 'news_database.db'),
      onCreate: (db, version) {
        return db.execute(
          databaseRules,
        );
      },
      version: 1,
    );
  }

  Duration timeout() => const Duration(milliseconds: 5000);

  Dio _createDioClient() {
    final dio = Dio(
      BaseOptions(
        connectTimeout: timeout(),
        receiveTimeout: timeout(),
        baseUrl: baseUrlApp,
      ),
    );
    // dio.interceptors.add(CurlLoggerDioInterceptor(printOnSuccess: true));
    dio.interceptors.add(AppInterceptors());

    final cacheOptions = CacheOptions(
      // A default store is required for interceptor.
      store: MemCacheStore(maxSize: 10485760, maxEntrySize: 1048576),

      // All subsequent fields are optional.

      // Default.
      policy: CachePolicy.forceCache,
      // Returns a cached response on error but for statuses 401 & 403.
      // Also allows to return a cached response on network errors (e.g. offline usage).
      // Defaults to [null].
      hitCacheOnErrorExcept: [401, 403],
      // Overrides any HTTP directive to delete entry past this duration.
      // Useful only when origin server has no cache config or custom behaviour is desired.
      // Defaults to [null].
      maxStale: const Duration(days: 7),
      // Default. Allows 3 cache sets and ease cleanup.
      priority: CachePriority.normal,
      // Default. Body and headers encryption with your own algorithm.
      cipher: null,
      // Default. Key builder to retrieve requests.
      keyBuilder: CacheOptions.defaultCacheKeyBuilder,
      // Default. Allows to cache POST requests.
      // Overriding [keyBuilder] is strongly recommended when [true].
      allowPostMethod: false,
    );
    dio.interceptors.add(DioCacheInterceptor(options: cacheOptions));

    return dio;
  }

  @override
  Dio get unauthenticatedDioClient {
    final dio = Dio(
      BaseOptions(
        connectTimeout: timeout(),
        receiveTimeout: timeout(),
        baseUrl: baseUrlApp,
      ),
    );
    // dio.interceptors.add(CurlLoggerDioInterceptor(printOnSuccess: true));
    return dio;
  }
}
