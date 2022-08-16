import 'package:flutter/material.dart';

import '../../../../global.dart';
import '../../../resource/enum_resource.dart';

class TextButtonComp extends StatelessWidget {
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
  final Color? backgroundColor;

  const TextButtonComp({
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
    this.backgroundColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widthValue,
      height: heightValue,
      child: TextButton(
        onPressed: status != Status.loading ? onPressed : null,
        child: child ??
            Text(
              title ?? '',
              style: style ?? appStyle.textTheme.headline4,
            ),
        style: buttonStyle ??
            TextButton.styleFrom(
              backgroundColor: backgroundColor,
              padding: padding ??
                  const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
              primary: primaryColor,
              textStyle: style ?? appStyle.textTheme.headline6,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(borderRadius ?? 0),
              ),
            ),
      ),
    );
  }
}
