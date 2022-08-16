import 'package:flutter/material.dart';
import 'package:weup_basic/global.dart';

import 'item_scale_animation_comp.dart';

class CustomRadioButton extends StatefulWidget {
  final List<String>? data;
  final List<Widget>? iconData;
  final int? value;
  final Function(int, String)? selectedCallBack;

  const CustomRadioButton({
    Key? key,
    this.data,
    this.iconData,
    this.value,
    this.selectedCallBack,
  }) : super(key: key);

  @override
  State<CustomRadioButton> createState() => _CustomRadioButtonState();
}

class _CustomRadioButtonState extends State<CustomRadioButton> {
  int? selectedIndex;

  @override
  void initState() {
    super.initState();
    if (widget.value != null) {
      selectedIndex = widget.value;
    } else {
      selectedIndex = -1;
    }
  }

  @override
  void didUpdateWidget(covariant CustomRadioButton oldWidget) {
    if (widget.value != oldWidget.value) {
      selectedIndex = widget.value;
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      childAspectRatio: 3.8,
      crossAxisSpacing: 36,
      mainAxisSpacing: 20,
      shrinkWrap: true,
      crossAxisCount: 2,
      physics: const NeverScrollableScrollPhysics(),
      children: List<Widget>.generate(widget.data!.length, (index) {
        return ItemScaleAnimationComp(
          child: AnimatedContainer(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: selectedIndex == index
                    ? appStyle.primaryColor
                    : Colors.white,
                border: Border.all(color: Colors.grey.withOpacity(0.5))),
            duration: const Duration(milliseconds: 500),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (widget.iconData != null ||
                    widget.iconData?.length == widget.data?.length) ...[
                  widget.iconData![index],
                  const SizedBox(width: 12),
                ],
                Text(widget.data![index],
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: selectedIndex == index
                            ? Colors.white
                            : Colors.black)),
              ],
            ),
          ),
          onTap: () => _onTap(index),
        );
      }),
    );
  }

  void _onTap(int index) {
    setState(() {
      selectedIndex = index;
      widget.selectedCallBack?.call(index, widget.data![index]);
    });
  }
}
