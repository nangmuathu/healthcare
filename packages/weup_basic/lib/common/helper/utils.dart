import 'package:intl/intl.dart';

class Utils {
  static String concatImageLink(String? path) => 'https://cf.hidelink.vn/file/' + (path ?? '');

  static String currency(dynamic value) {
    final formatter = NumberFormat("#,##0", "pt_BR");
    return formatter.format(value.toInt() / 100);
  }

  static List<String> toSearchList(String input) => input.split(' ').expand(_expandParams).toList();

  static Iterable<String> _expandParams(String _res) sync* {
    final _buffer = StringBuffer();
    for (var i = 0; i < _res.length; i++) {
      yield (_buffer..writeCharCode(_res.codeUnitAt(i))).toString();
    }
  }
}
