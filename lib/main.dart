import 'package:big_shelf/view/authentication/auth_view.dart';
import 'package:big_shelf/view/theme/theme.dart';
import 'package:big_shelf/view/theme/theme_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'view/home_screen/home_screen.dart';

int? initScreen;
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  final GetStorage storage = GetStorage();
  initScreen = storage.read("initScreen");
  // await storage.write("initScreen", 1);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Big Shelf',
      theme: Themes().lightTheme,
      darkTheme: Themes().darkTheme,
      themeMode: ThemeService().getThemeMode(),
      home: AuthScreen(),
    );
  }
}
