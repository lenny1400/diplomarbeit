import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:simple_nav_bar/screens/task/tasks/existing_customer.dart';
import 'package:simple_nav_bar/screens/task/tasks/intern.dart';
import 'package:simple_nav_bar/screens/task/tasks/new_customer.dart';

import '../../themes.dart';

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
      home: TasksPage(title: 'Tasks'),
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

    return Scaffold(
      backgroundColor: theme.backgroundColor,
      appBar: AppBar(
        title: Text(widget.title,
          style: theme.textTheme.headline6,
        ),
        elevation: 0,
      ),
      body: Center(
          child: FittedBox(
            fit: BoxFit.fitHeight,
            alignment: Alignment.center,
            child: Container(
              width: MediaQuery.of(context).size.width*1,
              height: MediaQuery.of(context).size.height*1,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Container(
                      width: MediaQuery.of(context).size.width*1,
                      height: MediaQuery.of(context).size.height*0.2,
                      child: Padding(
                        padding: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.12,),
                        child: Text(
                          'New Task',
                          textAlign: TextAlign.center,
                          style: theme.textTheme.bodyText2,
                        ),
                      )
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width*1,
                    height: MediaQuery.of(context).size.height*0.18,
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height*0.07,
                    width: MediaQuery.of(context).size.width*0.8,
                    child: FloatingActionButton(
                      elevation: 0,
                      heroTag: "btnIntern",
                      backgroundColor: theme.cardColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      ),
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (_) => InternPage(title: 'Intern',)));
                      },
                      child: Text(
                        'Intern',
                        style: theme.textTheme.bodyText1,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width*0.95,
                    height: MediaQuery.of(context).size.height*0.03,
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height*0.07,
                    width: MediaQuery.of(context).size.width*0.8,
                    child: FloatingActionButton(
                      elevation: 0,
                      heroTag: "btnNewCustomer",
                      backgroundColor: theme.cardColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      ),
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (_) => NewCustomerPage(title: 'New Customer',)));
                      },
                      child: Text(
                        'Neuer Kunde',
                        style: theme.textTheme.bodyText1,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width*0.95,
                    height: MediaQuery.of(context).size.height*0.03,
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height*0.07,
                    width: MediaQuery.of(context).size.width*0.8,
                    child: FloatingActionButton(
                      elevation: 0,
                      heroTag: "btnExisitngCustomer",
                      backgroundColor: theme.cardColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      ),
                      onPressed: () {
                        int pop = 1;
                        Navigator.push(context, MaterialPageRoute(builder: (_) => ExistingCustomerPage(title: 'Existing Customer',pop: pop,)));
                      },
                      child: Text(
                        'Bestehender Kunde',
                        style: theme.textTheme.bodyText1,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}