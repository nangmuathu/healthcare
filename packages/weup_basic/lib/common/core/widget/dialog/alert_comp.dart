import 'package:flutter_html/shims/dart_ui.dart';
import 'package:weup_basic/common/extension/app_extension.dart';
import 'package:flutter/material.dart';

class AlertComp extends StatelessWidget {
  final Widget content;
  final List<Widget> actions;
  final bool isClose;
  final VoidCallback? callbackPop;
  final bool hasPop;

  const AlertComp(
      {Key? key,
      required this.content,
      this.actions = const [],
      this.isClose = true,
      this.callbackPop,
      this.hasPop = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        titlePadding: EdgeInsets.zero,
        title: const SizedBox.shrink(),
        content: Stack(
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                content,
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: actions,
                ),
              ],
            ),
            if (isClose)
              Positioned(
                  top: 0,
                  right: 0,
                  child: InkWell(
                    onTap: context.pop,
                    child: const Icon(Icons.clear),
                    splashFactory: NoSplash.splashFactory,
                  )),
          ],
        ),
      ),
    );
  }

  Future<bool> _onWillPop() async {
    callbackPop?.call();
    return hasPop;
  }
}

class AlertButtonComp extends StatelessWidget {
  final dynamic title;
  final VoidCallback? onTap;
  final Color? color;
  final Color? titleColor;
  final Border? border;
  final double? radius;
  final double? width;
  final EdgeInsets? padding;

  const AlertButtonComp(
      {Key? key,
      required this.title,
      this.onTap,
      this.color,
      this.border,
      this.radius,
      this.width,
      this.padding,
      this.titleColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      radius: 8,
      borderRadius: BorderRadius.circular(radius ?? 8),
      child: Container(
        width: width,
        alignment: Alignment.center,
        padding:
            padding ?? const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: border ?? Border.all(color: Colors.black.withOpacity(.32)),
          color: color,
        ),
        child: title is Widget
            ? title
            : Text(title, style: TextStyle(fontSize: 14, color: titleColor)),
      ),
    );
  }
}
