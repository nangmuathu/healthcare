import 'dart:io';

import 'package:flutter/services.dart';
import 'package:weup_basic/import.dart';

enum LoginOption { none, required }

typedef AsyncCallbackFunc = Future<void> Function();

late List<DeviceOrientation> appOrientations;

Directory? appDocumentDirectory;

ThemeData appStyle = Theme.of(navigator.currentContext!);

late Site siteApp;

final GlobalKey<NavigatorState> navigator = GlobalKey<NavigatorState>();

late VoidCallback reloadApp;

// late LoginOption option;

class Site {
  final String title;
  final String domain;
  final int? port;

  Site({required this.title, required this.domain, this.port});
}

