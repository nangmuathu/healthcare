import 'dart:io';

import 'package:flutter/material.dart';
import 'package:weup_basic/common/core/page_manager/app_navigator.dart';
import 'package:weup_basic/common/core/sys/api_response.dart';
import 'package:weup_basic/common/helper/app_common.dart';
import 'package:weup_basic/common/resource/app_resource.dart';

import '../widget/dialog/error_dialog_comp.dart';

abstract class BaseViewModel extends ChangeNotifier {
  bool _mounted = false;

  bool get mounted => _mounted;

  Status _status = Status.loading;

  RouteSettings? _settings;

  final AppNavigator? _appNavigator = AppNavigator();

  BuildContext get context => appNavigator.context;

  /*
  * [AppNavigator] thực hiện các navigation bên trong ViewModel
  * */
  AppNavigator get appNavigator => _appNavigator!;

  /*
  * Trạng thái của view
  * */
  Status get status => _status;

  // BuildContext get context => _context!;

  /*
  * Route hiện tại
  * */
  String? get currentRoute => _settings?.name?.split('?').firstOrNull;

  /*
  * Route kèm parameter
  * */
  String? get originalRoute => _settings?.name;

  @Deprecated(
      'Sử dụng [getConnection({Function? reconnect})] thay vì [isConnecting], '
      'trường này không hỗ trợ thực hiện lại request khi mất kết nối')
  Future<bool> get isConnecting async => await getConnection();

  /*
  * Arguments từ page trước
  * */
  dynamic getArguments() => _settings?.arguments;

  /*
  * Parameter từ page trước
  * */
  Map<String, dynamic>? getParameter() =>
      Uri.tryParse(originalRoute ?? '')?.queryParameters;

  /*
  * Hàm được chạy đầu tiên ngay sau khi chuyển page
  * */
  void init() async => null;

  /*
  * Hàm được chạy đầu tiên ngay sau khi chuyển page
  * */
  Future<void> initialData() async => await fetchData();

  /*
  * Hàm dùng để call api ngay sau khi [initialData] được
  * sử dụng khi [initialData] có [supper]
  * */
  @mustCallSuper
  Future<void> fetchData() async {
    if (checkConnect()) {
      if (await getConnection(reconnect: fetchData)) return;
    }
  }

  /*
  * Hàm được chạy khi page đã hoàn tất tất cả frame
  *
  * Hàm được recommend thực thi liên quan đến navigation:
  * dialog, push page, buttonsheet,...
  * */
  @mustCallSuper
  void onViewCreated() => _mounted = true;

  void setMounted(bool mounted) {}

  /*
  * Hỗ trợ nhanh delay một khoảng thời gian,
  * thường được sử dụng trong môi trường dev
  * */
  Future<void> delay(int millis) async =>
      await Future.delayed(Duration(milliseconds: millis));

  /*
  * Kiểm tra connect internet, thường được kiểm tra 1 lần trước
  * khi thực hiện các request
  * */
  Future<bool> getConnection({Function? reconnect}) async {
    try {
      final result = await InternetAddress.lookup('google.com');
      return !(result.isNotEmpty && result[0].rawAddress.isNotEmpty);
    } on SocketException catch (_) {
      appNavigator.dialog(BaseErrorDialog(
        content: HttpConstant.connectError,
        textButtonConfirm: 'Thử lại',
        mConfirm: () {
          setStatus(Status.loading);
          reconnect ?? appNavigator.back();
        },
        mCancel: appNavigator.back,
      ));
      setStatus(Status.error);

      return true;
    }
  }

  /*
  * Thay đổi lại trạng thái của giao diện
  * */
  void setStatus(Status s, {bool hasDelay = false}) async {
    if (hasDelay) await delay(200);
    _status = s;
    update();
  }

  void setRouteSetting(RouteSettings? rs) => _settings = rs;

  /*
  * Lấy ra context và argument, phục vụ navigation, [getArgument]
  *
  * Không cần đến context trong [ViewModel]
  * */
  void setBuildContext(BuildContext? ctx) {
    // _context = ctx;

    _appNavigator?.setBuildContext(ctx);
    _mounted = true;
    // setRouteSetting(ModalRoute.of(ctx!)?.settings);
  }

  /*
  * Khi thực thi xong một request, [checkNull] nên được gọi
  * để có thể kiểm tra có dữ liệu hay thành công hay không
  * */
  bool checkNull(ApiResponse? value,
      {bool isInitial = true, bool showError = true}) {
    if (value?.data != null) return false;

    setStatus(isInitial ? Status.errorInit : Status.error);

    if (showError) setErrorMessage(value?.message);

    return true;
  }

  Status checkStatus(ApiResponse value) =>
      value.code == 200 ? Status.success : Status.error;

  /*
  * Thực hiện show dialog khi có lỗi xảy ra
  * */
  void setErrorMessage(dynamic msg) =>
      ViewUtils.toast(msg, mode: ToastMode.error);

  /*
  * Luôn sử dụng update để thông báo thay đổi dữ liệu. [update] sẽ an toàn hơn [notifyListeners]
  *
  * Không sử dụng thuần [notifyListeners]
  * */

  void update() {
    if (_mounted) notifyListeners();
  }

  @mustCallSuper
  bool checkConnect([bool input = true]) => input;

  @mustCallSuper
  void onDispose() {
    // _appNavigator = null;
  }
}
