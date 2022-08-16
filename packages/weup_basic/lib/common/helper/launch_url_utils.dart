import 'package:url_launcher/url_launcher.dart';

class LaunchUrlUtils {
  static void openUrl(String? url) async {
    if (url == null) return;
    if (!await canLaunch(url)) return;
    await launch(url);
  }
}
