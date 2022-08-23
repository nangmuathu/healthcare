import 'package:url_launcher/url_launcher.dart';

class LaunchUrlUtils {
  static void openUrl(String? url) async {
    if (url == null) return;
    if (!await canLaunchUrl(Uri.parse(url))) return;
    await launchUrl(Uri.parse(url));
  }
}
