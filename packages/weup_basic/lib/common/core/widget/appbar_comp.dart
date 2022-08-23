import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:weup_basic/global.dart';

import 'button/icon_button_comp.dart';

class AppBarComp extends PreferredSize {
  final dynamic title;
  final TextStyle? style;
  final List<Widget>? action;
  final Color? backgroundColor;
  final Color? colorIcon;
  final double? elevation;
  final bool? isLight;
  final bool isLeading;
  final bool? centerTitle;
  final Widget? flexibleSpace;
  final Widget? iconLeading;
  final Function? onLeading;
  final double height;
  final SystemUiOverlayStyle? systemOverlayStyle;
  final PreferredSizeWidget? bottom;

  AppBarComp({
    Key? key,
    this.systemOverlayStyle,
    this.title,
    this.style,
    this.action,
    this.backgroundColor,
    this.colorIcon,
    this.elevation = 0,
    this.isLight,
    this.isLeading = true,
    this.flexibleSpace,
    this.iconLeading,
    this.onLeading,
    this.centerTitle,
    this.bottom,
    this.height = kToolbarHeight,
  }) : super(
            key: key,
            preferredSize: Size(double.infinity, height),
            child: Container());

  @override
  Size get preferredSize => Size.fromHeight(height);

  @override
  Widget build(BuildContext context) => AppBar(
        systemOverlayStyle: systemOverlayStyle ?? SystemUiOverlayStyle.light,
        title: title is Widget
            ? title
            : Text(title ?? '',
                style: style ??
                    const TextStyle(fontWeight: FontWeight.w700, fontSize: 20),
                overflow: TextOverflow.ellipsis,
                maxLines: 1),
        flexibleSpace: flexibleSpace,
        backgroundColor: backgroundColor ?? appStyle.appBarTheme.backgroundColor,
        elevation: elevation,
        automaticallyImplyLeading: isLeading,
        leading: iconLeading ??
            IconButtonComp(
              icon: Icons.arrow_back_ios,
              size: 20,
              color: Colors.white,
              onPress: () => _onBackPress(context),
              splashRadius: 26,
            ),
        iconTheme: IconThemeData(color: colorIcon),
        centerTitle: centerTitle,
        actions: action,
        bottom: bottom,
      );

  void _onBackPress(BuildContext context) {
    if (onLeading == null) Navigator.pop(context);

    onLeading?.call();
  }
}
