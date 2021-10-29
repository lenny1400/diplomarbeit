import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:simple_nav_bar/widgets/task_item.dart';

import '../../themes.dart';

class AllTasks extends StatefulWidget {
  const AllTasks({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _AllTasksState createState() => _AllTasksState();
}

class _AllTasksState extends State<AllTasks> {
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
      home: AllTasksPage(title: 'All Tasks'),
      title: 'Flutter Theme Demo',
      debugShowCheckedModeBanner: false,
      theme: CustomTheme.lightTheme,
      darkTheme: CustomTheme.darkTheme,
      themeMode: currentTheme.currentTheme,
    );
  }
}

class AllTasksPage extends StatefulWidget {
  const AllTasksPage({Key? key,required this.title}) : super(key: key);

  final String title;

  @override
  _AllTasksPageState createState() => _AllTasksPageState();
}

class _AllTasksPageState extends State<AllTasksPage> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.backgroundColor,
      appBar: AppBar(
        title: Text(widget.title,
          style: theme.textTheme.caption,
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: FittedBox(
            fit: BoxFit.fitHeight,
            alignment: Alignment.center,
            child: Container(
              width: MediaQuery.of(context).size.width*1,
              height: MediaQuery.of(context).size.height*1,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[

                  TaskItem(theme: theme, title: 'LeDuigou-22-08-Kassa'),
                  TaskItem(theme: theme, title: 'Max-Mustermann-22-08-Computer-Kauf'),
                  TaskItem(theme: theme, title: 'Intern-22-08'),
                  TaskItem(theme: theme, title: 'Häusle-20-08-Computer-Software'),
                  TaskItem(theme: theme, title: 'Fulterer-19-08-Computer-Hardware'),
                  TaskItem(theme: theme, title: 'Fulterer-19-08-Computer-Hardware'),
                  TaskItem(theme: theme, title: 'LeDuigou-22-08-Kassa'),
                  TaskItem(theme: theme, title: 'Max-Mustermann-22-08-Computer-Kauf'),
                  TaskItem(theme: theme, title: 'Intern-22-08'),
                  TaskItem(theme: theme, title: 'Häusle-20-08-Computer-Software'),
                  TaskItem(theme: theme, title: 'Fulterer-19-08-Computer-Hardware'),
                  TaskItem(theme: theme, title: 'Fulterer-19-08-Computer-Hardware'),

                Padding(padding: EdgeInsets.only(top: 20))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

