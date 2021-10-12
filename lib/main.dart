import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:simple_nav_bar/nav.dart';
import 'package:simple_nav_bar/themes.dart';

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
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Bottom Navigation Bar Tutorial',
      //home: Nav(),
      home: LoadUpScreen(),
      theme: CustomTheme.lightTheme,
      darkTheme: CustomTheme.darkTheme,
      themeMode: currentTheme.currentTheme,
    );
  }
}

class LoadUpScreen extends StatefulWidget {
  const LoadUpScreen({Key? key}) : super(key: key);

  @override
  _LoadUpScreenState createState() => _LoadUpScreenState();
}

class _LoadUpScreenState extends State<LoadUpScreen> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: Center(
        child: FittedBox(
          fit: BoxFit.fitHeight,
          child: Container(
            height: MediaQuery.of(context).size.height*1,
            width: MediaQuery.of(context).size.width*1,
            color: theme.primaryColor,
          ),
        ),
      ),
    );
  }
}
