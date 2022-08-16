// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

import 'package:hive_flutter/hive_flutter.dart';

class LocalStorage {
  static const String boxName = 'local.data';
  static const String cache = 'network_cache.data';

  static Box box = Hive.box(boxName);
  static Box boxCache = Hive.box(cache);

  static Future<void> ensureInitialized() async {
    await Hive.initFlutter();
    await Hive.openBox(boxName);
    await Hive.openBox(cache);
  }

  static Future<void> put(String key, dynamic value) async {
    switch (value) {
      case String:
      case double:
      case bool:
      case int:
        await box.put(key, value);
        break;
      default:
        await box.put(key, jsonEncode(value));
        break;
    }
  }

  static dynamic get(String key, [dynamic defaultValue]) {
    if (!isExist(key)) return defaultValue;

    switch (defaultValue) {
      case String:
      case double:
      case bool:
      case int:
        return box.get(key, defaultValue: defaultValue);
      default:
        return jsonDecode(box.get(key));
    }
  }

  static bool isExist(String key) => box.containsKey(key);

  static Future<void> delete(String key) async {
    if (!isExist(key)) return;
    await box.delete(key);
  }

  static Future<void> clearData() async {
    final Box box = Hive.box(boxName);
    await box.deleteFromDisk();
  }
}

class StorageKey {
  StorageKey._();
  static String MESSAGE_CREATE_SUCCESSFUL_ACCOUNT = 'message_create_successful_account_${LocalStorage.get(USER_ID)}';
  static String POPUP_UPDATE_USER = 'popup_update_user_${LocalStorage.get(USER_ID)}';
  static const String THEME = 'theme';
  static const String INTRODUCE = 'introduce';
  static const String ACCESS_TOKEN = 'access_token';
  static const String USER_ID = 'user_id';
  static const String SELECT_TOPIC = 'select_topic';
  static const String CONFIG = 'config';
  static const String TYPE_USER = 'TYPE_USER';
  static const String KEY_PHYSICIAN_ID = 'key_physician_id';
  static const String LIST_POP_UP = 'list_pop_up';
  static const String ACCOUNT = 'account';
  static const String LOGIN_PHONE = 'login_phone';
}
