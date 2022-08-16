import 'package:flutter/material.dart';

class IconButtonComp extends StatelessWidget {
  final IconData? icon;
  final Function()? onPress;
  final Color? splashColor, color;
  final double? splashRadius, size;

  const IconButtonComp({
    required this.icon,
    required this.onPress,
    Key? key,
    this.splashColor = Colors.transparent,
    this.splashRadius = 1,
    this.color,
    this.size,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPress,
      icon: Icon(
        icon,
        size: size,
        color: color,
      ),
      splashColor: splashColor,
      splashRadius: splashRadius,
    );
  }
}
