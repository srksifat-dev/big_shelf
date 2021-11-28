import 'package:flutter/foundation.dart';
import 'package:url_launcher/url_launcher.dart';

class Utils {
  static Future openLink({
    @required String? url,
  }) =>
      _launchUrl(url);

  static Future? openEmail({
    @required String? toEmail,
    @required String? subject,
    @required String? body,
  }) {
    final url =
        'mailto:$toEmail?subject=${Uri.encodeFull(subject!)}&body=${Uri.encodeFull(body!)}';

    _launchUrl(url);
  }

  static Future openPhoneCall({@required String? phoneNumber}) async {
    final url = 'tel:$phoneNumber';

    await _launchUrl(url);
  }

  static Future openSMS({@required String? phoneNumber}) async {
    final url = 'sms:$phoneNumber';

    await _launchUrl(url);
  }

  static Future _launchUrl(String? url) {
      return launch(url!);
  }
}
