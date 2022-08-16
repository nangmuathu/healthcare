import 'package:app_healthcare/presentation/splash/splash_page.dart';
import 'package:flutter/material.dart';
import 'package:weup_basic/common/core/page_manager/push_page_builder.dart';
import 'package:weup_basic/common/core/sys/base_function.dart';
import 'package:weup_basic/common/core/widget/undefined_layout.dart';

class Routes {
  Routes._();

  static const String initialRoute = '/';
  static const String splashRoute = '/';
  static const String loginRoute = '/login';
}

class RouteGenerator {
  RouteGenerator._();
  static Route<dynamic> getRoute(RouteSettings settings) {
    Widget page;
    String? routeName = settings.name?.split('?').first;

    switch (routeName) {
      case Routes.initialRoute:
        page = const SplashPage();
        break;
      default:
        page = UndefinedLayout(
          name: settings.name,
        );
        break;
    }
    showLogState('Page: $page | RoutePath: ${settings.name} ');

    return PushPageBuilder.pushCupertinoPageBuilder(settings, page);
  }
}
