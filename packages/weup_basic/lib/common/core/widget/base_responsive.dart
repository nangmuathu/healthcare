import 'package:flutter/material.dart';

const int largeScreenSize = 1366;
const int mediumScreenSize = 768;
const int smallScreenSize = 360;
const int customScreenSize = 1100;

class BaseResponsive extends StatelessWidget {
  final Widget? largeScreen;
  final Widget? mediumScreen;
  final Widget? smallScreen;
  final Widget? customScreen;

  const BaseResponsive({
    Key? key,
    this.largeScreen,
    this.mediumScreen,
    this.smallScreen,
    this.customScreen,
  }) : super(key: key);

  static bool isSmallScreen(BuildContext context) {
    return MediaQuery.of(context).size.width < mediumScreenSize;
  }

  static bool isMediumScreen(BuildContext context) {
    return MediaQuery.of(context).size.width >= mediumScreenSize &&
        MediaQuery.of(context).size.width < largeScreenSize;
  }

  static bool isLargeScreen(BuildContext context) {
    return MediaQuery.of(context).size.width > largeScreenSize;
  }

  static bool isCustomSize(BuildContext context) {
    return MediaQuery.of(context).size.width <= customScreenSize &&
        MediaQuery.of(context).size.width >= mediumScreenSize;
  }

  @override
  Widget build(BuildContext context) {
    // showLog('WIDTH: ' + MediaQuery.of(context).size.width.toString());
    // showLog('HEIGHT: ' + MediaQuery.of(context).size.height.toString());
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth <= smallScreenSize) {
          return smallScreen ?? const SizedBox();
        } else if (constraints.maxWidth <= mediumScreenSize) {
          return mediumScreen ?? const SizedBox();
        } else if (constraints.maxWidth <= largeScreenSize) {
          return largeScreen ?? const SizedBox();
        }
        return customScreen ?? largeScreen ?? const SizedBox();
      },
    );
  }
}
