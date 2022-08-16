import 'package:flutter/cupertino.dart';
import 'package:weup_basic/model/config_model.dart';

AppLib appLib = AppLib();

class AppLib extends ChangeNotifier {
  AppLib() {
    _init();
  }

  final ConfigModel _configModel = ConfigModel();

  ConfigModel get config => _configModel;

  void _init() {}
}
