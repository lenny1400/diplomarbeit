import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:simple_nav_bar/screens/login/login.dart';
import 'package:simple_nav_bar/screens/login/login_register.dart';
import '../../themes.dart';
import 'all_tasks.dart';
import 'settings.dart';
import 'home_widgets/responsive_mobile.dart';

Future main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(const Home());
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  @override
  void initState() {
    super.initState();
    currentTheme.addListener(() {
      if (mounted) { // check whether the state object is in tree
        setState(() {
          // make changes here
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const MyHomePage(title: 'Home'),
      routes: {
        '/settings': (context) => Settings(title: 'Settings'),
        '/alltasks': (context) => AllTasksPage(title: 'All Tasks'),
        '/home': (context) => MyHomePage(title: 'Home'),
      },
      title: 'Flutter Theme Demo',
      debugShowCheckedModeBanner: false,
      theme: CustomTheme.lightTheme,
      darkTheme: CustomTheme.darkTheme,
      themeMode: currentTheme.currentTheme,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.backgroundColor,
      appBar: AppBar(
        title: Text("Home",
          style: theme.textTheme.caption,
        ),
        elevation: 0,
        actions: [
          Padding(
              padding: const EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/settings');
                },
                child: const Icon(
                    Icons.settings
                ),
              )
          ),
        ],
        actionsIconTheme: IconThemeData(
            size: 30.0,
            color: theme.shadowColor,
            opacity: 12.0
        ),
      ),
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints){
          final mxHeight = constraints.maxHeight;
          //small devices
          if(constraints.maxHeight < 400){
            final _cons1 = mxHeight*0.02;
            final _cons2 = mxHeight*0.03;
            final _cons3 = mxHeight*0.05;
            final _cons4 = mxHeight*0.07;
            final _cons5 = mxHeight*0.075;
            return MobileHome(constraint: mxHeight,cons1: _cons1,cons2: _cons2,cons3: _cons3,cons4: _cons4,cons5: _cons5,itemCount: 4,);
          }else if(constraints.maxHeight > 400 && constraints.maxHeight < 500){
            final _cons1 = mxHeight*0.02;
            final _cons2 = mxHeight*0.025;
            final _cons3 = mxHeight*0.05;
            final _cons4 = mxHeight*0.065;
            final _cons5 = mxHeight*0.08;
            return MobileHome(constraint: mxHeight,cons1: _cons1,cons2: _cons2,cons3: _cons3,cons4: _cons4,cons5: _cons5,itemCount: 4,);
          }else if(constraints.maxHeight > 500 && constraints.maxHeight < 600){
            final _cons1 = mxHeight*0.02;
            final _cons2 = mxHeight*0.025;
            final _cons3 = mxHeight*0.04;
            final _cons4 = mxHeight*0.06;
            final _cons5 = mxHeight*0.075;
            return MobileHome(constraint: mxHeight,cons1: _cons1,cons2: _cons2,cons3: _cons3,cons4: _cons4,cons5: _cons5,itemCount: 5,);
          }else if(constraints.maxHeight > 600 && constraints.maxHeight < 700){
            final _cons1 = mxHeight*0.015;
            final _cons2 = mxHeight*0.02;
            final _cons3 = mxHeight*0.035;
            final _cons4 = mxHeight*0.05;
            final _cons5 = mxHeight*0.075;
            return MobileHome(constraint: mxHeight,cons1: _cons1,cons2: _cons2,cons3: _cons3,cons4: _cons4,cons5: _cons5,itemCount: 5,);
          }else if(constraints.maxHeight > 700 && constraints.maxHeight < 800) {
            final _cons1 = mxHeight*0.015;
            final _cons2 = mxHeight*0.02;
            final _cons3 = mxHeight*0.035;
            final _cons4 = mxHeight*0.05;
            final _cons5 = mxHeight*0.075;
            return MobileHome(constraint: mxHeight,cons1: _cons1,cons2: _cons2,cons3: _cons3,cons4: _cons4,cons5: _cons5,itemCount: 6,);
          }else{
            final _cons1 = mxHeight*0.015;
            final _cons2 = mxHeight*0.02;
            final _cons3 = mxHeight*0.035;
            final _cons4 = mxHeight*0.05;
            final _cons5 = mxHeight*0.075;
            return MobileHome(constraint: mxHeight,cons1: _cons1,cons2: _cons2,cons3: _cons3,cons4: _cons4,cons5: _cons5,itemCount: 7,);
          }
        },
      ),
    );
  }
}