import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class RatingComp extends StatefulWidget {
  final double? itemSize;
  final double? space;
  final double? initialRating;
  final int? itemCount;
  final Color? color;
  final Color? unratedColor;
  final ValueChanged<double>? onChanged;
  final MainAxisAlignment? mainAxisAlignment;

  const RatingComp({
    Key? key,
    this.itemSize = 16,
    this.space = 5.0,
    this.initialRating = 0,
    this.itemCount = 5,
    this.color,
    this.unratedColor,
    this.onChanged,
    this.mainAxisAlignment,
  })
      : super(key: key);

  @override
  _RatingCompState createState() => _RatingCompState();
}

class _RatingCompState extends State<RatingComp> {
  late double initialRating;

  @override
  void initState() {
    initialRating = widget.initialRating ?? 0;
    super.initState();
  }

  @override
  void didUpdateWidget(covariant RatingComp oldWidget) {
    if (oldWidget.initialRating != widget.initialRating) {
      initialRating = widget.initialRating ?? 0;
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
        mainAxisAlignment: widget.mainAxisAlignment ?? MainAxisAlignment.start,
        children: List<Widget>.generate(
            widget.itemCount!,
                (i) => Padding(
              padding: EdgeInsets.only(right: (widget.itemCount! == i) ? 0 : widget.space!),
              child: InkWell(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onTap: (widget.onChanged != null)
                    ? () async {
                  setState(() {
                    initialRating = double.tryParse((i + 1).toString())!;
                  });
                  widget.onChanged!(i + 1);
                } : null,
                child: SvgPicture.asset(
                  'assets/icons/ic_rating_doctor${initialRating < (i + 1) ? '_grey' : ''}.svg',
                  height: widget.itemSize,
                  color: initialRating < (i + 1) ? (widget.unratedColor ?? Colors.grey.shade300) : widget.color,
                ),
              ),
            )).toList());
  }
}
