import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../../themes.dart';

class SupportPage extends StatefulWidget {
  const SupportPage({Key? key}) : super(key: key);

  @override
  _SupportPageState createState() => _SupportPageState();
}

class _SupportPageState extends State<SupportPage> {

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
      home: SupportWidgetPage(),
      debugShowCheckedModeBanner: false,
      theme: CustomTheme.lightTheme,
      darkTheme: CustomTheme.darkTheme,
      themeMode: currentTheme.currentTheme,
    );
  }
}

class SupportWidgetPage extends StatefulWidget {
  const SupportWidgetPage({Key? key}) : super(key: key);

  @override
  _SupportWidgetPageState createState() => _SupportWidgetPageState();
}

class _SupportWidgetPageState extends State<SupportWidgetPage> {

  final myControllerText = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.backgroundColor,
      appBar: AppBar(
        title: Text("Support",
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
                  padding: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.03),
                  child: Text(
                    "Your Problem",
                    style: TextStyle(
                      fontSize: MediaQuery.of(context).size.height*0.02,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.01),
                  child: Container(
                    height: MediaQuery.of(context).size.height*0.15,
                    child: TextField(
                      controller: myControllerText,
                      maxLines: 5,
                      style: TextStyle(
                          color: theme.shadowColor
                      ),
                      decoration: InputDecoration(
                        isDense: true,
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          borderSide: BorderSide(color: theme.shadowColor),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          borderSide: BorderSide(color: theme.shadowColor),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.01),
                  child: Align(
                    alignment: Alignment.center,
                    child: Container(
                      height: MediaQuery.of(context).size.height*0.05,
                      width: MediaQuery.of(context).size.width*0.25,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: theme.cardColor,
                          onPrimary: theme.cardColor,
                          shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(10.0),
                          ),
                        ),
                        onPressed: () {

                        },
                        child: Text(
                          "Send",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: MediaQuery.of(context).size.width*0.045,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.03),
                  child: Text(
                    "Call us",
                    style: TextStyle(
                        fontSize: MediaQuery.of(context).size.height*0.02,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.01),
                  child: Text(
                    "+4369910016902",
                    style: TextStyle(
                        fontSize: MediaQuery.of(context).size.height*0.02,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.03),
                  child: Text(
                    "Email us",
                    style: TextStyle(
                        fontSize: MediaQuery.of(context).size.height*0.02,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.01),
                  child: Text(
                    "support@rocomp.at",
                    style: TextStyle(
                      fontSize: MediaQuery.of(context).size.height*0.02,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
