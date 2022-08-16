import 'dart:io';

class NetworkManager {
  NetworkManager._internal();

  static NetworkManager? _instance;

  factory NetworkManager.instance() => _instance ??= NetworkManager._internal();

  Future<bool> hasConnection() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      return !(result.isNotEmpty && result[0].rawAddress.isNotEmpty);
    } on SocketException catch (_) {
      return true;
    }
  }
}
