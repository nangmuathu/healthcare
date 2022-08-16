import 'package:weup_basic/common/core/sys/base_function.dart';
import 'package:flutter/cupertino.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class BaseRefreshController {
  RefreshController? _controller;
  Function? callData;
  late int _pageIndex;
  bool? _isRefreshing;
  bool? _endPoint;

  BaseRefreshController(
      {RefreshController? controller,
      required this.callData,
      int? pageIndex,
      bool? isRefreshing,
      bool? endPoint}) {
    controller == null
        ? _controller = RefreshController()
        : _controller = controller;
    isRefreshing == null ? _isRefreshing = false : _isRefreshing = isRefreshing;
    pageIndex == null ? _pageIndex = 1 : _pageIndex = pageIndex;
    endPoint == null ? _endPoint = false : _endPoint = endPoint;
  }

  Future refreshData() async {
    showLog('Refresh data');
    _pageIndex = 1;
    _isRefreshing = true;
    _endPoint = false;
    await callData?.call();
    refreshed();
  }

  void refreshed() {
    if (_controller != null) {
      _controller?.resetNoData();
      _controller?.refreshCompleted();
    }
  }

  Future loadMoreData() async {
    showLog('Load more data');
    _isRefreshing = false;
    _pageIndex += 1;
    await callData?.call();
    _controller?.loadComplete();
    if (_endPoint == true) {
      _controller?.loadNoData();
    }
  }

  bool get isRefreshing => _isRefreshing!;

  bool get getEndPoint => _endPoint!;

  RefreshController get controller => _controller!;

  int get pageIndex => _pageIndex;

  void setEndPoint(bool b) => _endPoint = b;

  void setPageIndex(int i) => _pageIndex = i;

  void setFunction(Function f) => callData = f;

  void setController(RefreshController rc) => _controller = rc;

  @mustCallSuper
  dispose() {
    controller.dispose();
  }
}
