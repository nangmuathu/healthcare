import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../../../../global.dart';
import '../../../helper/view_utils.dart';

class DatePickerComp extends StatelessWidget {
  final DateRangePickerView? view;
  final DateRangePickerSelectionMode? selectionMode;
  final List? banDate;
  final DateTime? minDate;
  final DateTime? maxDate;
  final bool? allowViewNavigation;
  final bool? enablePastDates;
  final DateTime? value;

  const DatePickerComp({
    Key? key,
    this.view,
    this.allowViewNavigation,
    this.selectionMode,
    this.banDate,
    this.minDate,
    this.maxDate,
    this.enablePastDates,
    this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        vertical: ViewUtils.height * 0.21,
        horizontal: ViewUtils.width * 0.05,
      ),
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
          color: appStyle.backgroundColor,
          borderRadius: BorderRadius.circular(12)),
      child: SfDateRangePicker(
        view: view ?? DateRangePickerView.month,
        allowViewNavigation: allowViewNavigation ?? false,
        showActionButtons: true,
        selectionMode: selectionMode ?? DateRangePickerSelectionMode.single,
        showNavigationArrow: true,
        minDate: minDate,
        maxDate: maxDate,
        initialSelectedDate: value,
        enablePastDates: enablePastDates ?? true,
        viewSpacing: 15,
        confirmText: 'Oke',
        cancelText: 'Cancle',
        selectableDayPredicate: (DateTime value) {
          bool ban = true;
          if (banDate != null) {
            for (var element in banDate!) {
              if (value.weekday == element) {
                ban = false;
              }
            }
          }
          return ban;
        },
        onSubmit: (Object? value) {
          /// value = PickerDateRange when Type = DateRangePickerSelectionMode.range, extendableRange
          /// value = DateTime when Type = DateRangePickerSelectionMode.single
          /// value = List<DateTime> Type = DateRangePickerSelectionMode.multiple
          /// value = List<PickerDateRange> Type = DateRangePickerSelectionMode.multipleRange
          Navigator.pop(context, value);
        },
        onCancel: () {
          Navigator.pop(context);
        },
      ),
    );
  }
}
