import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PushPageBuilder {
  static pushCupertinoPageBuilder(RouteSettings settings, Widget page) =>
      CupertinoPageRoute(builder: (_) => page, settings: settings);

  static pushMaterialPageBuilder(RouteSettings settings, Widget page) =>
      MaterialPageRoute(builder: (_) => page, settings: settings);

  static pushCustomPageBuilder(RouteSettings settings, Widget page) => PageRouteBuilder(
      settings: settings,
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(1.0, 0.0);
        const end = Offset.zero;
        const curve = Curves.ease;

        final tween = Tween(begin: begin, end: end);
        final curvedAnimation = CurvedAnimation(
          parent: animation,
          curve: curve,
        );

        return SlideTransition(
          position: tween.animate(curvedAnimation),
          child: child,
        );
      });

  static pushDialogSlider(RouteSettings settings, Widget page) => PageRouteBuilder(
      opaque: true,
      settings: settings,
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(1.0, 0.0);
        const end = Offset.zero;
        const curve = Curves.ease;

        final tween = Tween(begin: begin, end: end);
        final curvedAnimation = CurvedAnimation(
          parent: animation,
          curve: curve,
        );

        return SlideTransition(
          position: tween.animate(curvedAnimation),
          child: child,
        );
      });
}
