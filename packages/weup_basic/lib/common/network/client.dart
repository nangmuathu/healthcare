import 'package:weup_basic/common/core/sys/base_function.dart';
import 'package:weup_basic/common/helper/system_utils.dart';
import 'package:weup_basic/common/local_storage/app_storage.dart';
import 'package:weup_basic/common/network/service.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class Client {
  static const int _timeout = 30000;
  static Dio? _dio;

  static Service getClient() => Service(_configDio());

  // static Service getClientSendOTP() => Service(_configDio(ConfigHelper().getModel().apiImage));

  static Dio _configDio([String? domain]) {
    String? userId = LocalStorage.get(StorageKey.USER_ID);
    String? token = LocalStorage.get(StorageKey.ACCESS_TOKEN);
    _dio = Dio(
      BaseOptions(
        baseUrl: '',
        connectTimeout: _timeout,
        receiveTimeout: _timeout,
        headers: {
          if (!empty(userId)) 'id': userId,
          if (!empty(token)) 'token': token,
        },
        contentType: Headers.jsonContentType,
      ),
    );

    _dio?.interceptors.add(InterceptorsWrapper(
        onRequest: _onRequestCache,
        onResponse: _onResponseCache,
        onError: _onErrorCache));
    if (kDebugMode) {
      _dio?.interceptors.add(PrettyDioLogger(
          logPrint: _logPrint,
          requestHeader: true,
          requestBody: true,
          responseBody: true,
          responseHeader: true,
          error: true,
          compact: true));
    }
    return _dio!;
  }

  static Dio? getDio([String? domain]) => _configDio(domain);

  static void _logPrint(v) {
    showDioLog(v);
  }

  static void _onRequestCache(
      RequestOptions options, RequestInterceptorHandler handler) async {
    handler.next(options);
  }

  static void _onResponseCache(
      Response response, ResponseInterceptorHandler handler) {
    _dio = null;
    handler.next(response);
  }

  static void _onErrorCache(DioError error, ErrorInterceptorHandler handler) {
    _dio = null;
    handler.next(error);
  }
}
