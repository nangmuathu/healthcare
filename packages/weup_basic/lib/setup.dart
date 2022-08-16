import 'dart:io';

import 'package:provider/single_child_widget.dart';

List<SingleChildWidget> loadProviders([List<SingleChildWidget>? inputs]) {
  return [
    ...?inputs,
  ];
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
