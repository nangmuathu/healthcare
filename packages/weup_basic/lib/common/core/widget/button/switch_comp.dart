import 'package:flutter/material.dart';
import 'package:weup_basic/global.dart';

class SwitchComp extends StatelessWidget {
  final bool? value;
  final Function(bool value)? onChanged;
  final Color? activeColor;
  final Color? inactiveThumbColor;
  final Color? inactiveTrackColor;
  final Color? activeTrackColor;

  const SwitchComp({
    Key? key,
    required this.value,
    required this.onChanged,
    this.activeColor,
    this.inactiveThumbColor,
    this.inactiveTrackColor,
    this.activeTrackColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Switch(
      value: value ?? false,
      onChanged: onChanged,
      activeColor: activeColor ?? appStyle.primaryColor,
      inactiveThumbColor: inactiveThumbColor,
      inactiveTrackColor: inactiveTrackColor,
      activeTrackColor: activeTrackColor,
    );
  }
}
