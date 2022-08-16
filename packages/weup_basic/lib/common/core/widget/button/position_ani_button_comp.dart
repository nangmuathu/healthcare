import 'package:flutter/material.dart';

class PositionAniButtonComp extends StatefulWidget {
  final GestureTapCallback onPressed;
  final bool enabled;
  final Widget child;
  final Color color;
  final double height;
  final double width;
  final double borderRadius;
  final int duration;
  final ShadowDegree shadowDegree;

  const PositionAniButtonComp({
    Key? key,
    required this.child,
    required this.onPressed,
    this.enabled = true,
    this.color = Colors.blue,
    this.height = 60,
    this.width = 160,
    this.shadowDegree = ShadowDegree.light,
    this.duration = 1000,
    this.borderRadius = 16,
  }) : super(key: key);

  @override
  State<PositionAniButtonComp> createState() => _PositionAniButtonCompState();
}

class _PositionAniButtonCompState extends State<PositionAniButtonComp>
    with SingleTickerProviderStateMixin {
  late Animation animation;

  late AnimationController animationController;

  @override
  void initState() {
    animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: widget.duration),
      value: 1,
    );

    animation = Tween(
      begin: 0.0,
      end: 4.0,
    ).animate(
      CurvedAnimation(
        parent: animationController,
        curve: Curves.elasticOut,
      ),
    );

    super.initState();
  }

  void _pressed(_) {
    animationController.value = 0;
  }

  Future<void> _unPressedOnTapUp(_) async {
    animationController.forward();
   await _unPressed();
  }

  Future<void> _unPressed() async {
    await Future.delayed(const Duration(milliseconds: 100));
    widget.onPressed.call();
    animationController.value = 4;
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double height = widget.height - 4;
    return GestureDetector(
      child: SizedBox(
        width: widget.width,
        height: widget.height,
        child: Stack(
          children: <Widget>[
            Positioned(
              bottom: 0,
              child: Container(
                height: height,
                width: widget.width,
                decoration: BoxDecoration(
                  color: widget.enabled
                      ? darken(widget.color, widget.shadowDegree)
                      : darken(Colors.grey, widget.shadowDegree),
                  borderRadius: BorderRadius.all(
                    Radius.circular(widget.borderRadius),
                  ),
                ),
              ),
            ),
            AnimatedBuilder(
                animation: animation,
                builder: (BuildContext context, Widget? cachedChild) {
                  return Positioned(
                    bottom: animation.value,
                    child: Container(
                      height: height,
                      width: widget.width,
                      decoration: BoxDecoration(
                        color: widget.enabled ? widget.color : Colors.grey,
                        borderRadius: BorderRadius.all(
                          Radius.circular(widget.borderRadius),
                        ),
                      ),
                      child: Center(
                        child: widget.child,
                      ),
                    ),
                  );
                }),
          ],
        ),
      ),
      onTapDown: widget.enabled ? _pressed : null,
      onTapUp: widget.enabled ? _unPressedOnTapUp : null,
      onTapCancel: widget.enabled ? _unPressed : null,
    );
  }

  Color darken(Color color, ShadowDegree degree) {
    double amount = degree == ShadowDegree.dark ? 0.2 : 0.12;
    final hsl = HSLColor.fromColor(color);
    final hslDark = hsl.withLightness((hsl.lightness - amount).clamp(0.0, 1.0));
    return hslDark.toColor();
  }
}

enum ShadowDegree { light, dark }
