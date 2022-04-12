import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:simple_nav_bar/responsive_screens/home/settings.dart';
import 'package:simple_nav_bar/responsive_screens/task/task_widget/responsive_task.dart';
import 'package:simple_nav_bar/responsive_screens/task/tasks/existing_customer.dart';
import 'package:simple_nav_bar/responsive_screens/task/tasks/intern.dart';
import 'package:simple_nav_bar/responsive_screens/task/tasks/new_customer.dart';

import '../themes.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(Tasks());
}

class Tasks extends StatefulWidget {
  const Tasks({Key? key}) : super(key: key);

  @override
  _TasksState createState() => _TasksState();
}

class _TasksState extends State<Tasks> {

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
      home: TasksPage(title: 'ta_appbar1'.tr),
      title: 'Flutter Theme Demo',
      debugShowCheckedModeBanner: false,
      theme: CustomTheme.lightTheme,
      darkTheme: CustomTheme.darkTheme,
      themeMode: currentTheme.currentTheme,
    );
  }
}


class TasksPage extends StatefulWidget {
  TasksPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _TasksPageState createState() => _TasksPageState();
}

class _TasksPageState extends State<TasksPage> {

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final currentWidth = (MediaQuery.of(context).size.width.toString()).split(".")[0];
    final currentHeight = (MediaQuery.of(context).size.height.toString()).split(".")[0];
    return Scaffold(
      backgroundColor: theme.backgroundColor,
      appBar: AppBar(
        title: Text("ta_appbar1".tr /*+ " " + currentWidth+"x"+currentHeight*/,
          style: theme.textTheme.caption,
        ),
        elevation: 0,
        actions: [
          Padding(
              padding: const EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (_) => const SettingsPage(title: "se_appbar1")));
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
          final mxWidth = constraints.maxWidth;
          //small devices
          if(constraints.maxHeight < 400){
            final _cons1 = mxHeight*0.18; // Padding from top
            final _cons2 = mxHeight*0.04; //padding between buttons
            final _cons3 = mxWidth*0.8; // button size
            final _cons4 = mxHeight*0.1; // New Task fontsize
            return ResponsiveTask(cons1: _cons1,cons2: _cons2,cons3: _cons3,cons4: _cons4,);
          }else if(constraints.maxHeight > 400 && constraints.maxHeight < 500){
            final _cons1 = mxHeight*0.17; // Padding from top
            final _cons2 = mxHeight*0.04; //padding between buttons
            final _cons3 = mxWidth*0.85; // button size
            final _cons4 = mxHeight*0.11; // New Task fontsize
            return ResponsiveTask(cons1: _cons1,cons2: _cons2,cons3: _cons3,cons4: _cons4,);
          }else if(constraints.maxHeight > 500 && constraints.maxHeight < 600){
            final _cons1 = mxHeight*0.18; // Padding from top
            final _cons2 = mxHeight*0.04; //padding between buttons
            final _cons3 = mxWidth*0.8; // button size
            final _cons4 = mxHeight*0.1; // New Task fontsize
            return ResponsiveTask(cons1: _cons1,cons2: _cons2,cons3: _cons3,cons4: _cons4,);
          }else if(constraints.maxHeight > 600 && constraints.maxHeight < 700){
            final _cons1 = mxHeight*0.18; // Padding from top
            final _cons2 = mxHeight*0.04; //padding between buttons
            final _cons3 = mxWidth*0.8; // button size
            final _cons4 = mxHeight*0.1; // New Task fontsize
            return ResponsiveTask(cons1: _cons1,cons2: _cons2,cons3: _cons3,cons4: _cons4,);
          }else if(constraints.maxHeight > 700 && constraints.maxHeight < 800) {
            final _cons1 = mxHeight*0.18; // Padding from top
            final _cons2 = mxHeight*0.04; //padding between buttons
            final _cons3 = mxWidth*0.8; // button size
            final _cons4 = mxHeight*0.1; // New Task fontsize
            return ResponsiveTask(cons1: _cons1,cons2: _cons2,cons3: _cons3,cons4: _cons4,);
          }else{
            final _cons1 = mxHeight*0.15; // Padding from top
            final _cons2 = mxHeight*0.03; //padding between buttons
            final _cons3 = mxWidth*0.85; // button size
            final _cons4 = mxHeight*0.08; // New Task fontsize
            return ResponsiveTask(cons1: _cons1,cons2: _cons2,cons3: _cons3,cons4: _cons4,);
          }
        },
      )
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}