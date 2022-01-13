import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../themes.dart';

class TaskManagement extends StatefulWidget {
  const TaskManagement({Key? key}) : super(key: key);

  @override
  _TaskManagementState createState() => _TaskManagementState();
}

class _TaskManagementState extends State<TaskManagement> {

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
      home: ManagementPage(title: 'Manage Tasks'),
      debugShowCheckedModeBanner: false,
      theme: CustomTheme.lightTheme,
      darkTheme: CustomTheme.darkTheme,
      themeMode: currentTheme.currentTheme,
    );
  }
}

class ManagementPage extends StatefulWidget {
  const ManagementPage({Key? key, required String this.title,}) : super(key: key);

  final String title;

  @override
  _ManagementPageState createState() => _ManagementPageState();
}

class _ManagementPageState extends State<ManagementPage> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.backgroundColor,
      appBar: AppBar(
        title: Text(
          widget.title,
          style: theme.textTheme.caption,
        ),
        elevation: 0,
      ),
      body: Center(
        child: FittedBox(
          fit: BoxFit.fitHeight,
          alignment: Alignment.center,
          child: Container(
            child: Text("Tasks"),
          ),
        ),
      ),
    );
  }
}

