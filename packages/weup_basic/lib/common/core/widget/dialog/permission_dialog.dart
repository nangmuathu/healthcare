import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:weup_basic/common/extension/app_extension.dart';

import '../../../../global.dart';
import '../button/text_button_comp.dart';

class PermissionDialog extends StatelessWidget {
  final String title, content;

  const PermissionDialog({
    Key? key,
    required this.title,
    required this.content,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Platform.isAndroid
        ? AlertDialog(
            title: Text(title.toUpperCaseLetter),
            content: Text(content),
            actions: [
              TextButtonComp(
                title: 'Cancle',
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              TextButtonComp(
                title: 'Setting',
                style: appStyle.textTheme.headline4!
                    .apply(color: appStyle.primaryColor),
                onPressed: () {
                  Navigator.pop(context);
                  openAppSettings();
                },
              ),
            ],
          )
        : CupertinoAlertDialog(
            title: Text(title),
            content: Text(content),
            actions: [
              CupertinoDialogAction(
                child: const Text('Cancle'),
                onPressed: () => Navigator.pop(context),
              ),
              CupertinoDialogAction(
                child: const Text('Cancle'),
                onPressed: () {
                  Navigator.pop(context);
                  openAppSettings();
                },
              ),
            ],
          );
  }
}
