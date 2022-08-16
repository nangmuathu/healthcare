import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../../helper/constant.dart';

class ApiResponse<T> {
  T? data;
  dynamic message;
  int? code;

  ApiResponse({this.data, this.code, this.message});
}

extension FutureExtensions<T> on Future<HttpResponse<T?>> {
  FutureOr<ApiResponse<T>> wrap() async {
    try {
      HttpResponse httpResponse = await this;

      final responseData = httpResponse.response.data;
      String _msg = 'Thành công';
      int _code = 0;

      if (responseData is Map<String, dynamic>) {
        _msg = responseData['message'] ?? '';
        if (responseData['error'] != null) {
          _code = responseData['error'] is String
              ? int.tryParse(responseData['error'].toString())
              : responseData['error'];
        } else {
          _code = httpResponse.response.statusCode ?? 0;
        }
      }
      return Future.value(
          ApiResponse(code: _code, message: _msg, data: httpResponse.data));
    } catch (error) {
      if (error is DioError) {
        switch (error.type) {
          case DioErrorType.response:
            return _okError(error);

          case DioErrorType.sendTimeout:
          case DioErrorType.connectTimeout:
          case DioErrorType.receiveTimeout:
            return Future.value(ApiResponse(
                code: error.response?.statusCode,
                message: HttpConstant.TIME_OUT));

          default:
            return Future.value(ApiResponse(
                code: error.response?.statusCode,
                message: HttpConstant.UNKNOWN));
        }
      }

      return Future.value(ApiResponse(message: HttpConstant.UNKNOWN));
    }
  }

  Future<ApiResponse<T>> _okError(DioError error) {
    int? statusCode = error.response?.statusCode;
    String message = '';
    if (error.response?.data is Map &&
        (error.response?.data as Map).containsKey('message') &&
        error.response?.data['message'] is String) {
      message = error.response?.data['message'];
    } else if (error.response?.data['message'] is Map<String, dynamic>) {
      message = (error.response?.data['message'] as Map<String, dynamic>)
          .values
          .first;
    } else if (error.response?.data['message'] is List<dynamic>) {
      message = (error.response?.data['message'] as List<dynamic>).join(', ');
    }

    // return Future.value(ApiResponse(code: error.response?.statusCode, message: message));
    switch (statusCode) {
      case HttpStatus.forbidden:
        return Future.value(ApiResponse(
            code: error.response?.statusCode, message: HttpConstant.FORBIDDEN));

      case HttpStatus.unauthorized:
        return Future.value(ApiResponse(
            code: error.response?.statusCode,
            message: HttpConstant.TOKEN_EXPIRED));

      case HttpStatus.requestTimeout:
        return Future.value(ApiResponse(
            code: error.response?.statusCode, message: HttpConstant.TIME_OUT));

      case HttpStatus.badGateway:
        return Future.value(ApiResponse(
            code: error.response?.statusCode,
            message: HttpConstant.BAD_GATEWAY));

      case HttpStatus.internalServerError:
        return Future.value(ApiResponse(
            code: error.response?.statusCode,
            message: HttpConstant.INTERNAL_ERROR));

      default:
        return Future.value(
            ApiResponse(code: error.response?.statusCode, message: message));
    }
  }
}
