import 'dart:io' as io;

import 'package:path_provider/path_provider.dart';
import 'dart:math' as math;

enum FileOption { camera, gallery, document }

class FileUtils {
  FileUtils._internal();

  static final FileUtils _instance = FileUtils._internal();

  factory FileUtils() => _instance;

  Future<String> getApplicationDocumentsDirectoryPath() async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<bool> checkSize(io.File file, {int? size}) async {
    final _s = size ?? 5; // default 5MB
    final int fileSize = await file.length();
    return fileSize > (_s * math.pow(1024, 2));
  }
}
