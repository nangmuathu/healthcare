import 'dio_lib.dart';

abstract class $_BaseAPI {
  Future<dynamic> call(String url,
      {required ApiMethod method,
      Map? params,
      Duration? cacheTime,
      Duration? maxStale,
      DioOptions? options,
      bool forceRefresh = true,
      bool isRetry = false});
}

abstract class BaseRestApi extends $_BaseAPI {}
