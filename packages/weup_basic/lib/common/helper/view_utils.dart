import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../global.dart';
import '../extension/context_extension.dart';

enum ToastMode {
  none,
  success,
  error,
}

class ViewUtils {
  static BuildContext? get _ctx => navigator.currentContext;

  static void hideKeyboard({BuildContext? context}) =>
      FocusScope.of(context!).unfocus();

  static Future<void>? changeLanguage(Locale locale) => _ctx?.setLocale(locale);

  static Locale? getLocale() => _ctx?.locale;

  static double get width => _ctx!.width;

  static double get height => _ctx!.height;

  static double get heightStatusBar => MediaQuery.of(_ctx!).padding.top;

  static dynamic toast(String msg,
      {ToastMode mode = ToastMode.none,
      double fontSize = 14.0,
      ToastGravity gravity = ToastGravity.BOTTOM}) {
    Fluttertoast.cancel();
    return Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
      gravity: gravity,
      backgroundColor: _getToastColor(mode),
      textColor: Colors.white,
      fontSize: fontSize,
    );
  }

  static Color _getToastColor(ToastMode mode) {
    switch (mode) {
      case ToastMode.success:
        return Colors.green;
      case ToastMode.error:
        return Colors.red;
      default:
        return Colors.blue;
    }
  }
}
