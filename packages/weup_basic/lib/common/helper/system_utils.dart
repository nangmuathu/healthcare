import 'package:weup_basic/common/helper/file_utils.dart';
import 'package:flutter/cupertino.dart';

bool inArray(dynamic value, var array) {
  if (!empty(value) && !empty(array)) {
    if (array is List || array is Map) {
      if (array is Map) return array.containsValue(value);
      if (array is List) return array.contains(value);
    }
    return false;
  }
  return false;
}

// ignore: non_constant_identifier_names
void print_r(dynamic input) {
  if (input != null) {
    if (input is String || input is num) {
      debugPrint('$input');
      return;
    }

    if (input is Map) {
      input.forEach((k, v) {
        debugPrint('${k.runtimeType} - ${v.runtimeType}: $k - $v');
      });
      return;
    }
    if (input is List) {
      for (var e in input) {
        debugPrint('${e.runtimeType}: $e');
      }
      return;
    }
  }
}

bool empty([dynamic data, bool hasZero = false]) {
  if (data != null) {
    if ((data is Map || data is List) && data.length == 0) return true;
    if ((data is Map || data is Iterable) && data.isEmpty) return true;
    if (data is bool) return !data;
    if ((data is String || data is num) && (data == '0' || data == 0)) {
      if (hasZero) return false;
      return true;
    }
    if (data.toString().isNotEmpty) return false;
  }
  return true;
}
