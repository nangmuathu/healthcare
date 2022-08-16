import 'package:flutter/material.dart';

class ButtonBaseComp extends StatelessWidget {
  final VoidCallback? onPressed;
  final dynamic title;
  final Color? titleColor;
  final Color? color;
  final Color borderColor;
  final EdgeInsets? padding;
  final BorderRadius? radius;

  const ButtonBaseComp({
    Key? key,
    this.onPressed,
    required this.title,
    this.color,
    this.borderColor = const Color(0xffF7F7F7),
    this.titleColor,
    this.padding,
    this.radius,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: ButtonStyle(
          padding: MaterialStateProperty.all<EdgeInsets>(padding ?? const EdgeInsets.symmetric(horizontal: 10, vertical: 15)),
          backgroundColor: MaterialStateProperty.all(color ?? const Color(0xffe5e4e4)),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(borderRadius: radius ?? BorderRadius.circular(12.0), side: BorderSide(color: borderColor)))),
      onPressed: onPressed,
      child: title is String ? Text(title, style: TextStyle(color: titleColor ?? Colors.grey.withOpacity(.6), fontWeight: FontWeight.w600)) : title,
    );
  }
}
