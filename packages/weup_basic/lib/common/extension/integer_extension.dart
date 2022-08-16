import 'dart:ui';

import 'package:intl/intl.dart';

import 'datetime_extension.dart';

extension IntegerExtension on int {
  String get dayOfWeekDateTimeString {
    return DateTime.fromMillisecondsSinceEpoch(this * 1000).dayOfWeekDateTimeVN;
  }

  String get dateTimeString {
    return DateTime.fromMillisecondsSinceEpoch(this * 1000).dateTimeString;
  }

  String get dateString => DateTime.fromMillisecondsSinceEpoch(this * 1000).convertToString(pattern: ddMMyyyy);

  DateTime get dateTimeValue => DateTime.fromMillisecondsSinceEpoch(this * 1000);

  String get currencyString {
    return '${NumberFormat("#,###").format(this).replaceAll(',', '.')}đ';
  }

  Color get colorFromIntValue {
    switch (this) {
      case 0:
        return const Color(0xff1555a7);
      case 1:
        return const Color(0xfff37678);
      case 2:
        return const Color(0xffE60708);
      case 3:
        return const Color(0xff540967);
    }
    return const Color(0xff1555a7);
  }

  Color get colorTableFromIntValue {
    switch (this) {
      case 0:
        return const Color(0xffffffff);
      case 1:
        return const Color(0xfff37678);
      case 2:
        return const Color(0xffE60708);
      case 3:
        return const Color(0xff540967);
    }
    return const Color(0xffffffff);
  }

  String get secondToHourMinute {
    if(this <0) return '00:00';
    int h, m, s;

    h = this ~/ 3600;

    m = ((this - h * 3600)) ~/ 60;

    s = this - (h * 3600) - (m * 60);

    String hourLeft = h.toString().length < 2 ? "0" + h.toString() : h.toString();

    String minuteLeft = m.toString().length < 2 ? "0" + m.toString() : m.toString();

    String secondsLeft = s.toString().length < 2 ? "0" + s.toString() : s.toString();

    String result = "${hourLeft == '00' ? '' : ':'}$minuteLeft:$secondsLeft";

    return result;
  }

  bool isPhoneVN() {
    RegExp regExp = RegExp(r'^(0?)(3[2-9]|5[6|8|9]|7[0|6-9]|8[0-6|8|9]|9[0-4|6-9])[0-9]{7}');
    return regExp.hasMatch(toString());
  }

  Iterable<int> rangeTo(int n) {
    var count = (n - this).abs() + 1;
    var direction = (n - this).sign;
    var i = this - direction;
    return Iterable.generate(count, (int index) {
      return i += direction;
    });
  }

  Duration get milliseconds {
    return Duration(milliseconds: this);
  }

}
