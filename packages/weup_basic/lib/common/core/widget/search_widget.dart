import 'package:flutter/material.dart';
import 'package:weup_basic/global.dart';

class SearchWidget extends StatelessWidget {
  final String? labelText;
  final ValueChanged<String>? onChanged;
  final Function? showSearch;
  final Color? color;
  final Widget? actionsFilter;
  final String? initialValue;
  final Widget? leading;
  final FocusNode? focusNode;
  final Function()? onTap;
  final double height;
  final Color? fillColor;

  const SearchWidget(
      {Key? key,
      this.labelText,
      this.onChanged,
      this.showSearch,
      this.color,
      this.actionsFilter,
      this.initialValue,
      this.leading,
      this.onTap,
      this.focusNode,
      this.height = 36,
      this.fillColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: TextFormField(
        onTap: onTap,
        initialValue: initialValue,
        textInputAction: TextInputAction.search,
        focusNode: focusNode,
        onChanged: onChanged,
        decoration: InputDecoration(
            prefixIcon: const Icon(Icons.search_outlined, size: 18),
            filled: true,
            fillColor: fillColor ?? Colors.grey.withOpacity(0.1),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: appStyle.primaryColor),
                borderRadius: BorderRadius.circular(20)),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey.withOpacity(0.5)),
                borderRadius: BorderRadius.circular(20)),
            contentPadding: const EdgeInsets.symmetric(vertical: 8),
            border: InputBorder.none,
            hintText: labelText ?? 'Tìm kiếm...',
            hintStyle: const TextStyle(fontSize: 13)),
      ),
    );
  }
}
