// import 'package:flutter/material.dart';
//
// import 'package:rxdart/rxdart.dart';
// import 'package:weup_basic/app/app_lib.dart';
//
// import '../../../app/app_utils.dart';
// import '../../resource/enum_resource.dart';
// import '../sys/api_response.dart';
// import '../sys/base_refresh_controller.dart';
// import '../sys/base_view_model.dart';
// import '../sys/list_response.dart';
// import '../widget/loading_comp.dart';
// import '../widget/no_data_comp.dart';
//
// abstract class BaseListViewModel<T> extends BaseViewModel {
//   List<T> items = [];
//
//   bool _firstLoad = true;
//
//   bool get firstLoad => _firstLoad;
//
//   bool _searching = false;
//
//   bool get searching => _searching;
//
//   PublishSubject<String>? _searchKeyword;
//
//   PublishSubject? get searchKeyword => _searchKeyword;
//
//   BaseRefreshController? refreshController;
//
//   List<T> _temps = [];
//
//   Future<ApiResponse<ListResponse<List<T>>>> apiLoad([String? keyword]);
//
//   TextEditingController? textEditingController;
//
//   String _keyword = '';
//
//   String get keyword => _keyword;
//
//   void setKeyword(String input) => _keyword = input;
//
//   @override
//   void init() {
//     textEditingController = TextEditingController();
//     refreshController = BaseRefreshController(callData: selectAll);
//     super.init();
//   }
//
//   @override
//   Future<void> fetchData() async {
//     setStatus(Status.loading);
//     await selectAll();
//     setStatus(Status.success);
//     return super.fetchData();
//   }
//
//   Future<void> selectAll([String? inputKeyword]) async {
//     _searching = false;
//     final response = await apiLoad(inputKeyword);
//     if (checkData(response)) {
//       items = [];
//       setStatus(Status.error);
//       return;
//     }
//     final _items = response.data?.items ?? [];
//     if (_firstLoad) {
//       _temps = _items;
//       _firstLoad = false;
//     }
//     // refreshController?.setEndPoint(_items.length < (app.config.limit ?? AppConstant.LIMIT));
//     refreshController?.setEndPoint(_items.length < (appLib.config.limit ?? 10));
//     if (refreshController!.isRefreshing) {
//       if (!empty(_keyword)) return;
//       _keyword = '';
//       items = _temps;
//       update();
//       return;
//     }
//     if (empty(_items)) {
//       if (refreshController?.pageIndex != 1) return;
//       items.clear();
//       update();
//       return;
//     } else {
//       if (_items.length != items.length && !empty(_keyword)) {
//         items = _items;
//         update();
//         return;
//       }
//     }
//     items.addAll(_items);
//     update();
//   }
//
//   void cancelSearch() {
//     _searching = false;
//     update();
//   }
//
//   @protected
//   bool checkData(ApiResponse response) => response.data == null || response.code != 200;
//
//   void searchByKeyword({String? value, bool now = false}) async {
//     _firstLoad = false;
//     _searching = true;
//     if (!now) {
//       if (_searchKeyword == null) {
//         _searchKeyword = PublishSubject<String>();
//         _searchKeyword!.debounceTime(const Duration(milliseconds: 1200)).listen((keyword) async {
//           await selectAll(keyword);
//           _searching = false;
//           update();
//         });
//       } else {
//         _searchKeyword!.add(value!);
//         _keyword = value;
//       }
//     } else {
//       await selectAll(value);
//       _searching = false;
//       update();
//     }
//     update();
//   }
//
//   void search() {}
//
//   @override
//   void onDispose() {
//     if (mounted) _firstLoad = true;
//     _searchKeyword?.close();
//     refreshController?.dispose();
//     textEditingController?.dispose();
//     super.onDispose();
//   }
// }
//
// class BaseListItem<T> extends StatelessWidget {
//   final bool searching;
//   final Widget child;
//   final List<T> items;
//   final bool firstLoad;
//
//   const BaseListItem({Key? key, required this.searching, required this.child, this.items = const [], required this.firstLoad}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     if (searching || firstLoad) {
//       return const LoadingComp(backgroundColor: Colors.white);
//     }
//     if (!searching && items.isEmpty) return const NoDataComp();
//     return child;
//   }
// }
