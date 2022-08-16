import 'package:flutter/material.dart';

class SearchComp extends StatelessWidget {
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onFieldSubmitted;
  final String? label;
  final TextEditingController? textEditingController;
  const SearchComp(
      {Key? key,
      this.onChanged,
      this.label,
      this.textEditingController,
      this.onFieldSubmitted})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
        color: Colors.transparent,
        elevation: 12.0,
        shadowColor: Colors.grey.withOpacity(0.5),
        borderRadius: BorderRadius.circular(24),
        child: TextFormField(
          autofocus: false,
          controller: textEditingController,
          onChanged: onChanged,
          onFieldSubmitted: onFieldSubmitted,
          textInputAction: TextInputAction.search,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(vertical: 10),
            hintText: label ?? '',
            prefixIcon: const Icon(Icons.search),
            fillColor: Colors.white,
            filled: true,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(24),
              borderSide: const BorderSide(color: Colors.transparent),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(24),
              borderSide: const BorderSide(color: Colors.transparent),
            ),
          ),
        ));
  }
}
