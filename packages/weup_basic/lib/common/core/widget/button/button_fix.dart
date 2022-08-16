import 'package:flutter/material.dart';
import 'package:weup_basic/global.dart';

class ButtonFixStyle {
  final Color topColor;
  final Color backColor;
  final BorderRadius borderRadius;
  final double z;
  final double tappedZ;

  const ButtonFixStyle(
      {this.topColor = const Color(0xFF45484c),
      this.backColor = const Color(0xFF191a1c),
      this.borderRadius = const BorderRadius.all(Radius.circular(10)),
      this.z = 8.0,
      this.tappedZ = 3.0});

  static const RED =
      ButtonFixStyle(topColor: Color(0xFFc62f2f), backColor: Color(0xFF922525));
  static const BLUE =
      ButtonFixStyle(topColor: Color(0xFF25a09c), backColor: Color(0xFF197572));
  static const WHITE =
      ButtonFixStyle(topColor: Color(0xFFffffff), backColor: Color(0xFFCFD8DC));
  static const YELLOW =
      ButtonFixStyle(topColor: Color(0xffFFCC28), backColor: Color(0xffb68e04));
}

class ButtonFix extends StatefulWidget {
  final VoidCallback? onPressed;
  final dynamic title;
  final ButtonFixStyle style;
  final double height;
  final double? radius;
  final TextStyle? titleStyle;

  const ButtonFix({
    Key? key,
    this.onPressed,
    required this.title,
    this.style = ButtonFixStyle.RED,
    this.height = 55.0,
    this.titleStyle,
    this.radius,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => ButtonFixState();
}

class ButtonFixState extends State<ButtonFix> {
  bool isTapped = false;

  Size get size => MediaQuery.of(context).size;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Stack(
          alignment: AlignmentDirectional.topCenter,
          children: <Widget>[_buildBackLayout(), _buildTopLayout()]),
      onTapDown: (_) => _onTapDown(),
      onTapCancel: _onTapCancel,
      onTapUp: (_) => _onTapUp(),
      onTap: _onTap,
    );
  }

  void _onTap() {
    if (mounted) {
      _onTapDown();
      Future.delayed(const Duration(milliseconds: 500), () {
        _onTapUp();
        widget.onPressed?.call();
      });
    }
  }

  void _onTapDown() {
    setState(() {
      isTapped = true;
    });
  }

  void _onTapUp() {
    setState(() {
      isTapped = false;
    });
  }

  void _onTapCancel() {
    setState(() {
      isTapped = false;
    });
  }

  Widget _buildBackLayout() {
    return Padding(
      padding: EdgeInsets.only(top: widget.style.z),
      child: DecoratedBox(
        position: DecorationPosition.background,
        decoration: BoxDecoration(
            borderRadius: widget.style.borderRadius,
            boxShadow: [BoxShadow(color: widget.style.backColor)]),
        child: ConstrainedBox(
          constraints: BoxConstraints.expand(
              width: size.width, height: widget.height - widget.style.z),
        ),
      ),
    );
  }

  Widget _buildTopLayout() {
    return Padding(
      padding: EdgeInsets.only(
          top: isTapped ? widget.style.z - widget.style.tappedZ : 0.0),
      child: DecoratedBox(
        position: DecorationPosition.background,
        decoration: BoxDecoration(
            borderRadius: widget.style.borderRadius,
            boxShadow: [BoxShadow(color: widget.style.topColor)]),
        child: ConstrainedBox(
          constraints: BoxConstraints.expand(
              width: size.width, height: widget.height - widget.style.z),
          child: Container(
            padding: EdgeInsets.zero,
            alignment: Alignment.center,
            child: widget.title is Widget
                ? widget.title
                : Text(
                    '${widget.title}',
                    style: widget.titleStyle ??
                        appStyle.textTheme.subtitle1!.copyWith(
                            color: Colors.white, fontWeight: FontWeight.bold),
                  ),
          ),
        ),
      ),
    );
  }
}
