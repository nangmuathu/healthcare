
import '../exception/validate_exception.dart';

abstract class BaseUseCase<T> {



  /*
  * Khi thực thi xong một request, [checkNull] nên được gọi
  * để có thể kiểm tra có dữ liệu hay thành công hay không
  * */
  // bool isCodeNotOk(ApiResponse? value) {
  //   return value?.err?.code != CodeConstant.OK;
  // }

  void validate();

  Future<T> invoke();

  void notNull(dynamic data, {String? name}) {
    if (data == null) throw ValidateException('${name ?? runtimeType} must not null');
  }

  void notEmpty(dynamic data, {String? name}) {
    if (data.isEmpty) throw ValidateException('${name ?? runtimeType} must not empty');
  }

  void notNullOrEmpty(dynamic data, {String? name}) {
    notNull(data, name: name);
    notEmpty(data, name: name);
  }

  Future<bool> isNotConnection()async{
    // try {
    //   final result = await InternetAddress.lookup('google.com');
    //   return !(result.isNotEmpty && result[0].rawAddress.isNotEmpty);
    // } on SocketException catch (_) {
    //   return true;
    // }
    return false;
  }
  //
  // BaseUseCase(){
  //   validate();
  // }
}
