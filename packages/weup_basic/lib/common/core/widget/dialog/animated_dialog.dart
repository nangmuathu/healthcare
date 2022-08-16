import 'dart:async';
import 'package:flutter/material.dart';

bool isShowing = false;

enum DialogTransitionMode {
  fade,
  slideFromTop,
  slideFromTopFade,
  slideFromBottom,
  slideFromBottomFade,
  slideFromLeft,
  slideFromLeftFade,
  slideFromRight,
  slideFromRightFade,
  scale,
  fadeScale,
  size,
  sizeFade,
  customIn,
  none,
}

Future<dynamic> showAnimatedDialog(
  BuildContext context, {
  bool barrierDismissible = false,
  required WidgetBuilder builder,
  DialogTransitionMode animationType = DialogTransitionMode.fade,
  Curve curve = Curves.linear,
  Duration? duration,
  Alignment alignment = Alignment.center,
  Axis? axis,
}) async {
  isShowing = true;
  return showGeneralDialog(
    context: context,
    pageBuilder: (BuildContext buildContext, Animation<double> animation, Animation<double> secondaryAnimation) {
      final Widget pageChild = Builder(builder: builder);
      return SafeArea(
        top: false,
        child: Builder(builder: (BuildContext context) => pageChild),
      );
    },
    barrierDismissible: barrierDismissible,
    barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
    barrierColor: Colors.black54,
    transitionDuration: duration ?? const Duration(milliseconds: 400),
    transitionBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) {
      switch (animationType) {
        case DialogTransitionMode.fade:
          return FadeTransition(opacity: animation, child: child);
        case DialogTransitionMode.slideFromRight:
          return SlideTransition(
            transformHitTests: false,
            position: Tween<Offset>(
              begin: const Offset(1.0, 0.0),
              end: Offset.zero,
            ).chain(CurveTween(curve: curve)).animate(animation),
            child: child,
          );

        case DialogTransitionMode.slideFromLeft:
          return SlideTransition(
            transformHitTests: false,
            position: Tween<Offset>(
              begin: const Offset(-1.0, 0.0),
              end: Offset.zero,
            ).chain(CurveTween(curve: curve)).animate(animation),
            child: child,
          );

        case DialogTransitionMode.slideFromRightFade:
          return SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(1.0, 0.0),
              end: Offset.zero,
            ).chain(CurveTween(curve: curve)).animate(animation),
            child: FadeTransition(
              opacity: animation,
              child: child,
            ),
          );

        case DialogTransitionMode.slideFromLeftFade:
          return SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(-1.0, 0.0),
              end: Offset.zero,
            ).chain(CurveTween(curve: curve)).animate(animation),
            child: FadeTransition(
              opacity: animation,
              child: child,
            ),
          );

        case DialogTransitionMode.slideFromTop:
          return SlideTransition(
            transformHitTests: false,
            position: Tween<Offset>(
              begin: const Offset(0.0, -1.0),
              end: Offset.zero,
            ).chain(CurveTween(curve: curve)).animate(animation),
            child: child,
          );

        case DialogTransitionMode.slideFromTopFade:
          return SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(0.0, -1.0),
              end: Offset.zero,
            ).chain(CurveTween(curve: curve)).animate(animation),
            child: FadeTransition(opacity: animation, child: child),
          );

        case DialogTransitionMode.slideFromBottom:
          return SlideTransition(
            transformHitTests: false,
            position: Tween<Offset>(
              begin: const Offset(0.0, 1.0),
              end: Offset.zero,
            ).chain(CurveTween(curve: curve)).animate(animation),
            child: child,
          );

        case DialogTransitionMode.slideFromBottomFade:
          return SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(0.0, 1.0),
              end: Offset.zero,
            ).chain(CurveTween(curve: curve)).animate(animation),
            child: FadeTransition(opacity: animation, child: child),
          );

        case DialogTransitionMode.scale:
          return ScaleTransition(
            alignment: alignment,
            scale: CurvedAnimation(
              parent: animation,
              curve: Interval(0.00, 0.50, curve: curve),
            ),
            child: child,
          );

        case DialogTransitionMode.fadeScale:
          return ScaleTransition(
            alignment: alignment,
            scale: CurvedAnimation(
              parent: animation,
              curve: Interval(0.00, 0.50, curve: curve),
            ),
            child: FadeTransition(
              opacity: CurvedAnimation(parent: animation, curve: curve),
              child: child,
            ),
          );
        case DialogTransitionMode.size:
          return Align(
            alignment: alignment,
            child: SizeTransition(
              sizeFactor: CurvedAnimation(parent: animation, curve: curve),
              axis: axis ?? Axis.vertical,
              child: child,
            ),
          );

        case DialogTransitionMode.sizeFade:
          return Align(
            alignment: alignment,
            child: SizeTransition(
              sizeFactor: CurvedAnimation(
                parent: animation,
                curve: curve,
              ),
              child: FadeTransition(
                opacity: CurvedAnimation(
                  parent: animation,
                  curve: curve,
                ),
                child: child,
              ),
            ),
          );

        case DialogTransitionMode.none:
          return child;
        case DialogTransitionMode.customIn:
          return Transform(
            alignment: Alignment.center,
            transform: Matrix4.identity()
              ..translate(0.0, Tween<double>(begin: -50.0, end: 50.0).animate(CurvedAnimation(curve: const Interval(.1, .5), parent: animation)).value)
              // ..translate(Tween<double>(begin: -100.0, end: 0).animate(CurvedAnimation(curve: const Interval(.1, .5), parent: animation)).value, .0)
              ..scale(
                Tween<double>(begin: .5, end: 1.0)
                    .animate(
                      CurvedAnimation(curve: const Interval(.5, .9), parent: animation),
                    )
                    .value,
              ),
            child: child,
          );
        default:
          return FadeTransition(opacity: animation, child: child);
      }
    },
  );
}

class CustomDialog extends StatelessWidget {
  const CustomDialog({
    Key? key,
    this.backgroundColor,
    this.elevation,
    this.insetAnimationDuration = const Duration(milliseconds: 100),
    this.insetAnimationCurve = Curves.decelerate,
    this.minWidth = 280.0,
    this.shape,
    required this.child,
  }) : super(key: key);

  final Color? backgroundColor;
  final double? elevation;

  final Duration insetAnimationDuration;
  final Curve insetAnimationCurve;

  final double minWidth;

  final ShapeBorder? shape;

  final Widget child;

  static const RoundedRectangleBorder _defaultDialogShape = RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(2.0)));
  static const double _defaultElevation = 24.0;

  @override
  Widget build(BuildContext context) {
    final DialogTheme dialogTheme = DialogTheme.of(context);
    return AnimatedPadding(
      padding: MediaQuery.of(context).viewInsets + const EdgeInsets.symmetric(horizontal: 40.0, vertical: 24.0),
      duration: insetAnimationDuration,
      curve: insetAnimationCurve,
      child: MediaQuery.removeViewInsets(
        removeLeft: true,
        removeTop: true,
        removeRight: true,
        removeBottom: true,
        context: context,
        child: Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(minWidth: minWidth),
            child: Material(
              color: backgroundColor ?? dialogTheme.backgroundColor ?? Theme.of(context).dialogBackgroundColor,
              elevation: elevation ?? dialogTheme.elevation ?? _defaultElevation,
              shape: shape ?? dialogTheme.shape ?? _defaultDialogShape,
              type: MaterialType.card,
              child: child,
            ),
          ),
        ),
      ),
    );
  }
}
