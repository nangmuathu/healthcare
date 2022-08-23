import 'package:flutter/foundation.dart';

import '../domain/model/config_model.dart';
import '../libs/dio_lib.dart';

AppLib appLib = AppLib();

ConfigModel _parseConfig(Map<String, dynamic> input) {
  return ConfigModel.fromJson(input);
}

class AppLib extends ChangeNotifier {
  AppLib() {
    _init();
  }

  ConfigModel configModel = ConfigModel();

  void _init() async {
    final res = await call('/configs', method: ApiMethod.get, cacheTime: defaultCacheTime);
    configModel = await compute(_parseConfig, res);
    print('configModel.......$configModel');
  }
}
