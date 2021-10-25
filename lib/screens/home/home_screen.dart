import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:simple_nav_bar/screens/home/home_widgets/large/larger_than_850.dart';
import 'package:simple_nav_bar/screens/home/home_widgets/medium/between_450_550.dart';
import 'package:simple_nav_bar/screens/home/home_widgets/medium/between_550_650.dart';
import 'package:simple_nav_bar/screens/home/home_widgets/small/between_350_450.dart';
import 'package:simple_nav_bar/screens/home/home_widgets/small/smaller_than_350.dart';
import '../../themes.dart';
import 'Screens_Home/all_tasks.dart';
import 'Screens_Home/settings.dart';
import 'home_widgets/large/between_750_850.dart';
import 'home_widgets/medium/between_650_750.dart';

Future main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(Home());
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
      home: MyHomePage(title: 'Home'),
      title: 'Flutter Theme Demo',
      debugShowCheckedModeBanner: false,
      theme: CustomTheme.lightTheme,
      darkTheme: CustomTheme.darkTheme,
      themeMode: currentTheme.currentTheme,
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

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
              padding: EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (_) => SettingsPage(title: 'Settings',)));
                },
                child: Icon(
                    Icons.settings
                ),
              )
          ),
        ],
        actionsIconTheme: IconThemeData(
            size: 30.0,
            color: theme.shadowColor,
            opacity: 10.0
        ),
      ),
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints){
          if(constraints.maxHeight < 350){
            return HomeSmaller350(constraint: constraints.maxHeight,);
          }else if(constraints.maxHeight > 350 && constraints.maxHeight < 450){
            return HomeBet350N450(constraint: constraints.maxHeight,);
          }else if(constraints.maxHeight > 450 && constraints.maxHeight < 550){
            return HomeBet450N550(constraint: constraints.maxHeight,);
          }else if(constraints.maxHeight > 550 && constraints.maxHeight < 650){
            return HomeBet550N650(constraint: constraints.maxHeight,);
          }else if(constraints.maxHeight > 650 && constraints.maxHeight < 750){
            return HomeBet650N750(constraint: constraints.maxHeight,);
          }else if(constraints.maxHeight > 750 && constraints.maxHeight < 850){
            return HomeBet750N850(constraint: constraints.maxHeight,);
          }else{
            return HomeLarger850(constraint: constraints.maxHeight,);
          }
        },
      ),
    );
  }
}