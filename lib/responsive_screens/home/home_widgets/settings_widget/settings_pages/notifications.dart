import 'package:flutter/material.dart';

import '../../../../../themes.dart';

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({Key? key}) : super(key: key);

  @override
  _NotificationsPageState createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {

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
      home: NotificationsPageWidget(),
      debugShowCheckedModeBanner: false,
      theme: CustomTheme.lightTheme,
      darkTheme: CustomTheme.darkTheme,
      themeMode: currentTheme.currentTheme,
    );
  }
}

class NotificationsPageWidget extends StatefulWidget {
  const NotificationsPageWidget({Key? key}) : super(key: key);

  @override
  _NotificationsPageWidgetState createState() => _NotificationsPageWidgetState();
}

class _NotificationsPageWidgetState extends State<NotificationsPageWidget> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final bool _switchNotif = false;
    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      appBar: AppBar(
        title: Text("Notifications",
          style: theme.textTheme.bodySmall,
        ),
      ),
      body: Center(
        child: FittedBox(
          fit: BoxFit.fitHeight,
          alignment: Alignment.center,
          child: Container(
            height: MediaQuery.of(context).size.height*1,
            width: MediaQuery.of(context).size.width*1,
            child: Padding(
              padding: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.2,right: MediaQuery.of(context).size.width*0.2,),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Text(
                      "On/Off",
                      style: TextStyle(
                        fontSize: MediaQuery.of(context).size.height*0.03
                      ),
                    ),
                  ),
                  Expanded(
                    child: Switch(
                      onChanged: (bool value) {
                        setState(() {
                          _switchNotif == !_switchNotif;
                        });
                      },
                      value: _switchNotif,
                    ),
                  )
                ],
              ),
            )
          ),
        ),
      ),
    );
  }
}
