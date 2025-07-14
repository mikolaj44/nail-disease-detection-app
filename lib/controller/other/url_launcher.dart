import 'package:url_launcher/url_launcher.dart' as url_launcher;

class UrlLauncher {
  static Future<void> launchUrl(String urlString) async {
    await url_launcher.launchUrl(Uri.parse(urlString));
  }
}