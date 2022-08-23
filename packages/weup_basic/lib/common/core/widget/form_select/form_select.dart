import 'package:weup_basic/common/core/widget/form_select/select_bottom_list.dart';
import 'package:weup_basic/common/core/widget/custom_text_input.dart';
import 'package:weup_basic/common/helper/app_common.dart';
import 'package:flutter/material.dart';

import '../../../../app/app_utils.dart';

class FormSelect<T> extends StatefulWidget {
  final String? name;
  final int? id;
  final Widget? prefixIcon;
  final List<T>? items;
  final String? hintText;
  final bool hasSearch;
  final bool hasBorder;
  final Function(dynamic)? onChanged;
  final Function? onValidator;
  final bool hasChildren;
  final bool isRequired;
  final Duration? duration;
  final EdgeInsets padding;

  const FormSelect({
    Key? key,
    this.name,
    this.prefixIcon,
    this.items,
    this.hintText,
    this.hasSearch = false,
    this.onChanged,
    this.id,
    this.hasBorder = true,
    this.onValidator,
    this.hasChildren = false,
    this.duration,
    this.padding = const EdgeInsets.symmetric(horizontal: 12),
    this.isRequired = true,
  }) : super(key: key);

  @override
  State<FormSelect> createState() => _FormSelectState<T>();
}

class _FormSelectState<T> extends State<FormSelect>
    with SingleTickerProviderStateMixin<FormSelect> {
  late String _value;
  late String _hintText;
  int? _id;

  late AnimationController controller;

  @override
  void initState() {
    _value = widget.name ?? '';
    _hintText = widget.hintText ?? '';
    _id = widget.id;
    controller = BottomSheet.createAnimationController(this)
      ..duration = widget.duration ?? const Duration(milliseconds: 500)
      ..reverseDuration = widget.duration ?? const Duration(milliseconds: 400);
    _getName();
    super.initState();
  }

  @override
  void didUpdateWidget(covariant FormSelect oldWidget) {
    if (oldWidget.name != widget.name) _value = widget.name ?? '';
    if (oldWidget.id != widget.id) _id = widget.id;
    if ((widget.hintText != null || widget.hintText != '') &&
        oldWidget.hintText != widget.hintText) {
      _hintText = widget.hintText!;
    }
    _getName();
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AbsorbPointer(
        child: Container(
          // padding: widget.padding.copyWith(bottom: 5, top: 5),
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(12)),
          child: CustomTextInput(
            suffixIcon: const Padding(
              padding: EdgeInsets.only(right: 32.0, bottom: 8),
              child: Center(
                  child: Icon(Icons.keyboard_arrow_down_outlined, size: 24)),
            ),
            value: _value,
            hint: _hintText,
            prefixIcon: widget.prefixIcon,
            isRequired: widget.isRequired,
            hasBorder: widget.hasBorder,
            onValidator: widget.onValidator,
          ),
        ),
      ),
    );
  }

  void _getName() {
    if (!empty(widget.id) && !empty(widget.items)) {
      widget.items?.forEach((element) {
        if (element.id == widget.id) _value = element.name;
      });
    }
  }

  void onTap() {
    ViewUtils.hideKeyboard(context: context);
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      transitionAnimationController: controller,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(15))),
      builder: (_) => SelectBottomList<T>(
        value: _value,
        hintText: widget.hintText,
        prefixIcon: widget.prefixIcon,
        hasSearch: widget.hasSearch,
        items: widget.items as List<T>,
        onChanged: widget.onChanged,
        id: _id,
        hasChildren: widget.hasChildren,
      ),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
