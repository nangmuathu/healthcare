import 'dart:io' as io;

extension FileExtension on io.FileSystemEntity {
  String get name => uri.pathSegments.last;
}