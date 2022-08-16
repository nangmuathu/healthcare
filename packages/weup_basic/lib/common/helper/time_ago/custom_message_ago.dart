import 'package:timeago/timeago.dart' as time_ago;

class CustomViMessages implements time_ago.LookupMessages {
  CustomViMessages([this.hasShort = true]);
  final bool hasShort;
  @override
  String prefixAgo() => '';
  @override
  String prefixFromNow() => '';
  @override
  String suffixAgo() => '';
  @override
  String suffixFromNow() => '';
  @override
  String lessThanOneMinute(int seconds) => 'Vừa xong';
  @override
  String aboutAMinute(int minutes) => '1 phút${hasShort?'':' trước'}';
  @override
  String minutes(int minutes) => '$minutes phút${hasShort?'':' trước'}';
  @override
  String aboutAnHour(int minutes) => '1 giờ${hasShort?'':' trước'}';
  @override
  String hours(int hours) => '$hours giờ${hasShort?'':' trước'}';
  @override
  String aDay(int hours) => '1 ngày${hasShort?'':' trước'}';
  @override
  String days(int days) => '$days ngày${hasShort?'':' trước'}';
  @override
  String aboutAMonth(int days) => '1 tháng${hasShort?'':' trước'}';
  @override
  String months(int months) => '$months tháng${hasShort?'':' trước'}';
  @override
  String aboutAYear(int year) => '1 năm${hasShort?'':' trước'}';
  @override
  String years(int years) => '$years năm${hasShort?'':' trước'}';
  @override
  String wordSeparator() => ' ';
}

class CustomViShortMessages implements time_ago.LookupMessages {
  @override
  String prefixAgo() => '';
  @override
  String prefixFromNow() => '';
  @override
  String suffixAgo() => '';
  @override
  String suffixFromNow() => '';
  @override
  String lessThanOneMinute(int seconds) => 'Vừa xong';
  @override
  String aboutAMinute(int minutes) => '1 ph';
  @override
  String minutes(int minutes) => '$minutes ph';
  @override
  String aboutAnHour(int minutes) => '~1 h';
  @override
  String hours(int hours) => '$hours h';
  @override
  String aDay(int hours) => '~1 ngày';
  @override
  String days(int days) => '$days ngày';
  @override
  String aboutAMonth(int days) => '~1 tháng';
  @override
  String months(int months) => '$months tháng';
  @override
  String aboutAYear(int year) => '~1 năm';
  @override
  String years(int years) => '$years năm';
  @override
  String wordSeparator() => ' ';
}