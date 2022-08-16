import 'package:flutter/material.dart';

import '../../../../global.dart';
import '../../../resource/enum_resource.dart';

class ElevatedButtonComp extends StatelessWidget {
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
  final double? elevation;

  const ElevatedButtonComp({
    Key? key,
    this.title,
    this.child,
    this.onPressed,
    this.status,
    this.padding,
    this.style,
    this.borderRadius,
    this.buttonStyle,
    this.primaryColor,
    this.widthValue,
    this.heightValue,
    this.elevation,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widthValue,
      height: heightValue,
      child: ElevatedButton(
        onPressed: status != Status.loading ? onPressed : null,
        child: child ??
            Text(title ?? '',
                style: style ??
                    appStyle.textTheme.headline5?.apply(color: Colors.white)),
        style: buttonStyle ??
            ElevatedButton.styleFrom(
              padding: padding ??
                  const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
              primary: (primaryColor ?? appStyle.primaryColor)
                  .withOpacity(status == Status.loading ? 0.5 : 1),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(borderRadius ?? 0),
              ),
              elevation: elevation,
            ),
      ),
    );
  }
}
