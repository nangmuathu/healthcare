// call api loi thi dung lai
extension ObjectExtension on dynamic {
  bool _isNotNull() {
    return this != null;
  }

  bool _isNull() {
    return this == null;
  }

  bool _isNotNullBlank() {
    if (this != null) {
      if (this is String) {
        return toString().trim().isNotEmpty;
      }
      return false;
    }
    return false;
  }

  bool get isNotNull => _isNotNull();

  bool get isNulled => _isNull();

  bool get isNotNullBlank => _isNotNullBlank();
}
