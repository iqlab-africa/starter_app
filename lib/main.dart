import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:starter_app/services/register_services.dart';
import 'package:starter_app/ui/video_main.dart';
import 'package:starter_app/util/util.dart';

void main() async {
  const mm = '🍣🍣🍣🍣🍣🍣VideoBotApp 🍣🍣🍣🍣';
  WidgetsFlutterBinding.ensureInitialized();

  try {
    pp('\n\n\n$mm ........ starting VideoBotApp .....');
    await dotenv.load(fileName: ".env");
    pp('$mm dotEnv has been loaded!');
    await RegisterServices.registerServices();
  } catch (e) {
    pp(e);
  }
  runApp(const VideoBotApp());
}

class VideoBotApp extends StatelessWidget {
  const VideoBotApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'VideoBot',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(
          useMaterial3: true
      ),
      home: const VideoList(),
    );
  }
}
