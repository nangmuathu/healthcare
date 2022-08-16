import 'package:flutter/cupertino.dart';

import '../widget/dialog/animated_dialog.dart';

class DialogManager {
  DialogManager._internal();

  static DialogManager? _instance;

  factory DialogManager.instance() => _instance ??= DialogManager._internal();

  void show(BuildContext context, {required WidgetBuilder builder}) {
    showAnimatedDialog(
      context,
      duration: const Duration(milliseconds: 500),
      animationType: DialogTransitionMode.fadeScale,
      barrierDismissible: false,
      builder: builder,
    );
  }
}
