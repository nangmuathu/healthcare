import 'package:flutter/material.dart';

class FormNumber extends StatefulWidget {
  final int value;
  final ValueChanged<int> onChanged;
  final int min;
  final int max;
  final Widget? child;

  const FormNumber({
    Key? key,
    required this.value,
    required this.onChanged,
    this.min = 0,
    required this.max,
    this.child,
  })  : assert(value < 0 || value > min, 'Giá trị phải lớn hơn min hoặc phải là số nguyên'),
        super(key: key);

  @override
  State<FormNumber> createState() => _FormNumberState();
}

class _FormNumberState extends State<FormNumber> {
  late ValueNotifier<int> _valueNotifier;

  @override
  void initState() {
    _valueNotifier = ValueNotifier(widget.value);
    super.initState();
  }

  @override
  void didUpdateWidget(covariant FormNumber oldWidget) {
    if (oldWidget.value != widget.value) {
      _valueNotifier = ValueNotifier(widget.value);
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(child: widget.child != null ? widget.child! : const SizedBox.shrink()),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            _Action(icon: Icons.remove, onChanged: _onMinus),
            const SizedBox(width: 8),
            ValueListenableBuilder<int>(valueListenable: _valueNotifier, builder: (_, val, __) => Text('$val')),
            const SizedBox(width: 8),
            _Action(icon: Icons.add, onChanged: _onAdd),
          ],
        )
      ],
    );
  }

  void _onMinus() {
    if (_valueNotifier.value > widget.min) {
      _valueNotifier.value--;
      widget.onChanged(_valueNotifier.value);
    }
  }

  void _onAdd() {
    if (_valueNotifier.value >= widget.min && _valueNotifier.value < widget.max) {
      _valueNotifier.value++;
      widget.onChanged(_valueNotifier.value);
    }
  }
}

class _Action extends StatelessWidget {
  final VoidCallback? onChanged;
  final IconData icon;

  const _Action({Key? key, this.onChanged, required this.icon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: onChanged,
        child: Container(
            padding: const EdgeInsets.all(2),
            decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.grey.withOpacity(.5),
                ),
                borderRadius: BorderRadius.circular(8)),
            child: Icon(icon, size: 16)));
  }
}
