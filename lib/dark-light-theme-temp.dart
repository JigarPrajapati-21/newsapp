/*

if you want to set dark-light theme by switch button which is in profilescree
then uncomment following code

1. ------------> uncomment following code from profilescreen

                  final ThemeController themeController = Get.find<ThemeController>();

                  // Dark-light Theme Toggle Card
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 10,
                          spreadRadius: 1,
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                      child: Row(
                        children: [
                          Icon(
                            themeController.isDarkMode.value ? Icons.dark_mode_rounded : Icons.light_mode_rounded,
                            color: primaryColor,
                            size: 24,
                          ),
                          SizedBox(width: 15),
                          Expanded(
                            child: Text(
                              "Dark Mode",
                              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                                  fontSize: 16, fontWeight: FontWeight.w500
                              ),
                            ),
                          ),
                          Obx(() => Switch(
                            value: themeController.isDarkMode.value,
                            onChanged: (value) {
                              themeController.toggleTheme();
                            },
                            activeColor: primaryColor,
                          )),
                        ],
                      ),
                    ),
                  ),

2. --------------> uncomment following code from theme_controller.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ThemeController extends GetxController {
  var isDarkMode = false.obs; // Observable for dark mode

  ThemeMode get theme => isDarkMode.value ? ThemeMode.dark : ThemeMode.light;

  void toggleTheme() {
    isDarkMode.value = !isDarkMode.value; // Toggle dark/light mode
  }
}

3. -----------> uncomment following code from main.dart
class MyApp extends StatelessWidget {
   MyApp({super.key});

  final ThemeController themeController = Get.put(ThemeController());

  @override
  Widget build(BuildContext context) {
   return Obx(() {
     return GetMaterialApp(
       title: 'Flutter Demo',
       debugShowCheckedModeBanner: false,
       theme: AppThemes.lightTheme, // Light theme
       darkTheme: AppThemes.darkTheme, // Dark theme
       // themeMode: themeController.theme, // Dynamic theme switching
       home: const Dashboard(), //TToI(),//     UrlLauncherExample(),// TextToSpeechApp(),//CategoryScreen(),//HomeScreen(),//const MyHomePage(title: 'Flutter Demo Home Page'),
     );
   },);
  }
}

-------------------------------------------
if you are using this above way for dark-light mode
then app will not changes based on mobile theme setting
or emulator theme setting
app will only change theme by using switch button which is in profilescreen



 */