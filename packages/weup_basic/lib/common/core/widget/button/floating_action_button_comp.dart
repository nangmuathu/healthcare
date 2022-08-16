import 'package:flutter/material.dart';
import 'package:weup_basic/common/core/widget/button/scale_ani_button_comp.dart';

class FloatingActionButtonComp extends StatelessWidget {
  final ShapeBorder? shape;
  final double? elevation;
  final double? height;
  final double? width;
  final Function onPressed;
  final Widget child;
  final Color? backgroundColor;

  const FloatingActionButtonComp({
    Key? key,
    this.shape,
    this.elevation,
    this.height = 60,
    this.width = 60,
    required this.onPressed,
    required this.child,
    this.backgroundColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScaleAniButtonComp(
      isElevation: false,
      onPressed: () {},
      padding: EdgeInsets.zero,
      child: SizedBox(
        height: height,
        width: width,
        child: FloatingActionButton(
          backgroundColor: backgroundColor,
          onPressed: null,
          child: child,
          elevation: elevation,
          shape: shape,
        ),
      ),
    );
  }
}
