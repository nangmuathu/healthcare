import 'package:lottie/lottie.dart';
import 'package:flutter/material.dart';

import '../../resource/enum_resource.dart';
import '../../resource/lottie_resource.dart';

class LoadingComp extends StatefulWidget {
  final Status? status;
  final Color? backgroundColor;
  final bool hasColor;
  final double? width;

  const LoadingComp(
      {Key? key,
      this.status,
      this.backgroundColor,
      this.hasColor = true,
      this.width})
      : super(key: key);

  @override
  State<LoadingComp> createState() => _LoadingCompState();
}

class _LoadingCompState extends State<LoadingComp>
    with SingleTickerProviderStateMixin<LoadingComp> {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      color: widget.hasColor
          ? (widget.status == Status.loading
              ? Colors.white
              : (widget.backgroundColor ?? Colors.black.withOpacity(0.3)))
          : null,
      child: Lottie.asset(
        LottieResource.loading,
        repeat: true,
        width: 130,
        height: 100,
        fit: BoxFit.scaleDown,
      ),
    );
  }
}
