import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:weup_basic/global.dart';

import 'ink_well_comp.dart';

class TextFieldComp extends StatefulWidget {
  final Widget? prefixIcon, suffixIcon;
  final FocusNode? focusNode;
  final TextInputType? inputType;
  final TextInputAction? inputAction;
  final TextEditingController? editingController;
  final TextStyle? style, hintStyle, labelStyle;
  final String? label;
  final String? hint;
  final String? error;
  final Function()? onTap;
  final Function()? onEnter;
  final Function(String value)? onChange;
  final Function(String value)? onFieldSubmitted;
  final Function(String value)? onSave;
  final Function? onValidator;

  final int? minLine, maxLines, maxLength;
  final double? padH, padV, borderRadius;
  final TextCapitalization? capitalization;
  final TextAlign? textAlign;
  final Color? borderColor;
  final Color? fillColor;
  final Color? colorIconPassWord;
  final Color? cursorColor;

  final BoxConstraints? suffixConstraint, prefixConstraint;
  final InputBorder? enabledBorder,
      focusedBorder,
      disableBorder,
      errorBorder,
      focusedErrorBorder;
  final EdgeInsetsGeometry? contentPadding;
  final List<TextInputFormatter>? inputFormatters;

  final double? paddingSuffixIcon;
  final double? paddingPrefixIcon;
  final bool isBorder;
  final bool? isUnderLine;
  final bool? isDoubleNum;
  final bool? isReadOnly;
  final bool? autofocus;
  final bool? enable;
  final bool? showCursor;
  final bool? isInvisiblePassword;

  const TextFieldComp({
    Key? key,
    this.prefixIcon,
    this.suffixIcon,
    this.focusNode,
    this.onEnter,
    this.inputType,
    this.isInvisiblePassword = false,
    this.editingController,
    this.hint,
    this.onChange,
    this.onTap,
    this.isReadOnly,
    this.minLine,
    this.showCursor = true,
    this.maxLines,
    this.padH,
    this.padV,
    this.autofocus,
    this.textAlign,
    this.capitalization,
    this.borderColor,
    this.suffixConstraint,
    this.focusedErrorBorder,
    this.errorBorder,
    this.disableBorder,
    this.fillColor,
    this.inputAction,
    this.error,
    this.label,
    this.enable,
    this.borderRadius,
    this.contentPadding,
    this.inputFormatters,
    this.hintStyle,
    this.onValidator,
    this.prefixConstraint,
    this.style,
    this.isDoubleNum = false,
    this.onFieldSubmitted,
    this.paddingSuffixIcon,
    this.paddingPrefixIcon,
    this.isBorder = false,
    this.enabledBorder,
    this.focusedBorder,
    this.isUnderLine = true,
    this.labelStyle,
    this.colorIconPassWord,
    this.maxLength,
    this.cursorColor,
    this.onSave,
  }) : super(key: key);

  @override
  State<TextFieldComp> createState() => _TextFieldCompState();
}

class _TextFieldCompState extends State<TextFieldComp>
    with AutomaticKeepAliveClientMixin {
  bool obscureText = false;
  Widget? suffixIcon = const SizedBox();
  FocusNode focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    suffixIcon = widget.suffixIcon;
    if (widget.isInvisiblePassword!) {
      obscureText = true;
      suffixIcon = InkWellComp(
          isTransparent: true,
          onTap: _changeObscure,
          child: const Icon(
            Icons.remove_red_eye_outlined,
            size: 24,
          ));
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Theme(
      data: ThemeData(
        colorScheme: ThemeData().colorScheme.copyWith(
              primary: widget.colorIconPassWord,
            ),
      ),
      child: TextFormField(
        focusNode: widget.focusNode,
        cursorColor: widget.cursorColor ?? appStyle.primaryColor,
        maxLength: widget.maxLength,
        controller: widget.editingController,
        enabled: widget.enable ?? true,
        obscureText: obscureText,
        onChanged: widget.onChange,
        validator: (value) => widget.onValidator?.call(value),
        onTap: widget.onTap,
        onSaved: (value) {
          log('Save');
        },
        showCursor: widget.showCursor,
        textAlign: widget.textAlign ?? TextAlign.start,
        autofocus: widget.autofocus ?? false,
        onFieldSubmitted: (value) => widget.onFieldSubmitted?.call(value),
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
        maxLines: widget.maxLines ?? widget.minLine ?? 1,
        keyboardType: widget.inputType,
        textAlignVertical: TextAlignVertical.center,
        readOnly: widget.isReadOnly ?? false,
        style: widget.style ?? appStyle.textTheme.bodyText1,
        decoration: inputDecoration(),
      ),
    );
  }

  InputDecoration inputDecoration() => InputDecoration(
        counter: widget.maxLength != null ? const Offstage() : null,
        errorStyle: appStyle.textTheme.bodyText2?.apply(color: Colors.red),
        filled: true,
        fillColor: widget.fillColor,
        labelText: widget.label,
        labelStyle: widget.labelStyle,
        alignLabelWithHint: true,
        hintText: widget.hint,
        hintStyle: (widget.hintStyle ?? appStyle.textTheme.bodyText2),
        contentPadding: widget.contentPadding ??
            EdgeInsets.symmetric(
              vertical: widget.padV ?? 16,
              horizontal: widget.padH ?? 12,
            ),
        isDense: true,
        prefixIcon: widget.prefixIcon,
        suffixIcon: suffixIcon,
        prefixIconConstraints: BoxConstraints(
          minWidth: widget.paddingPrefixIcon ?? 36,
          minHeight: widget.paddingPrefixIcon ?? 36,
        ),
        suffixIconConstraints: BoxConstraints(
          minWidth: widget.paddingSuffixIcon ?? 36,
          minHeight: widget.paddingSuffixIcon ?? 36,
        ),
        enabledBorder: widget.isBorder
            ? widget.enabledBorder ??
                OutlineInputBorder(
                  borderSide: BorderSide(
                      width: 1, color: widget.borderColor ?? Colors.grey),
                  borderRadius: BorderRadius.all(
                    Radius.circular(widget.borderRadius ?? 8),
                  ),
                )
            : widget.isUnderLine!
                ? null
                : InputBorder.none,
        focusedBorder: widget.isBorder
            ? widget.focusedBorder ??
                OutlineInputBorder(
                  borderSide: BorderSide(
                    width: 1,
                    color: appStyle.primaryColor,
                  ),
                  borderRadius: BorderRadius.all(
                    Radius.circular(widget.borderRadius ?? 8),
                  ),
                )
            : widget.isUnderLine!
                ? null
                : InputBorder.none,
        errorBorder: widget.isBorder
            ? widget.errorBorder ??
                OutlineInputBorder(
                  borderSide: const BorderSide(width: 1, color: Colors.red),
                  borderRadius: BorderRadius.all(
                    Radius.circular(widget.borderRadius ?? 8),
                  ),
                )
            : widget.isUnderLine!
                ? null
                : InputBorder.none,
        focusedErrorBorder: widget.isBorder
            ? widget.focusedErrorBorder ??
                OutlineInputBorder(
                  borderSide: const BorderSide(width: 1, color: Colors.red),
                  borderRadius: BorderRadius.all(
                    Radius.circular(widget.borderRadius ?? 8),
                  ),
                )
            : widget.isUnderLine!
                ? null
                : InputBorder.none,
      );

  void _changeObscure() {
    obscureText = !obscureText;

    suffixIcon = InkWellComp(
        isTransparent: true,
        onTap: _changeObscure,
        child: Icon(
          obscureText
              ? Icons.remove_red_eye_outlined
              : Icons.visibility_off_outlined,
          size: 24,
        ));
    setState(() {});
  }

  @override
  bool get wantKeepAlive => true;
}
