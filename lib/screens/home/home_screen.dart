import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:simple_nav_bar/widgets/task_item.dart';
import 'package:simple_nav_bar/screens/home/home_widgets/between_350_400.dart';
import 'package:simple_nav_bar/screens/home/home_widgets/between_400_450.dart';
import 'package:simple_nav_bar/screens/home/home_widgets/between_450_500.dart';
import 'package:simple_nav_bar/screens/home/home_widgets/between_550_600.dart';
import 'package:simple_nav_bar/screens/home/home_widgets/between_600_650.dart';
import 'package:simple_nav_bar/screens/home/home_widgets/between_650_700.dart';
import 'package:simple_nav_bar/screens/home/home_widgets/between_750_800.dart';
import 'package:simple_nav_bar/screens/home/home_widgets/between_800_850.dart';
import 'package:simple_nav_bar/screens/home/home_widgets/larger_than_850.dart';
import 'package:simple_nav_bar/screens/home/home_widgets/between_500_550.dart';
import 'package:simple_nav_bar/screens/home/home_widgets/between_600_650.dart';
import 'package:simple_nav_bar/screens/home/home_widgets/between_400_450.dart';
import 'package:simple_nav_bar/screens/home/home_widgets/smaller_than_350.dart';
import '../../themes.dart';
import 'Screens_Home/all_tasks.dart';
import 'Screens_Home/settings.dart';
import 'home_widgets/between_800_850.dart';
import 'home_widgets/between_700_750.dart';

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
          body: Center(
          child: FittedBox(
            fit: BoxFit.fitHeight,
            alignment: Alignment.center,
            child: Container(
              height: MediaQuery.of(context).size.height*1,
              width: MediaQuery.of(context).size.width*1,
              child:  Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(right: 20,top: 15),
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        'working',
                        style: TextStyle(
                            color: Colors.green.shade600,
                            fontWeight: FontWeight.bold,
                            fontSize: 13
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 20,left: 40),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Not finished',
                        style: theme.textTheme.headline5,
                      ),
                    ),
                  ),
                  TaskItem(theme: theme, title: 'Rocomp-23-08-Server'),
                  Padding(
                    padding: EdgeInsets.only(top: 20, bottom: 0, left: 40),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Finished',
                        style: theme.textTheme.headline5,
                      ),
                    ),
                  ),

                  TaskItem(theme: theme, title: 'LeDuigou-22-08-Kassa'),
                  TaskItem(theme: theme, title: 'Max-Mustermann-22-08-Computer-Kauf'),
                  TaskItem(theme: theme, title: 'Intern-22-08'),
                  TaskItem(theme: theme, title: 'Häusle-20-08-Computer-Software'),
                  TaskItem(theme: theme, title: 'Fulterer-19-08-Computer-Hardware'),
                  TaskItem(theme: theme, title: 'Fulterer-19-08-Computer-Hardware'),

                  Padding(
                    padding: EdgeInsets.only(left: 30, right: 30,top: 15),
                    child: Container(
                      width: MediaQuery.of(context).size.width*1,
                      height: MediaQuery.of(context).size.height*0.07,
                      child: TextButton(
                          style: TextButton.styleFrom(
                            primary: theme.backgroundColor,
                          ),
                          onPressed: (){
                            Navigator.push(context, MaterialPageRoute(builder: (_) => AllTasksPage(title: 'All Tasks',)));
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: <Widget>[
                              Flexible(
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Padding(
                                    padding: EdgeInsets.only(left: 10),
                                    child: Text(
                                      "See all",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: theme.shadowColor,
                                          fontSize: 22
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Align(
                                alignment: Alignment.centerRight,
                                child: IconTheme(
                                  data: new IconThemeData(
                                      color: theme.shadowColor,
                                      size: 35
                                  ),
                                  child: Icon(Icons.keyboard_arrow_right_sharp),
                                ),
                              ),
                            ],
                          )
                      ),
                    ),
                  ),
                ],
              ),
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
          }else if(constraints.maxHeight > 350 && constraints.maxHeight < 400){
            return HomeBet350N400(constraint: constraints.maxHeight,);
          }else if(constraints.maxHeight > 400 && constraints.maxHeight < 450){
            return HomeBet400N450(constraint: constraints.maxHeight,);
          }else if(constraints.maxHeight > 450 && constraints.maxHeight < 500){
            return HomeBet450N500(constraint: constraints.maxHeight,);
          }else if(constraints.maxHeight > 500 && constraints.maxHeight < 550) {
            return HomeBet500N550(constraint: constraints.maxHeight,);
          }else if(constraints.maxHeight > 550 && constraints.maxHeight < 600){
            return HomeBet550N600(constraint: constraints.maxHeight,);
          }else if(constraints.maxHeight > 600 && constraints.maxHeight < 650){
            return HomeBet600N650(constraint: constraints.maxHeight,);
          }else if(constraints.maxHeight > 650 && constraints.maxHeight < 700){
            return HomeBet650N700(constraint: constraints.maxHeight,);
          }else if(constraints.maxHeight > 700 && constraints.maxHeight < 750){
            return HomeBet700N750(constraint: constraints.maxHeight,);
          }else if(constraints.maxHeight > 750 && constraints.maxHeight < 800){
            return HomeBet750N800(constraint: constraints.maxHeight,);
          }else if(constraints.maxHeight > 800 && constraints.maxHeight < 850){
            return HomeBet800N850(constraint: constraints.maxHeight,);
          }else{
            return HomeLarger850(constraint: constraints.maxHeight,);
          }
        },
      ),
          ),
      ),
    );
  }
}