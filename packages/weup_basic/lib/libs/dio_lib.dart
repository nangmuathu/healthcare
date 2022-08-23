import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio_http_cache/dio_http_cache.dart';
import 'package:flutter/foundation.dart';
import 'package:weup_basic/global.dart';

import '../app/app_utils.dart';
import '../common/core/sys/base_function.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

enum ApiMethod { get, post }

const Duration defaultCacheTime = Duration(days: 7);

bool dioCacheSupport() => (Platform.isIOS || Platform.isAndroid || Platform.isMacOS);

const String applicationJson = "application/json";
const String contentType = "content-type";
const String accept = "accept";
const String id = 'id';
const String token = 'token';

class DioHelper {
  static Dio? _dio;

  static DioCacheManager? _manager;

  static DioCacheManager? getCacheManager() => _manager ??= DioCacheManager(CacheConfig());

  static Dio? getDio() {
    Map<String, String> headers = {contentType: applicationJson, accept: accept};

    _dio = Dio(BaseOptions(
      connectTimeout: 30000,
      receiveTimeout: 30000,
      responseType: ResponseType.json,
      headers: headers,
    ))..interceptors.addAll([
      if(kDebugMode) ...[
        getCacheManager()!.interceptor,
        PrettyDioLogger(logPrint: _logPrint, requestHeader: true, requestBody: true, responseBody: true, responseHeader: true, error: true, compact: true),
      ],
    ]);
    return _dio;
  }

  static void _logPrint(v) {
    showDioLog(v);
  }

  static void reset() {
    _dio?.close(force: false);
    _dio = null;
  }

  void clearCaching(String input) {
    if (!dioCacheSupport()) return;
    final url = siteApp.domain + input;

    _manager?.deleteByPrimaryKey(url);
  }

  void clearCachingAll() {
    if (!dioCacheSupport()) return;
    _manager?.clearAll();
  }
}

Future<Map<String, dynamic>> call(
  String url, {
  required ApiMethod method,
  Map? params,
  Duration? cacheTime,
  Duration? maxStale,
  DioOptions? options,
  bool forceRefresh = true,
  bool isRetry = false,
}) async {
  if (empty(url)) return {};
  final _url = siteApp.domain + url;
  Map<String, dynamic> _params = {};
  if (params != null) _params.addAll(Map<String, dynamic>.from(params));

  final response = await _handleApi(_url,
      method: method, options: options, forceRefresh: forceRefresh, maxStale: maxStale, params: _params, isRetry: isRetry, cacheTime: cacheTime);
  if (empty(response)) {
    return {};
  }
  final _response = (response is String) ? response.trim() : response;
  if (_response is String) {
    final _data = jsonDecode(_response);
    return _data;
  }
  return _response;
}

Future<dynamic> _handleApi(String url,
    {Map<String, dynamic>? params,
    required ApiMethod method,
    Duration? cacheTime,
    Duration? maxStale,
    DioOptions? options,
    bool isRetry = false,
    bool? forceRefresh}) async {
  final _dio = DioHelper.getDio();
  final _params = params ?? {};

  try {
    if (url.startsWith('http')) {
      var retryCount = 1;
      bool flag = true;
      while (flag) {
        if (retryCount >= 5) flag = false;
        FormData _formData = FormData.fromMap(_params);
        Response _res;
        if (method == ApiMethod.get) {
          _res = await _dio!.get(url,
              queryParameters: _params,
              options: (cacheTime != null)
                  ? buildCacheOptions(cacheTime,
                      primaryKey: url,
                      subKey: json.encode(_params),
                      maxStale: maxStale ?? const Duration(days: 30),
                      options: _convertOption(options),
                      forceRefresh: forceRefresh ?? true)
                  : null);
        } else {
          _res = await _dio!.post(url,
              data: _formData,
              options: (cacheTime != null)
                  ? buildCacheOptions(cacheTime,
                      primaryKey: url,
                      subKey: json.encode(_params),
                      maxStale: maxStale ?? const Duration(days: 30),
                      options: _convertOption(options),
                      forceRefresh: forceRefresh ?? true)
                  : null);
        }
        if (_res.statusCode == 200 && (!isRetry || !empty(_res.data))) {
          return _res.data;
        } else if (isRetry && retryCount++ < 5 && (_res.statusCode != 200 || _res.data == '')) {
          if (_res.statusCode == 302 && url.startsWith(siteApp.domain)) {
            DioHelper.reset();
            await Future.delayed(const Duration(seconds: 1));
            return await _handleApi(url,
                params: params, cacheTime: cacheTime, maxStale: maxStale, options: options, isRetry: false, method: method, forceRefresh: forceRefresh);
          }
          await Future.delayed(const Duration(seconds: 3));
        } else {
          break;
        }
      }
    } else {
      return;
    }
  } catch (e) {
    if (isRetry) {
      DioHelper.reset();
      await Future.delayed(const Duration(seconds: 2));
      return await _handleApi(url,
          params: params, cacheTime: cacheTime, maxStale: maxStale, options: options, isRetry: false, method: method, forceRefresh: forceRefresh);
    }
  }
}

class DioOptions {
  final String? method;
  final int? sendTimeout;
  final int? receiveTimeout;
  final Map<String, dynamic>? extra;
  final Map<String, dynamic>? headers;
  final ResponseType? responseType;
  final String? contentType;
  final ValidateStatus? validateStatus;
  final bool? receiveDataWhenStatusError;
  final bool? followRedirects;
  final int? maxRedirects;
  final RequestEncoder? requestEncoder;
  final ResponseDecoder? responseDecoder;
  final ListFormat? listFormat;

  const DioOptions(
      {this.method,
      this.sendTimeout,
      this.receiveTimeout,
      this.extra,
      this.headers,
      this.responseType,
      this.contentType,
      this.validateStatus,
      this.receiveDataWhenStatusError,
      this.followRedirects,
      this.maxRedirects,
      this.requestEncoder,
      this.responseDecoder,
      this.listFormat});
}

Options? _convertOption([DioOptions? options]) {
  if (options is DioOptions) {
    return Options(
      method: options.method,
      sendTimeout: options.sendTimeout,
      receiveTimeout: options.receiveTimeout,
      extra: options.extra,
      headers: options.headers,
      responseType: options.responseType,
      contentType: options.contentType,
      validateStatus: options.validateStatus,
      receiveDataWhenStatusError: options.receiveDataWhenStatusError,
      followRedirects: options.followRedirects,
      maxRedirects: options.maxRedirects,
      requestEncoder: options.requestEncoder,
      responseDecoder: options.responseDecoder,
      listFormat: options.listFormat,
    );
  }
  return null;
}
