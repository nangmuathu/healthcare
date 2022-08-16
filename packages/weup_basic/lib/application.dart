import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'common/helper/constant.dart';
import 'common/helper/system_utils.dart';
import 'global.dart';

class Application extends StatefulWidget {
  final Locale? startLocale;
  final ThemeMode? themeMode;
  final ThemeData? theme;
  final ThemeData? darkTheme;
  final List<Locale>? supportedLocales;
  final Locale? fallbackLocale;
  final String initialRoute;
  final RouteFactory? onGenerateRoute;
  final List<AsyncCallbackFunc>? callInMyApps;
  final Widget? home;
  const Application(
      {Key? key,
      this.startLocale,
      this.themeMode,
      this.theme,
      this.darkTheme,
      this.onGenerateRoute,
      this.supportedLocales,
      this.fallbackLocale,
      required this.initialRoute,
      this.callInMyApps,
      this.home})
      : super(key: key);

  static final GlobalKey<NavigatorState> navigator =
      GlobalKey<NavigatorState>();

  @override
  State<Application> createState() => _ApplicationState();
}

class _ApplicationState extends State<Application> {
  @override
  void initState() {
    if (!empty(widget.callInMyApps)) {
      for (var element in widget.callInMyApps!) {
        element.call();
      }
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: Application.navigator,
      debugShowCheckedModeBanner: false,
      title: AppConstant.APP_NAME,
      initialRoute: widget.initialRoute,
      onGenerateRoute: widget.onGenerateRoute,
      themeMode: widget.themeMode,
      darkTheme: widget.darkTheme,
      theme: widget.darkTheme,
      home: (widget.onGenerateRoute == null)
          ? (widget.home ?? const _NoRoute())
          : null,
      locale: context.locale,
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      builder: (context, child) => MediaQuery(
          child: child!,
          data: MediaQuery.of(context).copyWith(
              textScaleFactor:
                  MediaQuery.of(context).textScaleFactor.clamp(1.0, 1.1))),
    );
  }
}

class _NoRoute extends StatelessWidget {
  const _NoRoute({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Please setup route'),
            BackButton(
              onPressed: () => Navigator.pop(context),
            ),
          ],
        ),
      ),
    );
  }
}
