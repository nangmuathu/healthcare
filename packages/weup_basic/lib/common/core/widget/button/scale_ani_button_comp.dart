import 'package:flutter/material.dart';
import 'package:weup_basic/global.dart';

class ScaleAniButtonComp extends StatefulWidget {
  final GestureTapCallback onPressed;
  final bool isEnabled;
  final bool isElevation;
  final Widget? child;
  final Color? bgColor;
  final double borderRadius;
  final double elevation;
  final double scaleBegin, scaleEnd;
  final double? width, height;
  final int duration;
  final EdgeInsetsGeometry? padding;
  final String? title;
  final Color? colorTitle;
  final FontWeight? fontWeightTitle;
  final bool isFit;
  final TextStyle? styleTitle;

  const ScaleAniButtonComp({
    Key? key,
    this.child,
    required this.onPressed,
    this.isEnabled = false,
    this.bgColor,
    this.duration = 1000,
    this.borderRadius = 10,
    this.elevation = 4,
    this.padding,
    this.isElevation = true,
    this.scaleBegin = 0.95,
    this.scaleEnd = 1,
    this.width,
    this.height,
    this.title,
    this.colorTitle,
    this.isFit = false,
    this.styleTitle,
    this.fontWeightTitle,
  }) : super(key: key);

  @override
  State<ScaleAniButtonComp> createState() => _ScaleAniButtonCompState();
}

class _ScaleAniButtonCompState extends State<ScaleAniButtonComp>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<double> animation;

  @override
  void initState() {
    super.initState();

    animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: widget.duration),
      value: 1,
    );

    animation = Tween(
      begin: widget.scaleBegin,
      end: 1.0,
    ).animate(
      CurvedAnimation(
        parent: animationController,
        curve: Curves.elasticOut,
      ),
    );
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  void _pressed(_) {
    animationController.value = 0;
  }

  Future<void> _unPressedOnTapUp(_) async {
    animationController.forward();
    await Future.delayed(const Duration(milliseconds: 100));
    widget.onPressed.call();
    animationController.value = 1;
  }

  Future<void> _unPressed() async {
    animationController.value = 1;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: AnimatedBuilder(
        animation: animation,
        builder: (BuildContext context, Widget? cachedChild) {
          return Transform.scale(
            scale: animation.value,
            child: widget.child ??
                Container(
                  decoration: BoxDecoration(
                    color: !widget.isEnabled
                        ? (widget.bgColor ?? appStyle.primaryColor)
                        : Colors.grey.withOpacity(0.4),
                    borderRadius: BorderRadius.circular(widget.borderRadius),
                  ),
                  padding: widget.padding,
                  width:
                      !widget.isFit ? (widget.width ?? double.infinity) : null,
                  height: !widget.isFit ? (widget.height ?? 55) : null,
                  alignment: !widget.isFit ? Alignment.center : null,
                  child: Text(
                    widget.title ?? '',
                    style: widget.styleTitle ??
                        // appStyle.textTheme.headline4?.copyWith(
                        appStyle.textTheme.headline5?.copyWith(
                          fontWeight: widget.fontWeightTitle ?? FontWeight.w700,
                          color: !widget.isEnabled
                              ? widget.colorTitle ?? Colors.white
                              : Colors.grey.withOpacity(0.5),
                        ),
                  ),
                ),
          );
        },
      ),
      onTapDown: !widget.isEnabled ? _pressed : null,
      onTapUp: !widget.isEnabled ? _unPressedOnTapUp : null,
      onTapCancel: !widget.isEnabled ? _unPressed : null,
    );
  }
}
