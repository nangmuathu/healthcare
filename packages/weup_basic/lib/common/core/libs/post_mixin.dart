import 'dart:io';

import 'package:flutter/material.dart';
import 'package:weup_basic/common/helper/app_common.dart';

import '../sys/api_response.dart';

mixin PostMixin {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @mustCallSuper
  String? validator(String val, int type) => null;

  bool isValidate() => formKey.currentState!.validate();

  void reset() => formKey.currentState!.reset();

  void showErrorMessage([String? msg]) {
    disableSubmitting();
    ViewUtils.toast(msg ?? 'Bạn vui lòng nhập đầy đủ thông tin',
        mode: ToastMode.error);
  }

  bool isSubmitting = false;

  void showSubmitting() {
    isSubmitting = true;
  }

  void disableSubmitting([bool hasDelay = false]) async {
    Future.delayed(
        !hasDelay ? Duration.zero : const Duration(milliseconds: 1500), () {
      isSubmitting = false;
    });
  }

  void onSubmit(BuildContext context, {ValueChanged? callback});

  bool checkFail(ApiResponse? response) =>
      response?.code != HttpStatus.ok && response?.data == null;
}
