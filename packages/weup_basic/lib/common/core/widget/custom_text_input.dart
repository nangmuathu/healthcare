import 'package:weup_basic/common/core/app_core.dart';
import 'package:weup_basic/common/helper/app_common.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../global.dart';

class CustomTextInput extends StatefulWidget {
  final Widget? prefixIcon, suffixIcon;
  final TextInputType? inputType;
  final TextInputAction? inputAction;
  final TextStyle? style, hintStyle, labelStyle;
  final String? label;
  final String? hint;
  final String? error;
  final Function()? onTap;
  final Function(String value)? onChange;
  final Function(String value)? onFieldSubmitted;
  final Function()? onComplete;
  final Function? onValidator;

  final int? minLine, maxLines;
  final TextCapitalization? capitalization;
  final Color? backgroundColor;
  final Color? borderColor;
  final bool? enable;
  final List<TextInputFormatter>? inputFormatters;

  final bool? isDoubleNum;
  final bool? isReadOnly;
  final bool hasBorder;

  final bool? isInvisiblePassword;
  final bool isRequired;
  final String? value;
  final int? hintMaxLines;

  const CustomTextInput({
    Key? key,
    this.prefixIcon,
    this.suffixIcon,
    this.inputType,
    this.isInvisiblePassword = false,
    this.hint,
    this.onChange,
    this.onComplete,
    this.onTap,
    this.isReadOnly,
    this.minLine,
    this.maxLines,
    this.capitalization,
    this.backgroundColor,
    this.borderColor,
    this.inputAction,
    this.error,
    this.label,
    this.enable,
    this.inputFormatters,
    this.hintStyle,
    this.onValidator,
    this.style,
    this.isDoubleNum,
    this.onFieldSubmitted,
    this.labelStyle,
    this.isRequired = false,
    this.value,
    this.hintMaxLines,
    this.hasBorder = true,
  }) : super(key: key);

  @override
  State<CustomTextInput> createState() => _CustomTextInputState();
}

class _CustomTextInputState extends State<CustomTextInput> {
  bool obscureText = false;
  String? _value;
  Widget? suffixIcon = const SizedBox();

  TextEditingController? textEditingController;

  @override
  void initState() {
    _value = widget.value;
    textEditingController = TextEditingController(text: _value);
    suffixIcon = widget.suffixIcon;
    if (widget.isInvisiblePassword!) {
      obscureText = true;
      suffixIcon = InkWellComp(
          isTransparent: true,
          onTap: _changeObscure,
          child: const Icon(
            Icons.remove_red_eye,
            size: 24,
          ));
    }
    super.initState();
  }

  @override
  void didUpdateWidget(covariant CustomTextInput oldWidget) {
    if (oldWidget.value != widget.value) {
      _value = widget.value;
      Future.delayed(Duration.zero, () {
        textEditingController?.text = _value ?? '';
      });
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
      child: TextFormField(
        // key: ValueKey('CustomTextInput......$_value'),
        // initialValue: _value,
        controller: textEditingController,
        enabled: widget.enable ?? true,
        obscureText: obscureText,
        obscuringCharacter: '●',
        onChanged: widget.onChange,
        validator: (value) => widget.onValidator?.call(value),
        onEditingComplete: () => widget.onComplete,
        onTap: () => widget.onTap,
        onFieldSubmitted: _onFieldSubmitted,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        inputFormatters: widget.inputFormatters ??
            ((widget.inputType == TextInputType.number)
                ? (!widget.isDoubleNum!
                    ? [FilteringTextInputFormatter.digitsOnly]
                    : [FilteringTextInputFormatter.allow(RegExp(r'[0-9.]'))])
                : []),
        textCapitalization:
            widget.capitalization ?? TextCapitalization.sentences,
        textInputAction: widget.inputAction ?? TextInputAction.next,
        minLines: widget.minLine ?? 1,
        maxLines: widget.maxLines ?? 1,
        keyboardType: widget.inputType,
        textAlignVertical: TextAlignVertical.center,
        readOnly: widget.isReadOnly ?? false,
        style: widget.style ?? appStyle.textTheme.bodyText1,
        decoration: _decoration(),
      ),
    );
  }

  void _onFieldSubmitted(String val) {
    ViewUtils.hideKeyboard(context: context);
    widget.onFieldSubmitted?.call(val);
  }

  InputDecoration _decoration() {
    return InputDecoration(
      hintText: widget.hint,
      labelText: widget.label ?? widget.hint,
      labelStyle: widget.labelStyle,
      hintMaxLines: widget.hintMaxLines,
      filled: widget.isReadOnly,
      fillColor: const Color(0xffeaeaea).withOpacity(.5),
      prefixIconConstraints: const BoxConstraints(minHeight: 20, minWidth: 36),
      suffixIconConstraints: const BoxConstraints(maxHeight: 20, maxWidth: 40),
      suffixIcon: suffixIcon,
      prefixIcon: widget.prefixIcon != null
          ? Container(
              margin: const EdgeInsets.symmetric(horizontal: 10),
              child: Stack(
                children: [
                  Container(
                    margin: const EdgeInsets.only(right: 15),
                    child: widget.prefixIcon,
                  ),
                  if (widget.isRequired)
                    Positioned(
                      top: -3,
                      right: 5,
                      child: Text(
                        '*',
                        style:
                            TextStyle(color: appStyle.errorColor, fontSize: 15),
                      ),
                    )
                ],
              ),
            )
          : null,
      enabledBorder: widget.hasBorder
          ? UnderlineInputBorder(
              borderSide:
                  BorderSide(color: Colors.black87.withOpacity(.32), width: .5),
              borderRadius: BorderRadius.circular(10),
            )
          : InputBorder.none,
      focusedBorder: widget.hasBorder
          ? UnderlineInputBorder(
              borderSide:
                  BorderSide(color: Colors.black87.withOpacity(.32), width: .5),
              borderRadius: BorderRadius.circular(10),
            )
          : InputBorder.none,
      border: widget.hasBorder
          ? UnderlineInputBorder(
              borderSide:
                  BorderSide(color: Colors.black87.withOpacity(.32), width: .5),
              borderRadius: BorderRadius.circular(10),
            )
          : InputBorder.none,
      errorBorder: UnderlineInputBorder(
        borderSide: const BorderSide(color: Colors.red, width: .5),
        borderRadius: BorderRadius.circular(10),
      ),
      errorText: widget.error,
    );
  }

  void _changeObscure() {
    setState(() {
      obscureText = !obscureText;
      suffixIcon = InkWellComp(
          isTransparent: true,
          onTap: _changeObscure,
          child: Icon(
            obscureText ? Icons.remove_red_eye : Icons.visibility_off,
            size: 24,
          ));
    });
  }

  @override
  void dispose() {
    textEditingController?.dispose();
    super.dispose();
  }
}
