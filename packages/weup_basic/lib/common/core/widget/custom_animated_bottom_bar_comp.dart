import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomAnimatedBottomBarComp extends StatelessWidget {
  final int selectedIndex;
  final double iconSize;
  final Color? backgroundColor;
  final bool showElevation;
  final Duration animationDuration;
  final List<BottomNavyBarItem> items;
  final ValueChanged<int> onItemSelected;
  final MainAxisAlignment mainAxisAlignment;
  final double itemCornerRadius;
  final double containerHeight;
  final Curve curve;
  final EdgeInsets? padding;

  const CustomAnimatedBottomBarComp({
    Key? key,
    this.selectedIndex = 0,
    this.showElevation = true,
    this.iconSize = 24,
    this.backgroundColor,
    this.itemCornerRadius = 20,
    this.containerHeight = 56,
    this.animationDuration = const Duration(milliseconds: 270),
    this.mainAxisAlignment = MainAxisAlignment.spaceBetween,
    required this.items,
    required this.onItemSelected,
    this.curve = Curves.linear,
    this.padding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bgColor = backgroundColor ?? Theme.of(context).bottomAppBarColor;
    return Container(
      decoration: BoxDecoration(
        color: bgColor,
        boxShadow: const <BoxShadow>[BoxShadow(color: Color.fromRGBO(0, 0, 0, .06), blurRadius: 3, offset: Offset(0, -3))],
      ),
      child: SafeArea(
        child: Container(
          width: double.infinity,
          height: containerHeight,
          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          padding: padding ?? const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
          child: Row(
            mainAxisAlignment: mainAxisAlignment,
            children: items.map<Widget>((item) {
              var index = items.indexOf(item);
              return GestureDetector(
                  onTap: () => onItemSelected(index),
                  child: _ItemWidget(
                      item: item,
                      iconSize: iconSize,
                      isSelected: index == selectedIndex,
                      backgroundColor: bgColor,
                      itemCornerRadius: itemCornerRadius,
                      animationDuration: animationDuration,
                      curve: curve));
            }).toList(),
          ),
        ),
      ),
    );
  }
}

class _ItemWidget extends StatelessWidget {
  final double iconSize;
  final bool isSelected;
  final BottomNavyBarItem item;
  final Color backgroundColor;
  final double itemCornerRadius;
  final Duration animationDuration;
  final Curve curve;

  const _ItemWidget({
    Key? key,
    required this.item,
    required this.isSelected,
    required this.backgroundColor,
    required this.animationDuration,
    required this.itemCornerRadius,
    required this.iconSize,
    this.curve = Curves.linear,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Semantics(
      container: true,
      selected: isSelected,
      child: AnimatedContainer(
        width: _getWidth,
        height: double.maxFinite,
        duration: animationDuration,
        curve: curve,
        decoration: BoxDecoration(
          color: isSelected ? item.activeColor.withOpacity(.12) : backgroundColor,
          borderRadius: BorderRadius.circular(itemCornerRadius),
        ),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          physics: const NeverScrollableScrollPhysics(),
          // padding: EdgeInsets.only(right: 10),
          child: SizedBox(
            width: _getWidth,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SvgPicture.asset(item.icon, color: Colors.white, width: 20),
                if (isSelected) ...[
                  const SizedBox(width: 8),
                  DefaultTextStyle.merge(
                    style: const TextStyle(color: Colors.white, fontSize: 13),
                    maxLines: 1,
                    overflow: TextOverflow.fade,
                    textAlign: item.textAlign,
                    child: item.title,
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }

  double get _getWidth => isSelected ? 130 : 50;
}

class BottomNavyBarItem {
  BottomNavyBarItem({
    required this.icon,
    required this.title,
    this.activeColor = Colors.white,
    this.textAlign = TextAlign.center,
    this.inactiveColor = Colors.grey,
  });

  final String icon;
  final Widget title;
  final Color activeColor;
  final Color? inactiveColor;
  final TextAlign? textAlign;
}
