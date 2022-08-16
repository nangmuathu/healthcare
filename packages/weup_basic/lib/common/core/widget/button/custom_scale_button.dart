import 'package:flutter/material.dart';
import 'package:weup_basic/global.dart';

class CustomScaleButton extends StatefulWidget {
  final Color? color;
  final Color progressIndicatorColor;
  final double progressIndicatorSize;
  final BorderRadius borderRadius;
  final Duration animationDuration;

  final double strokeWidth;
  final Function() onPressed;
  final Widget child;

  const CustomScaleButton({
    required this.child,
    required this.onPressed,
    this.color,
    this.strokeWidth = 2,
    this.progressIndicatorColor = Colors.white,
    this.progressIndicatorSize = 22,
    this.borderRadius = const BorderRadius.all(Radius.circular(10)),
    this.animationDuration = const Duration(milliseconds: 300),
    Key? key,
  }) : super(key: key);

  @override
  State<CustomScaleButton> createState() => _CustomScaleButtonState();
}

class _CustomScaleButtonState extends State<CustomScaleButton>
    with SingleTickerProviderStateMixin<CustomScaleButton> {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.animationDuration,
      vsync: this,
    )..addStatusListener((status) {});
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ButtonStaggerAnimation(
        controller: _controller,
        color: widget.color ?? appStyle.primaryColor,
        strokeWidth: widget.strokeWidth,
        progressIndicatorColor: widget.progressIndicatorColor,
        progressIndicatorSize: widget.progressIndicatorSize,
        borderRadius: widget.borderRadius,
        onPressed: widget.onPressed,
        child: widget.child,
      ),
    );
  }
}

class ButtonStaggerAnimation extends StatelessWidget {
  final AnimationController controller;

  final Color color;
  final Color? progressIndicatorColor;
  final double? progressIndicatorSize;
  final BorderRadius? borderRadius;
  final double strokeWidth;
  final VoidCallback? onPressed;
  final Widget child;

  const ButtonStaggerAnimation({
    Key? key,
    required this.controller,
    required this.color,
    this.progressIndicatorColor,
    this.progressIndicatorSize,
    this.borderRadius,
    this.onPressed,
    this.strokeWidth = 4,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        double buttonHeight = (constraints.maxHeight != double.infinity)
            ? constraints.maxHeight
            : 55.0;
        var widthAnimation = Tween<double>(
          begin: constraints.maxWidth,
          end: buttonHeight,
        ).animate(
          CurvedAnimation(
            parent: controller,
            curve: Curves.easeInOut,
          ),
        );

        var borderRadiusAnimation = Tween<BorderRadius>(
          begin: borderRadius,
          end: BorderRadius.all(Radius.circular(buttonHeight / 2.0)),
        ).animate(CurvedAnimation(
          parent: controller,
          curve: Curves.easeInOut,
        ));
        return AnimatedBuilder(
          animation: controller,
          builder: (context, child) {
            return SizedBox(
              height: buttonHeight,
              width: widthAnimation.value,
              child: TextButton(
                style: ButtonStyle(
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(
                      borderRadius: borderRadiusAnimation.value)),
                  backgroundColor: MaterialStateProperty.all<Color>(color),
                ),
                child: _buttonChild(),
                onPressed: _onPressed,
              ),
            );
          },
        );
      },
    );
  }

  Widget _buttonChild() {
    if (controller.isAnimating) {
      return const SizedBox.shrink();
    } else if (controller.isCompleted) {
      return OverflowBox(
        maxWidth: progressIndicatorSize,
        maxHeight: progressIndicatorSize,
        child: CircularProgressIndicator(
          strokeWidth: strokeWidth,
          valueColor: AlwaysStoppedAnimation<Color>(
              progressIndicatorColor ?? appStyle.primaryColor),
        ),
      );
    }
    return child;
  }

  void _onPressed() {
    if (controller.isCompleted) {
      onPressed?.call();
      controller.reverse();
    } else {
      controller.forward();
    }
  }
}
