import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class Logging extends Interceptor {
  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    if (kDebugMode) {
      print(
      'ERROR[${err.response?.statusCode}] => PATH: ${err.requestOptions.path}',
    );
      print('ERROR MESSAGE: ${err.message}');
    }
    return super.onError(err, handler);
  }
}