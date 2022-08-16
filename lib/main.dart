import 'package:app_healthcare/app/app_lib.dart';
import 'package:app_healthcare/presentation/resources/routes_manager.dart';
import 'package:app_healthcare/presentation/resources/theme_manager.dart';
import 'package:weup_basic/app/site.dart';
import 'package:weup_basic/import.dart';
import 'package:weup_basic/init.dart';
import 'package:weup_basic/managers/languague_manger.dart';

void main() {
  initApp(
    site: Site(title: 'Healthcare', domain: '127.0.0.1'),
    initialRoute: Routes.initialRoute,
    boxes: ['account', 'app'],
    onGenerateRoute: RouteGenerator.getRoute,
    providers: [
      ChangeNotifierProvider.value(value: appLib),
    ],
    theme: getApplicationTheme(),
    startLocale: vnLocale,
    fallbackLocale: vnLocale,
    callbacks: [],
    supportedLocales: [vnLocale, enLocale],
    themeMode: ThemeMode.light,
  );
}
