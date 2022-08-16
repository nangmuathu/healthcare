import 'package:intl/intl.dart';

const String ddMMyyyyHms = 'dd/MM/yyyy HH:mm:ss';
const String YYYYMMDDHMS = 'yyyy/MM/dd HH:mm:ss';
const String HHmm = 'HH:mm';
const String HHmma = 'HH:mm a';
const String ddMM = 'dd/MM';
const String ddMMyyyy = 'dd/MM/yyyy';
const String yyyyMMdd = 'yyyy-MM-dd';
const String ddMMyyyy_ = 'dd-MM-yyyy';
const String yyyyMMddTHHmmssSSS = "yyyy-MM-dd'T'HH:mm:ss.SSS";
const String MMyyyy = 'MM/yyyy';
const String dd = 'dd';

extension DateTimeExtention on DateTime {
  Duration get minutesFromMidNight => Duration(minutes: minute + hour * 60);

  String get numOfWeek {
    switch (weekday) {
      case DateTime.sunday:
        return "CN";
      default:
        return "T${weekday + 1}";
    }
  }

  String get dayOfWeekNumber {
    switch (weekday) {
      case DateTime.sunday:
        return "Chủ nhật";
      default:
        return "Thứ ${weekday + 1}";
    }
  }

  String get dayOfWeekString {
    String dayOfWeek = '';
    switch (weekday) {
      case DateTime.monday:
        dayOfWeek = "Thứ Hai";
        break;
      case DateTime.tuesday:
        dayOfWeek = "Thứ Ba";
        break;
      case DateTime.wednesday:
        dayOfWeek = "Thứ Tư";
        break;
      case DateTime.thursday:
        dayOfWeek = "Thứ Năm";
        break;
      case DateTime.friday:
        dayOfWeek = "Thứ Sáu";
        break;
      case DateTime.saturday:
        dayOfWeek = "Thứ Bảy";
        break;
      case DateTime.sunday:
        dayOfWeek = "Chủ Nhật";
        break;
    }
    return dayOfWeek;
  }

  /// thứ(chữ), ngày tháng năm
  String get dayOfWeekAndDate =>
      '$dayOfWeekString, ${convertToString(pattern: ddMMyyyy)}';

  /// thứ (chữ), ngày tháng năm, giờ
  String get dayOfWeekAndDateAndTime =>
      '$dayOfWeekString, ${convertToString(pattern: ddMMyyyy)}, ${convertToString(pattern: HHmm)}';

  /// giờ, ngày
  String get hourAndDateTime =>
      '${convertToString(pattern: HHmm)}, ${convertToString(pattern: ddMMyyyy)}';

  /// ngày, sáng - chiều
  String get dateTimeInTable =>
      '${convertToString(pattern: ddMMyyyy)} - $dateTimeToVnHour';

  /// thứ(số), ngày tháng năm, giờ
  String get dateTimeInWeather =>
      '$dayOfWeekNumber, ${convertToString(pattern: ddMMyyyy)}';

  /// thứ(số), ngày tháng năm - giờ
  String get dayOfWeekDateTimeVN =>
      '$dayOfWeekString ${convertToString(pattern: ddMMyyyy)} - ${convertToString(pattern: HHmm)}';

  /// ngày - giờ
  String get dateTimeString =>
      '${convertToString(pattern: ddMMyyyy)} - ${convertToString(pattern: HHmm)}';

  /// thứ(số), ngày tháng
  String get dateTimeToWeekdayAndDayMonth =>
      '$dayOfWeekNumber, ${convertToString(pattern: ddMM)}';

  /// convert to String
  String convertToString({required String pattern}) {
    try {
      return DateFormat(pattern).format(this);
    } catch (exception) {
      return '';
    }
  }

  String get dateTimeToDDMMYYYY {
    var formatter = DateFormat("dd/MM/yyyy");
    return formatter.format(this);
  }

  /// convert to new formatDate
  DateTime convertNewFormatDate(
          {required String newPattern, required String currentPattern}) =>
      DateFormat(newPattern).parse(convertToString(pattern: currentPattern));

  DateTime addTimeToDate(DateTime hour) {
    return DateTime(year, month, day, hour.hour, hour.minute);
  }

  String get dateTimeToVnHour => convertToString(pattern: HHmma)
      .replaceAll("PM", "chiều")
      .replaceAll("AM", "sáng");

  String get toUtcString => toUtc().toIso8601String();

  String get toUtcServer =>
      DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'").format(toLocal());

  DateTime get onlyUtcDate => DateTime.utc(year, month, day);

  bool isSameDate(DateTime other) {
    try {
      return year == other.year && month == other.month && day == other.day;
    } catch (ex) {
      return false;
    }
  }

  String get timeDifference {
    var today = DateTime.now();
    var diff = today.difference(this);
    if (diff.inSeconds < 60) {
      return "${diff.inSeconds} giây trước";
    } else if (diff.inMinutes < 60) {
      return "${diff.inMinutes} phút trước";
    } else if (diff.inHours < 24) {
      return "${diff.inHours} tiếng trước";
    } else if (diff.inDays < 7) {
      return "1 tuần trước";
    } else {
      return "${diff.inDays % 7} tuần trước";
    }
  }
}
