import 'package:flutter/material.dart';
import 'package:newsapp/theme/theme.dart';
import 'package:newsapp/theme/theme_controller.dart';
import 'package:newsapp/view/Dashboard/dashboard.dart';
import 'package:get/get.dart';
import 'package:flutter/services.dart';

import 'controller/news_controller.dart';

void main() {
  Get.put(NewsController());

  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp( MyApp());
  });
}

class MyApp extends StatelessWidget {
   MyApp({super.key});

  // final ThemeController themeController = Get.put(ThemeController());

  @override
  Widget build(BuildContext context) {
   // return Obx(() {
     return GetMaterialApp(
       title: 'Flutter Demo',
       debugShowCheckedModeBanner: false,
       theme: AppThemes.lightTheme, // Light theme
       darkTheme: AppThemes.darkTheme, // Dark theme
       // themeMode: themeController.theme, // Dynamic theme switching
       home: const Dashboard(), //TToI(),//     UrlLauncherExample(),// TextToSpeechApp(),//CategoryScreen(),//HomeScreen(),//const MyHomePage(title: 'Flutter Demo Home Page'),
     );
   // },);
  }
}
