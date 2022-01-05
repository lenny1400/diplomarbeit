import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../../themes.dart';

class HelpPage extends StatefulWidget {
  const HelpPage({Key? key}) : super(key: key);

  @override
  _HelpPageState createState() => _HelpPageState();
}

class _HelpPageState extends State<HelpPage> {
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
      home: HelpWidgetPage(),
      debugShowCheckedModeBanner: false,
      theme: CustomTheme.lightTheme,
      darkTheme: CustomTheme.darkTheme,
      themeMode: currentTheme.currentTheme,
    );
  }
}

class HelpWidgetPage extends StatefulWidget {
  const HelpWidgetPage({Key? key}) : super(key: key);

  @override
  _HelpWidgetPageState createState() => _HelpWidgetPageState();
}

class _HelpWidgetPageState extends State<HelpWidgetPage> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.backgroundColor,
      appBar: AppBar(
        title: Text("Help",
        style: theme.textTheme.caption,
        ),
      ),
      body: Center(
        child: FittedBox(
          fit: BoxFit.fitHeight,
          alignment: Alignment.center,
          child: Container(
            height: MediaQuery.of(context).size.height*1,
            width: MediaQuery.of(context).size.width*1,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.02, bottom: MediaQuery.of(context).size.height*0.02),
                  child: Text(
                    "FAQ",
                    style: TextStyle(
                      fontSize: MediaQuery.of(context).size.height*0.05,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.02),
                  child: Text(
                    "Q: How do i change accounts?",
                    style: TextStyle(
                        fontSize: MediaQuery.of(context).size.height*0.02,
                        fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.01),
                  child: Text(
                    "A: Click on the logout button and sign-in with another account",
                    style: TextStyle(
                        fontSize: MediaQuery.of(context).size.height*0.02,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.02),
                  child: Text(
                    "Q: How do i change accounts?",
                    style: TextStyle(
                        fontSize: MediaQuery.of(context).size.height*0.02,
                        fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.01),
                  child: Text(
                    "A: Click on the logout button and sign-in with another account",
                    style: TextStyle(
                        fontSize: MediaQuery.of(context).size.height*0.02,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.02),
                  child: Text(
                    "Q: How do i change accounts?",
                    style: TextStyle(
                        fontSize: MediaQuery.of(context).size.height*0.02,
                        fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.01),
                  child: Text(
                    "A: Click on the logout button and sign-in with another account",
                    style: TextStyle(
                        fontSize: MediaQuery.of(context).size.height*0.02,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      )
    );
  }
}
