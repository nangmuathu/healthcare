import 'package:flutter/cupertino.dart';

const vnLocale = Locale('vi');
const enLocale = Locale('en');

class LanguageManager {
  LanguageManager._internal();

  static LanguageManager? _instance;

  factory LanguageManager.instance() =>
      _instance ??= LanguageManager._internal();

  final String assetsPathLocations = 'assets/trans';
}
