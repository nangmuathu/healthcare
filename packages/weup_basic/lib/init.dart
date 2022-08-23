import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:weup_basic/app/app_config.dart';
import 'package:weup_basic/common/core/widget/root_app.dart';
import 'package:weup_basic/setup.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

import 'application.dart';
import 'global.dart';
import 'libs/setting_lib.dart';
import 'app/managers/language_manger.dart';

void initApp({
  required Site site,
  Widget? child,
  Iterable<Locale>? supportedLocales,
  Locale? startLocale,
  List<String>? boxes,
  ThemeMode? themeMode,
  ThemeData? theme,
  ThemeData? darkTheme,
  RouteFactory? onGenerateRoute,
  required String initialRoute,
  Widget? home,
  List<AsyncCallbackFunc>? asyncCallbacks,
  List<AsyncCallbackFunc>? callInMyApps,
  List<VoidCallback>? callbacks,
  List<DeviceOrientation>? orientations,
  final Locale? fallbackLocale,
  List<SingleChildWidget>? providers,
  LoginOption loginOption = LoginOption.none,
}) async {
  WidgetsFlutterBinding.ensureInitialized();
  HttpOverrides.global = MyHttpOverrides();

  siteApp = site;

  if (!kIsWeb) {
    appDocumentDirectory = await path_provider.getApplicationDocumentsDirectory();
  }
  String? path;
  if (appDocumentDirectory != null) {
    path = appDocumentDirectory!.path;
    Hive.init(path);
  }

  Setting.storageLib = SettingLib();

  if (boxes != null) {
    await Setting.init(boxes);
  }

  if (callbacks != null) {
    for (var func in callbacks) {
      func();
    }
  }

  if (asyncCallbacks != null) {
    await Future.forEach(asyncCallbacks, (AsyncCallbackFunc? element) async {
      await element!();
    });
  }
  appOrientations = orientations ?? [DeviceOrientation.portraitUp];
  await SystemChrome.setPreferredOrientations(orientations ?? [DeviceOrientation.portraitUp]);
  AppConfigs.loginOption = loginOption;

  runApp(
    MultiProvider(
      providers: loadProviders(providers),
      child: EasyLocalization(
        fallbackLocale: startLocale,
        startLocale: startLocale,
        useOnlyLangCode: true,
        supportedLocales: List<Locale>.from(supportedLocales ?? <Locale>[]),
        path: LanguageManager.instance().assetsPathLocations,
        child: RootApp(
          child: Application(
            startLocale: startLocale,
            theme: theme,
            darkTheme: darkTheme,
            supportedLocales: List<Locale>.from(supportedLocales ?? <Locale>[]),
            themeMode: themeMode,
            fallbackLocale: fallbackLocale,
            onGenerateRoute: onGenerateRoute,
            initialRoute: initialRoute,
            callInMyApps: callInMyApps,
            home: home,
          ),
        ),
      ),
    ),
  );
}
