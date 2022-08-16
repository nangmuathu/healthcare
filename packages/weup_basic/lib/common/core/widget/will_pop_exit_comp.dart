import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:weup_basic/common/extension/app_extension.dart';

import 'dialog/request_alert_dialog.dart';

class WillPopExitComp extends StatelessWidget {
  final Widget child;

  const WillPopExitComp({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: child,
      onWillPop: () => _onWillPop(context),
    );
  }

  Future<bool> _onWillPop(BuildContext context) async {
    return (await showGeneralDialog<bool>(
          context: context,
          pageBuilder: (ctx, _, __) => const SizedBox(),
          transitionBuilder: (ctx, ani1, __, child) {
            var curve = Curves.easeInOut.transform(ani1.value);
            return Transform.scale(
              scale: curve,
              child: RequestAlertDialog(
                  title: 'Thoát app',
                  description: 'Bạn có muốn thoát ứng dụng không?',
                  onConfirm: () => _onConfirm(context)),
            );
          },
          transitionDuration: const Duration(milliseconds: 300),
        )) ??
        false;
  }

  void _onConfirm(BuildContext context) {
    if (Platform.isAndroid) {
      SystemNavigator.pop();
      return;
    } else if (Platform.isIOS) {
      exit(0);
    }
    context.pop(true);
  }
}
