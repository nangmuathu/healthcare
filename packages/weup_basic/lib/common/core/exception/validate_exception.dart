import 'dart:core';

class ValidateException implements Exception {
  final String message;

  ValidateException([this.message = ""]);

  static ValidateException notNull() => ValidateException('must not null');

  @override
  String toString() => '-----||-------------> $message';
}
