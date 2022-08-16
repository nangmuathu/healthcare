import 'package:flutter/material.dart';

import '../../../../global.dart';
import '../../../resource/enum_resource.dart';

class OutlinedButtonComp extends StatelessWidget {
  final String? title;
  final Widget? child;
  final Function()? onPressed;
  final EdgeInsetsGeometry? padding;
  final TextStyle? style;
  final Status? status;
  final double? borderRadius;
  final double? widthValue;
  final double? heightValue;
  final ButtonStyle? buttonStyle;
  final Color? primaryColor;
  final Color? colorBorder;

  const OutlinedButtonComp({
    Key? key,
    this.title,
    this.child,
    this.style,
    this.widthValue,
    this.heightValue,
    this.onPressed,
    this.padding,
    this.status,
    this.borderRadius,
    this.buttonStyle,
    this.primaryColor,
    this.colorBorder,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widthValue,
      height: heightValue,
      child: OutlinedButton(
        onPressed: status != Status.loading ? onPressed : null,
        child: child ??
            Text(
              title ?? '',
              style: style ?? appStyle.textTheme.headline4,
            ),
        style: buttonStyle ??
            OutlinedButton.styleFrom(
              padding: padding ??
                  const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
              side: BorderSide(color: colorBorder ?? appStyle.primaryColor),
              primary: primaryColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(borderRadius ?? 0),
              ),
            ),
      ),
    );
  }
}
