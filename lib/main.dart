import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:simple_nav_bar/custom_widgets/language.dart';
import 'package:simple_nav_bar/user_management/login_register.dart';
import 'package:simple_nav_bar/themes.dart';
/*// Import the firebase_core plugin
import 'package:firebase_core/firebase_core.dart';
import 'package:simple_nav_bar/user_management/register.dart';
import 'package:simple_nav_bar/main_screens/task_screen.dart';
import 'package:simple_nav_bar/main_screens/time_screen.dart';
import 'package:simple_nav_bar/nav.dart';
import 'package:simple_nav_bar/main_screens/data_screen.dart';
import 'package:simple_nav_bar/responsive_screens/home/all_tasks.dart';
import 'package:simple_nav_bar/main_screens/home_screen.dart';
import 'package:simple_nav_bar/user_management/login.dart';*/

Future main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  void initState() {
    super.initState();
    Firebase.initializeApp();
    currentTheme.addListener(() {
      if (this.mounted) { // check whether the state object is in tree
        setState(() {
          // make changes here
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Bottom Navigation Bar Tutorial',
      //home: Nav(),
      home: LoginRegister(),
      theme: CustomTheme.lightTheme,
      darkTheme: CustomTheme.darkTheme,
      themeMode: currentTheme.currentTheme,
      translations: Languages(),
      fallbackLocale: Locale('en','US'),
      locale: Get.deviceLocale,
    );
  }
}