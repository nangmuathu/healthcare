import 'dart:io';

import 'package:flutter/services.dart';
import 'package:weup_basic/app/site.dart';
import 'package:weup_basic/application.dart';
import 'package:weup_basic/import.dart';

typedef AsyncCallbackFunc = Future<void> Function();

late List<DeviceOrientation> appOrientations;

Directory? appDocumentDirectory;

ThemeData appStyle = Theme.of(Application.navigator.currentContext!);

late Site siteApp;
