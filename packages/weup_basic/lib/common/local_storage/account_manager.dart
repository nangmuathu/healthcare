// import 'package:flutter/cupertino.dart';
// import 'package:odoo/common/local_storage/app_storage.dart';
// import 'package:odoo/model/user_info_model.dart';
//
// class AccountManager {
//   static final AccountManager _instance = AccountManager._internal();
//
//   factory AccountManager() => _instance;
//
//   AccountManager._internal();
//
//   UserInfoModel _data = UserInfoModel();
//
//   UserInfoModel get data => _data;
//
//   void setUser(UserInfoModel inputModel) {
//     _data = inputModel;
//   }
//
//   Future<void> put(dynamic input) async {
//     if (input == null) return;
//     UserInfoModel model = input as UserInfoModel;
//     await LocalStorage.put(StorageKey.ACCOUNT, model.toJson());
//     await LocalStorage.put(StorageKey.TYPE_USER, 'USER');
//     setUser(model);
//   }
//
//   Map<String, dynamic> get() {
//     if (!isExist()) return {};
//     return LocalStorage.get(StorageKey.ACCOUNT);
//   }
//
//   UserInfoModel getModel() {
//     if (!isExist()) return UserInfoModel.empty();
//     return UserInfoModel.fromJson(get());
//   }
//
//   void setModel(UserInfoModel model) async {
//     setUser(model);
//     await LocalStorage.put(StorageKey.ACCOUNT, model.toJson());
//   }
//
//   bool isExist() => LocalStorage.isExist(StorageKey.ACCOUNT);
//
//   Future<void> clear() async {
//     if (!isExist()) return;
//     await LocalStorage.delete(StorageKey.ACCOUNT);
//   }
//
//   ValueNotifier<UserInfoModel> reactive() => ValueNotifier<UserInfoModel>(!isExist() ? UserInfoModel.empty() : getModel());
// }
