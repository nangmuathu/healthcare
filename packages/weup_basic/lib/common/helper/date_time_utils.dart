import 'package:weup_basic/common/core/sys/base_function.dart';
import 'package:intl/intl.dart';

class DateTimeUtils {
  static const String DDMMYYYYHMS = 'dd/MM/yyyy HH:mm:ss';
  static const String YYYYMMDDHMS = 'yyyy/MM/dd HH:mm:ss';
  static const String HHMM = 'HH:mm';
  static DateTime get now => DateTime.now();
  static const String HHMM_DDMMYYYY = 'HH:mm, dd/MM/yyyy';

  static String? convertTo(
      String data, String currentPattern, String toPattern) {
    try {
      return DateFormat(toPattern)
          .format(DateFormat(currentPattern).parse(data));
    } catch (exception) {
      showError(exception.toString());
    }
    return null;
  }

  static String? intToFormat(int data, String toPattern) {
    try {
      return DateFormat(toPattern)
          .format(DateTime.fromMillisecondsSinceEpoch(data * 1000));
    } catch (exception) {
      showError(exception.toString());
    }
    return null;
  }

  static String? format(DateTime currentDate, String toPattern) {
    try {
      return DateFormat(toPattern).format(currentDate);
    } catch (exception) {
      showError(exception.toString());
    }
    return null;
  }

  static DateTime? parse(String data, String toPattern) {
    try {
      return DateFormat(toPattern).parse(data);
    } catch (exception) {
      showError(exception.toString());
    }
    return null;
  }

  static DateTime? intParse(int data) {
    try {
      return DateTime.fromMillisecondsSinceEpoch(data * 1000);
    } catch (exception) {
      showError(exception.toString());
    }
    return null;
  }

  static DateTime? dToD(DateTime data, String fromPattern, String toPattern) {
    try {
      return parse(format(data, fromPattern) ?? '', toPattern);
    } catch (exception) {
      showError(exception.toString());
    }
    return null;
  }

  static DateTime get firstDayOfWeek =>
      now.subtract(Duration(days: now.weekday - 1));

  static DateTime get lastDayOfWeek =>
      now.add(Duration(days: DateTime.daysPerWeek - now.weekday));

  static int getSeconds() {
    return DateTime.now().millisecondsSinceEpoch ~/ 1000;
  }

  static int getMilliseconds() {
    return DateTime.now().millisecondsSinceEpoch;
  }
}
