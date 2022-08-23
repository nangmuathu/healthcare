import 'package:flutter/material.dart';
import 'package:weup_basic/common/core/widget/image/image_cache_comp.dart';

import '../../../app/app_utils.dart';

class AvatarComp extends StatefulWidget {
  final String fullName;
  final dynamic image;
  final double width;
  final double? radius;
  final Color? color;

  const AvatarComp(this.fullName,
      {this.image, this.width = 40, this.radius, this.color, Key? key})
      : super(key: key);

  @override
  State<AvatarComp> createState() => _AvatarCompState();
}

class _AvatarCompState extends State<AvatarComp> {
  Widget? _imageWidget;
  late String _first;
  late Color _color;
  late double _fontSize;
  late List<dynamic> _images;
  late String _image;

  @override
  void didChangeDependencies() {
    _initAvatar();
    super.didChangeDependencies();
  }

  void _initAvatar() {
    _first = (!empty(widget.fullName))
        ? (widget.fullName.split(' ').isNotEmpty
            ? widget.fullName.trim().split(' ').last[0]
            : widget.fullName)
        : '';
    _color = widget.color ?? _convertColor(_first);
    _fontSize = widget.width / 2;
    _image = !empty(widget.image) && widget.image is String ? widget.image : '';
    if (!empty(widget.image) && (widget.image is Map || widget.image is List)) {
      _images =
          (widget.image is Map) ? widget.image.values.toList() : widget.image;
      if (_images.length == 1) {
        _image = !empty(_images[0]) ? _images[0] : '';
      } else {
        _imageWidget = Stack(
          alignment: Alignment.bottomRight,
          children: <Widget>[
            SizedBox(width: widget.width, height: widget.width),
            Positioned(
                top: 0,
                right: 0,
                child: Container(
                    padding: const EdgeInsets.all(1),
                    decoration: BoxDecoration(
                        color: Theme.of(context).cardColor,
                        borderRadius: BorderRadius.all(
                            Radius.circular(widget.radius ?? widget.width))),
                    child: AvatarComp(
                      '',
                      image: _images[0],
                      width:
                          widget.width * ((_images.length > 2) ? 0.55 : 0.65),
                    ))),
            if (_images.length > 2)
              Positioned(
                  top: 0,
                  left: 0,
                  child: Container(
                      padding: const EdgeInsets.all(1),
                      decoration: BoxDecoration(
                          color: Theme.of(context).cardColor,
                          borderRadius: BorderRadius.all(
                              Radius.circular(widget.radius ?? widget.width))),
                      child: AvatarComp('',
                          image: _images[0], width: widget.width * 0.4))),
            Positioned(
                bottom: 0,
                left: 0,
                child: Container(
                    padding: const EdgeInsets.all(1),
                    decoration: BoxDecoration(
                        color: Theme.of(context).cardColor,
                        borderRadius: BorderRadius.all(
                            Radius.circular(widget.radius ?? widget.width))),
                    child: AvatarComp('',
                        image: _images[1], width: widget.width * 0.65))),
          ],
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_imageWidget != null) return _imageWidget!;
    return ClipRRect(
      borderRadius:
          BorderRadius.all(Radius.circular(widget.radius ?? (widget.width))),
      child: SizedBox(
          width: widget.width,
          height: widget.width,
          child: AspectRatio(
            aspectRatio: 1.0,
            child: _imageWidget ??
                Container(
                  color: (!empty(_image)) ? _color : null,
                  child: Center(
                    child: !empty(_image)
                        ? ImageCacheComp(
                            url: _image,
                            width: widget.width,
                            fit: BoxFit.cover,
                            height: widget.width)
                        : Text(
                            _first.toUpperCase(),
                            style: TextStyle(
                                fontSize: _fontSize,
                                fontWeight: FontWeight.w600,
                                color: Colors.white),
                          ),
                  ),
                ),
          )),
    );
  }

  Color _convertColor(String firstText) {
    switch (firstText.toUpperCase()) {
      case 'Q':
        return const Color(0xff7e57c2);
      case 'W':
        return const Color(0xfff06292);
      case 'E':
        return const Color(0xffab47bc);
      case 'R':
        return const Color(0xffef5350);
      case 'T':
        return const Color(0xff03a9f4);
      case 'Y':
        return const Color(0xff00acc1);
      case 'U':
        return const Color(0xff8bc34a);
      case 'I':
        return const Color(0xff66bb6a);
      case 'O':
        return const Color(0xff26a69a);
      case 'P':
        return const Color(0xffffa726);
      case 'A':
        return const Color(0xffffca28);
      case 'S':
        return const Color(0xffff7043);
      case 'D':
        return const Color(0xff8d6e63);
      case 'F':
        return const Color(0xff29b6f6);
      case 'G':
        return const Color(0xff42a5f5);
      case 'H':
        return const Color(0xffa1887f);
      case 'J':
        return const Color(0xff7e57c2);
      case 'K':
        return const Color(0xfff06292);
      case 'L':
        return const Color(0xffab47bc);
      case 'Z':
        return const Color(0xffef5350);
      case 'X':
        return const Color(0xff03a9f4);
      case 'C':
        return const Color(0xff00acc1);
      case 'V':
        return const Color(0xff8bc34a);
      case 'B':
        return const Color(0xff66bb6a);
      case 'N':
        return const Color(0xff26a69a);
      case 'M':
        return const Color(0xffffa726);
      case 'Đ':
        return const Color(0xffffca28);
      case 'Ô':
        return const Color(0xffff7043);
      case 'Ơ':
        return const Color(0xff8d6e63);
      case 'Ă':
        return const Color(0xff29b6f6);
      case 'Ê':
        return const Color(0xff42a5f5);
      default:
        return Colors.blue;
    }
  }
}
