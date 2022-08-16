import '../extension/string_extension.dart';

class StringUtils {

  static String getUUID() {
    return '${DateTime.now().microsecondsSinceEpoch~/1000}${getRandomString(10)}';
  }

}