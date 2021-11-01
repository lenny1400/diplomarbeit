import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:simple_nav_bar/nav.dart';
import 'package:simple_nav_bar/screens/data/data_screen.dart';
import 'package:simple_nav_bar/screens/home/all_tasks.dart';
import 'package:simple_nav_bar/screens/home/home_screen.dart';
import 'package:simple_nav_bar/screens/login/login.dart';
import 'package:simple_nav_bar/screens/login/login_register.dart';
import 'package:simple_nav_bar/screens/login/register.dart';
import 'package:simple_nav_bar/screens/task/task_screen.dart';
import 'package:simple_nav_bar/screens/time/time_screen.dart';
import 'package:simple_nav_bar/themes.dart';
// Import the firebase_core plugin
import 'package:firebase_core/firebase_core.dart';

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
    Firebase.initializeApp().whenComplete(() => currentTheme.addListener(() {
      if (this.mounted) { // check whether the state object is in tree
        setState(() {
          // make changes here
          });
        }
      })
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Bottom Navigation Bar Tutorial',
      //home: Nav(),
      home: LoginRegister(),
      routes: {
        '/login': (context) => LoginForm(),
        '/loginregister': (context) => LoginRegister(),
        '/register': (context) => RegisterForm(),
        '/nav': (context) => Nav(),
        '/home': (context) => Home(),
        '/time': (context) => Time(),
        '/task': (context) => Tasks(),
        '/data': (context) => Data(),
        '/alltasks': (context) => AllTasksPage(title: 'All Tasks'),
      },
      theme: CustomTheme.lightTheme,
      darkTheme: CustomTheme.darkTheme,
      themeMode: currentTheme.currentTheme,
    );
  }
}