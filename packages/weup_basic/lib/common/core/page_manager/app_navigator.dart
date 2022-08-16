import 'dart:developer';

import 'package:flutter/material.dart';

/*
* Thực hiện các navigation không cần context
*
* */
class AppNavigator {
  late BuildContext context;

  double get width => MediaQuery.of(context).size.width;

  double get height => MediaQuery.of(context).size.height;

  void setBuildContext(BuildContext? ctx) => context = ctx!;

  /*
  * Hiển thị dialog
  * */
  Future<dynamic> dialog(Widget dialog, {dynamic arguments, bool? barrierDismissible}) async {
    log('OPEN DIALOG ${dialog.runtimeType} ${dialog.hashCode}', name: 'WEUP-APP');
    return await showGeneralDialog(
      context: context,
      transitionDuration: Duration(milliseconds: ModalRoute.of(context)?.isCurrent == true ? 300 : 500),
      transitionBuilder: (context, animation, secondaryAnimation, _child) {
        return ScaleTransition(
          child: _child,
          scale: Tween<double>(end: 1, begin: ModalRoute.of(context)?.isCurrent == true ? 1.3 : 0).animate(
            CurvedAnimation(
              parent: animation,
              curve: const Interval(0.5, 1.00, curve: Curves.linear),
            ),
          ),
        );
      },
      barrierDismissible: true,
      barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
      routeSettings: RouteSettings(arguments: arguments),
      pageBuilder: (animation, secondaryAnimation, _child) => dialog,
    );
  }

  /*
  * Hiển thị bottomSheet
  * */
  Future<dynamic> bottomSheetDialog(Widget dialog, {dynamic arguments}) async =>
      await showModalBottomSheet(context: context, builder: (context) => dialog, routeSettings: RouteSettings(arguments: arguments));

  /*
  * Navigate to new page with [RouteName]
  * */
  Future<dynamic> pushNamed(
    String routeName, {
    Map<String, dynamic>? params,
    dynamic arguments,
  }) async {
    if (params != null) {
      final uri = Uri(path: routeName, queryParameters: params);
      routeName = uri.toString();
    }
    await Navigator.pushNamed(context, routeName, arguments: arguments);
  }

  /*
  * Navigate to new page with [RouteName] and replace [current page]
  * */
  Future<dynamic> pushReplacementNamed(
    String routeName, {
    Map<String, dynamic>? params,
    dynamic arguments,
    dynamic result,
  }) async {
    if (params != null) {
      final uri = Uri(path: routeName, queryParameters: params);
      routeName = uri.toString();
    }
    await Navigator.pushReplacementNamed(context, routeName, arguments: arguments, result: result);
  }

  /*
  * Navigate to new page with [RouteName] and replace all util pages
  * */
  Future<dynamic> pushNamedAndRemoveUntil(
    String routeName, {
    Map<String, dynamic>? params,
    dynamic arguments,
  }) async {
    if (params != null) {
      final uri = Uri(path: routeName, queryParameters: params);
      routeName = uri.toString();
    }
    await Navigator.pushNamedAndRemoveUntil(context, routeName, (Route<dynamic> route) => false, arguments: arguments);
  }

  /*
  * Close dialog, page,...
  *
  * Safe when [page histories] is empty
  * */
  void back({dynamic result}) async {
    log(result.toString(), name: 'WEUP-APP');
    if (Navigator.canPop(context)) Navigator.pop(context, result);
  }

  // Future<dynamic> bottomSheet() async {
  //   return showBottomSheet(context: context, builder: (_) => BottomSheetMenu(title: 'Hello world'));
  // }
}
