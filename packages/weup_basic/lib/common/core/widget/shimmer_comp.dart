import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerComp extends StatelessWidget {
  final Widget child;
  final Color baseColor;
  final Color highlightColor;
  final int? milliseconds, loop;
  final ShimmerDirection? direction;
  final bool? enabled;

  const ShimmerComp({
    Key? key,
    required this.child,
    required this.baseColor,
    required this.highlightColor,
    this.milliseconds,
    this.direction,
    this.enabled,
    this.loop,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      child: child,
      baseColor: baseColor,
      highlightColor: highlightColor,
      period: Duration(milliseconds: milliseconds ?? 1500),
      direction: direction ?? ShimmerDirection.ltr,
      enabled: enabled ?? true,
      loop: loop ?? 0,
    );
  }
}

class DefaultShimmerComp extends StatelessWidget {
  final Color? color;
  final Widget? child;
  final BorderRadius? radius;

  const DefaultShimmerComp({Key? key, this.color, this.child, this.radius}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: radius ?? BorderRadius.zero,
      child: Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: Container(color: Colors.grey.withOpacity(.6), child: child),
      ),
    );
  }
}
