import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../../app/app_utils.dart';
import '../../../resource/image_resource.dart';

class CachedNetworkImageComp extends StatelessWidget {
  final double? width;
  final double? height;
  final String url;
  final String borderStyle;
  final Widget? placeholder, error;
  final Color? backgroundColor;
  final double borderWidth;
  final Color borderColor;
  final double? borderRadius;
  final BoxFit fit;

  const CachedNetworkImageComp({
    Key? key,
    required this.url,
    this.width,
    this.height,
    this.borderStyle = 'all',
    this.placeholder,
    this.backgroundColor,
    this.borderWidth = 0,
    this.borderColor = Colors.transparent,
    this.error,
    this.borderRadius,
    this.fit = BoxFit.contain,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      key: ValueKey('CachedNetworkImageComp-${empty(url)}_$url'),
      borderRadius: BorderRadius.circular(borderRadius ?? 0),
      child: CachedNetworkImage(
        imageUrl: url,
        fit: fit,
        placeholder: (_, __) =>
            placeholder ??
            Container(
              alignment: Alignment.center,
              width: width,
              height: height,
              decoration: BoxDecoration(
                  border: Border.all(width: borderWidth, color: borderColor),
                  image: const DecorationImage(
                      image: AssetImage(ImageResource.imgDefault),
                      fit: BoxFit.cover)),
            ),
        errorWidget: (_, __, ___) =>
            error ??
            Container(
              width: width,
              height: height,
              decoration: BoxDecoration(
                  border: Border.all(width: borderWidth, color: borderColor),
                  color: Colors.grey.withOpacity(0.47),
                  image: const DecorationImage(
                      image: AssetImage(ImageResource.imgDefault),
                      fit: BoxFit.cover)),
            ),
        imageBuilder: (context, imageProvider) => Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
              color: backgroundColor,
              border: Border.all(width: borderWidth, color: borderColor),
              image: DecorationImage(image: imageProvider, fit: BoxFit.cover)),
        ),
      ),
    );
  }
}
