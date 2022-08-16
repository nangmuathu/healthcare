import 'package:flutter/material.dart';

class ItemScaleAnimationComp extends StatefulWidget {
  final VoidCallback? onTap;
  final void Function(TapUpDetails)? onTapUp;
  final void Function(TapDownDetails)? onTapDown;
  final VoidCallback? onTapCancel;

  final Duration? duration;

  final Duration? reverseDuration;

  final Curve curve;

  final Curve? reverseCurve;

  final double scaleFactor;

  final Widget child;

  const ItemScaleAnimationComp({
    Key? key,
    this.onTap,
    required this.child,
    this.onTapUp,
    this.onTapDown,
    this.onTapCancel,
    this.duration = const Duration(milliseconds: 200),
    this.reverseDuration = const Duration(milliseconds: 200),
    this.curve = Curves.decelerate,
    this.reverseCurve = Curves.decelerate,
    this.scaleFactor = 0.8, // 0.0 -> 1.0
  }) : super(key: key);

  @override
  _ItemScaleAnimationCompState createState() => _ItemScaleAnimationCompState();
}

class _ItemScaleAnimationCompState extends State<ItemScaleAnimationComp> with SingleTickerProviderStateMixin<ItemScaleAnimationComp> {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: widget.duration,
    reverseDuration: widget.reverseDuration,
    value: 1.0,
    upperBound: 1.0,
    lowerBound: widget.scaleFactor,
  );

  late final Animation<double> _animation = CurvedAnimation(
    parent: _controller,
    curve: widget.curve,
    reverseCurve: widget.reverseCurve,
  );

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapCancel: widget.onTap != null ? onTapCancel : null,
      onTapDown: widget.onTap != null ? onTapDown : null,
      onTapUp: widget.onTap != null ? onTapUp : null,
      onTap: widget.onTap != null ? onTap : null,
      child: ScaleTransition(scale: _animation, child: widget.child),
    );
  }

  void onTap() {
    if (widget.onTap != null) widget.onTap!();
    _controller.reverse().then((_) {
      _controller.forward();
    });
  }

  void onTapUp(TapUpDetails details) {
    if (widget.onTapUp != null) widget.onTapUp!(details);
    _controller.forward();
  }

  void onTapDown(TapDownDetails details) {
    if (widget.onTapDown != null) widget.onTapDown!(details);
    _controller.reverse();
  }

  void onTapCancel() {
    if (widget.onTapCancel != null) widget.onTapCancel!();
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
