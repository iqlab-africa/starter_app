import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../util/prefs.dart';
import '../util/util.dart';
import 'http_service.dart';

class RegisterServices {
  static final getIt = GetIt.instance;
  static const mm = '💦💦💦 RegisterServices 💦 ';

  static Future registerServices() async {
    pp('$mm .. starting the service registrations ...');

    initializeEnvironment();

    var service = HttpService(
      robocorpApiKey: robocorpApiKey!,
      keyPrefix: keyPrefix!,
      robocorpUrl: robocorpUrl!,
      webBackendUrl: webBackendUrl!,
      client: http.Client(),
      headers: headers,
    );

    var sp = await SharedPreferences.getInstance();
    getIt.registerLazySingleton<HttpService>(() => service);
    getIt.registerLazySingleton<Prefs>(() => Prefs(sp));
    pp('$mm HttpService registered!');
  }

  static var headers = <String, String>{};

  static String? robocorpApiKey, keyPrefix, robocorpUrl, webBackendUrl;

  static void initializeEnvironment() {
    // Robocorp Control Room
    robocorpApiKey = dotenv.env['ROBOCORP_API_KEY'];
    keyPrefix = dotenv.env['ROBOCORP_KEY_PREFIX'];
    robocorpUrl = dotenv.env['ROBOCORP_URL'];
    headers = {'Authorization': '$keyPrefix $robocorpApiKey'};

    //web backend
    webBackendUrl = dotenv.env['WEB_BACKEND_URL'];
    pp('$mm  Environment stuff here: '
        '\n🍎keyPrefix: $keyPrefix '
        '\n🍎robocorpApiKey: $robocorpApiKey'
        '\n🍎robocorpUrl: $robocorpUrl'
        '\n🍎webBackendUrl: $webBackendUrl');

    pp('\n\n$mm  🍎🍎headers: $headers');
  }
}
