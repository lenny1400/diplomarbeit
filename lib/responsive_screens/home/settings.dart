import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:simple_nav_bar/main_screens/data_screen.dart';
import 'package:simple_nav_bar/responsive_screens/home/home_widgets/settings_widget/responsive_settings.dart';
import 'package:simple_nav_bar/user_management/login.dart';
import 'package:simple_nav_bar/user_management/login_register.dart';
import 'package:simple_nav_bar/user_management/register.dart';
import 'package:simple_nav_bar/main_screens/task_screen.dart';
import 'package:simple_nav_bar/main_screens/time_screen.dart';
import '../../nav.dart';
import '../../themes.dart';
import 'package:get_storage/get_storage.dart';
import 'package:get/get.dart';

import '../../main_screens/home_screen.dart';

Future main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  await GetStorage.init();

  runApp(Settings(title: 'Settings',));
}

class Settings extends StatefulWidget {
  const Settings({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {


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
      home: SettingsPage(title: 'Settings'),
      routes: {
        '/home': (context) => Home(),
      },
      debugShowCheckedModeBanner: false,
      theme: CustomTheme.lightTheme,
      darkTheme: CustomTheme.darkTheme,
      themeMode: currentTheme.currentTheme,
    );
  }
}

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key,required this.title}) : super(key: key);

  final String title;

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {


  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.backgroundColor,
        appBar: AppBar(
          title: Text(widget.title.tr,
          style: theme.textTheme.caption,
            ),
          elevation: 0,
        ),
      body: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints){
            final mxHeight = constraints.maxHeight;

            if(constraints.maxHeight < 400){
              final _cons1 = mxHeight*0.02;
              final _cons2 = mxHeight*0.035;
              final _cons3 = mxHeight*0.06;
              final _cons4 = mxHeight*0.09;
              final _cons5 = mxHeight*0.12;
              return ResponsiveSettings(constraints: mxHeight,cons1: _cons1,cons2: _cons2,cons3: _cons3,cons4: _cons4,cons5: _cons5,);
            }else if(constraints.maxHeight > 400 && constraints.maxHeight < 500){
              final _cons1 = mxHeight*0.02;
              final _cons2 = mxHeight*0.03;
              final _cons3 = mxHeight*0.05;
              final _cons4 = mxHeight*0.09;
              final _cons5 = mxHeight*0.11;
              return ResponsiveSettings(constraints: mxHeight,cons1: _cons1,cons2: _cons2,cons3: _cons3,cons4: _cons4,cons5: _cons5,);
            }else if(constraints.maxHeight > 500 && constraints.maxHeight < 600){
              final _cons1 = mxHeight*0.01;
              final _cons2 = mxHeight*0.04;
              final _cons3 = mxHeight*0.045;
              final _cons4 = mxHeight*0.09;
              final _cons5 = mxHeight*0.115;
              return ResponsiveSettings(constraints: mxHeight,cons1: _cons1,cons2: _cons2,cons3: _cons3,cons4: _cons4,cons5: _cons5,);
            }else if(constraints.maxHeight > 600 && constraints.maxHeight < 700){
              final _cons1 = mxHeight*0.015;
              final _cons2 = mxHeight*0.035;
              final _cons3 = mxHeight*0.05;
              final _cons4 = mxHeight*0.08;
              final _cons5 = mxHeight*0.105;
              return ResponsiveSettings(constraints: mxHeight,cons1: _cons1,cons2: _cons2,cons3: _cons3,cons4: _cons4,cons5: _cons5,);
            }else if(constraints.maxHeight > 700 && constraints.maxHeight < 800) {
              final _cons1 = mxHeight*0.015;
              final _cons2 = mxHeight*0.03;
              final _cons3 = mxHeight*0.045;
              final _cons4 = mxHeight*0.07;
              final _cons5 = mxHeight*0.01;
              return ResponsiveSettings(constraints: mxHeight,cons1: _cons1,cons2: _cons2,cons3: _cons3,cons4: _cons4,cons5: _cons5,);
            }else{
              final _cons1 = mxHeight*0.015;
              final _cons2 = mxHeight*0.03; //padding left
              final _cons3 = mxHeight*0.04; //fontsize and padding
              final _cons4 = mxHeight*0.075; //mostly icon size
              final _cons5 = mxHeight*0.1; //box sizes of elements
              return ResponsiveSettings(constraints: mxHeight,cons1: _cons1,cons2: _cons2,cons3: _cons3,cons4: _cons4,cons5: _cons5,);
            }
          }
      ),
    );
  }
}

