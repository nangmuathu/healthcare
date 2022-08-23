import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:weup_basic/common/extension/app_extension.dart';

import '../../../../app/app_utils.dart';
import '../../../../global.dart';
import '../../../resource/svg_resource.dart';
import '../item_scale_animation_comp.dart';
import '../no_data_comp.dart';
import '../search_widget.dart';

class SelectBottomList<T> extends StatefulWidget {
  final String? value;
  final int? id;
  final Widget? prefixIcon;
  final List<T>? items;
  final String? hintText;
  final bool hasSearch;
  final bool hasChildren;
  final Function(dynamic)? onChanged;

  const SelectBottomList(
      {Key? key,
      this.value,
      this.prefixIcon,
      this.items,
      this.hintText,
      this.hasSearch = false,
      this.onChanged,
      this.id,
      required this.hasChildren})
      : super(key: key);

  @override
  State<SelectBottomList> createState() => SelectBottomListState<T>();
}

class SelectBottomListState<T> extends State<SelectBottomList> {
  int? _id;

  late FocusNode _node;
  bool hasFull = false;

  late ValueNotifier<List> _items;

  @override
  void initState() {
    _id = widget.id;
    _items = ValueNotifier(widget.items as List);
    _node = FocusNode()
      ..addListener(() {
        if (_node.hasFocus) {
          hasFull = true;
          return;
        }
        hasFull = false;
      });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      heightFactor: !hasFull ? .6 : .9,
      child: Column(
        children: [
          Container(
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
                color: Colors.white),
            padding: const EdgeInsets.only(left: 10, top: 5, bottom: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('${widget.hintText}',
                    style: appStyle.textTheme.subtitle1!
                        .copyWith(fontSize: 18, fontWeight: FontWeight.w500)),
                IconButton(
                    onPressed: context.pop,
                    icon: const Icon(Icons.cancel_outlined))
              ],
            ),
          ),
          if (widget.hasSearch) ...[
            Container(
              color: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 10)
                  .copyWith(bottom: 10),
              child: SearchWidget(
                  focusNode: _node, height: 45, onChanged: _onSearch),
            ),
          ],
          if (!empty(_items.value))
            ValueListenableBuilder<List>(
              valueListenable: _items,
              builder: (_, val, __) {
                return Expanded(
                  child: ListView.separated(
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: 10),
                    padding:
                        const EdgeInsets.only(top: 15, left: 10, right: 10),
                    itemCount: val.isEmpty ? 0 : val.length,
                    itemBuilder: (context, index) {
                      final _v = val[index];
                      return ItemScaleAnimationComp(
                        onTap: () => _onTap(_v),
                        child: ListTile(
                          onTap: () => _onTap(_v),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                              side: BorderSide(
                                  color: (_id == _v.id)
                                      ? appStyle.primaryColor
                                      : Colors.transparent)),
                          contentPadding:
                              const EdgeInsets.symmetric(horizontal: 10),
                          tileColor: const Color(0xffF3F1F1),
                          title: Text('${_v.name ?? ''}'),
                          trailing: (_id == _v.id)
                              ? SvgPicture.asset(SvgResource.checkCirle)
                              : (widget.hasChildren &&
                                      (_v.numberChildren != null &&
                                          _v.numberChildren != 0)
                                  ? const Icon(Icons.keyboard_arrow_right)
                                  : const SizedBox.shrink()),
                        ),
                      );
                    },
                  ),
                );
              },
            )
          else
            Expanded(
                child: NoDataComp(icon: SvgPicture.asset(SvgResource.noData))),
          const SizedBox(height: 10),
        ],
      ),
    );
  }

  void _onTap(dynamic v) async {
    _id = v.id;
    await Future.delayed(
        const Duration(milliseconds: 400), () => context.pop());
    if (widget.onChanged != null) widget.onChanged!.call(v);
  }

  void _onSearch(String val) {
    if (empty(val)) {
      _items.value = widget.items as List;
      return;
    }
    _items.value = _items.value
        .where((element) => element.name.toString().search(val))
        .toList();
  }

  @override
  void dispose() {
    _node.dispose();
    _items.dispose();
    super.dispose();
  }
}
