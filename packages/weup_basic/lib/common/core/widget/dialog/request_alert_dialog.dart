import 'package:flutter/material.dart';
import 'package:weup_basic/common/extension/app_extension.dart';

class RequestAlertDialog extends StatelessWidget {
  final String title;
  final dynamic description;
  final String? cancelText;
  final String? confirmText;
  final VoidCallback? onConfirm;
  final VoidCallback? onCancel;
  final bool isClose;
  final TextAlign? textAlign;

  const RequestAlertDialog(
      {required this.title,
      required this.description,
      this.onConfirm,
      this.confirmText,
      this.cancelText,
      this.onCancel,
      this.isClose = false,
      this.textAlign,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: EdgeInsets.zero,
      titlePadding: const EdgeInsets.only(top: 12),
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 15),
          Visibility(
            visible: isClose,
            child: Padding(
              padding: const EdgeInsets.only(right: 10.0),
              child: Align(
                  alignment: Alignment.bottomRight,
                  child: InkWell(
                      onTap: onCancel ?? context.pop,
                      child: const Icon(Icons.close))),
            ),
          ),
          Center(
              child: Text(title.toUpperCase(),
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      fontWeight: FontWeight.w600, fontSize: 18))),
          Container(
            padding:
                const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 22),
            child: description is Widget
                ? description
                : Text(
                    description,
                    style: const TextStyle(
                      color: Colors.black87,
                      fontSize: 15,
                    ),
                    textAlign: textAlign ?? TextAlign.center,
                  ),
          ),
          Container(height: 1, color: Colors.black87.withOpacity(0.1)),
          Row(
            children: [
              Expanded(
                child: ClipRRect(
                  borderRadius:
                      const BorderRadius.only(bottomLeft: Radius.circular(15)),
                  child: Stack(
                    children: [
                      SizedBox(
                        height: 41,
                        child: Center(
                          child: Text(cancelText ?? 'Cancel',
                              style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.red)),
                        ),
                      ),
                      Positioned.fill(
                          child: Material(
                              color: Colors.transparent,
                              child: InkWell(onTap: onCancel ?? context.pop))),
                    ],
                  ),
                ),
              ),
              Container(
                  height: 41, width: 1, color: Colors.black87.withOpacity(0.1)),
              Expanded(
                child: ClipRRect(
                  borderRadius:
                      const BorderRadius.only(bottomRight: Radius.circular(15)),
                  child: Stack(
                    children: [
                      SizedBox(
                          height: 41,
                          child: Center(child: Text(confirmText ?? 'Confirm'))),
                      Positioned.fill(
                          child: Material(
                              color: Colors.transparent,
                              child: InkWell(onTap: onConfirm))),
                    ],
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
