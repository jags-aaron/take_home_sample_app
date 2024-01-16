import 'package:dio/dio.dart';
import 'dart:developer';

class AppInterceptors extends Interceptor {

  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {

    log('[Dio Request] ${options.method} ${options.path} ${options.queryParameters}');

    options.headers['Content-Type'] = 'application/json';
    options.headers['X-Api-Key'] = '32f71fb1591e4a42b8665d2273b8687f';

    super.onRequest(options, handler);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    log('[Dio Error] ${err.message} ${err.response?.data} ${err.response?.statusCode}');
    super.onError(err, handler);
  }
}
