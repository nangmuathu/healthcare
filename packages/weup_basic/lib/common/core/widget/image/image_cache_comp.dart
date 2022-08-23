import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:weup_basic/common/core/app_core.dart';
import '../../../../app/app_utils.dart';
import '../../../resource/image_resource.dart';

class ImageCacheComp extends StatefulWidget {
  final String url;
  final BoxFit? fit;
  final Widget? errorWidget;
  final Widget? placeholder;
  final double? ratio;
  final double? width;
  final double? height;
  final LoadingErrorWidgetBuilder? errorBuilder;
  final String? imageThumbnail;

  const ImageCacheComp(
      {Key? key,
      required this.url,
      this.fit,
      this.errorWidget,
      this.placeholder,
      this.ratio,
      this.width,
      this.height,
      this.errorBuilder,
      this.imageThumbnail})
      : super(key: key);

  @override
  State<ImageCacheComp> createState() => _ImageCacheCompState();
}

class _ImageCacheCompState extends State<ImageCacheComp> {
  Widget? _imgWidget;
  int _retry = 3;

  @override
  Widget build(BuildContext context) {
    _imgWidget = _ImageCacheNetwork(widget.url,
        key: ValueKey('${widget.url}--$_retry'),
        width: widget.width,
        height: widget.height,
        imageThumbnail: widget.imageThumbnail,
        aspectRatio: widget.ratio,
        fit: widget.fit,
        placeholder: widget.placeholder,
        errorWidget: widget.errorWidget,
        errorBuilder: widget.errorBuilder ??
            (_, __, ___) {
              Future.delayed(const Duration(seconds: 2), () {
                if (mounted && _retry > 0) {
                  setState(() {
                    _retry--;
                  });
                }
              });
              return widget.errorWidget ??
                  Container(
                      color: Colors.grey.shade300,
                      child: Center(
                          child: (_retry == 0)
                              ? const Icon(Icons.error_outline)
                              : const SizedBox(
                                  width: 10,
                                  height: 10,
                                  child: CircularProgressIndicator(
                                      strokeWidth: 2))));
            });
    return _imgWidget!;
  }
}

class _ImageCacheNetwork extends StatelessWidget {
  final String? image;
  final double? width;
  final double? height;
  final double? aspectRatio;
  final String? imageThumbnail;
  final BoxFit? fit;
  final Widget? errorWidget;
  final Widget? placeholder;
  final ProgressIndicatorBuilder? progressIndicatorBuilder;
  final LoadingErrorWidgetBuilder? errorBuilder;

  const _ImageCacheNetwork(this.image,
      {Key? key,
      this.errorBuilder,
      this.width,
      this.height,
      this.aspectRatio,
      this.imageThumbnail,
      this.fit,
      this.errorWidget,
      this.placeholder,
      this.progressIndicatorBuilder})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      key: ValueKey('ImageCacheNetwork$image'),
      imageUrl: image!,
      width: width,
      height: height,
      fit: fit,
      progressIndicatorBuilder: progressIndicatorBuilder ??
          (_, __, process) {
            if (placeholder != null) return placeholder!;
            if (imageThumbnail == null) {
              if (empty(width) || empty(height)) {
                if (process.progress != null) {
                  return SizedBox(
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        AspectRatio(
                            aspectRatio: aspectRatio ?? 3 / 2,
                            child: Image.asset(ImageResource.imgDefault,
                                width: double.infinity, fit: BoxFit.cover)),
                        Padding(
                            padding: const EdgeInsets.all(7.0),
                            child:
                                Text('${(process.progress! * 100).ceil()}%')),
                      ],
                    ),
                  );
                }
                return AspectRatio(
                  aspectRatio: aspectRatio ?? 3 / 2,
                  child: Container(
                    color: Colors.grey.withOpacity(0.2),
                    width: double.infinity,
                    height: double.infinity,
                    padding: const EdgeInsets.all(10),
                    child: Center(
                      child: Container(
                        constraints: const BoxConstraints(maxWidth: 50),
                        child: const AspectRatio(
                            aspectRatio: 1,
                            child: SizedBox(
                                width: 10,
                                height: 10,
                                child:
                                    CircularProgressIndicator(strokeWidth: 2))),
                      ),
                    ),
                  ),
                );
              }
              return Container(
                  color: Colors.grey.withOpacity(0.2),
                  width: width,
                  height: height,
                  padding: const EdgeInsets.all(10),
                  child: Center(
                      child: Container(
                          constraints: const BoxConstraints(maxWidth: 50),
                          child: const AspectRatio(
                              aspectRatio: 1,
                              child:
                                  CircularProgressIndicator(strokeWidth: 2)))));
            }
            return Image.network(imageThumbnail!,
                width: width, height: height, fit: BoxFit.cover);
          },
      errorWidget: errorBuilder ??
          (context, url, error) =>
              errorWidget ??
              const DefaultShimmerComp(
                  child: Center(child: Icon(Icons.error_outline))),
    );
  }
}
