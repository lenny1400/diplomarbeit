import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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
  final DatabaseReference _refSupp = FirebaseDatabase(databaseURL: "https://rocomp-app-d6d31-default-rtdb.europe-west1.firebasedatabase.app/").reference().child("Support");

  void uploadProblem() async{
    String _problem = myControllerText.text;
    String user = await FirebaseAuth.instance.currentUser!.uid.toString();
    DateTime now = DateTime.now();
    String date = DateFormat('yyyy-MM-dd - kk:mm:ss').format(now);

    _refSupp.child(user).child(date).child("Problem").set(_problem).then((value) => Navigator.pop(context));
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        elevation: 0,
        title: Text("Support",
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
                    height: MediaQuery.of(context).size.height*0.2,
                    child: TextField(
                      controller: myControllerText,
                      maxLines: 7,
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
                          foregroundColor: theme.cardColor, backgroundColor: theme.cardColor,
                          shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(10.0),
                          ),
                        ),
                        onPressed: () {
                          if(myControllerText.text.isNotEmpty){
                            uploadProblem();
                          }
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
                    "Tel: +43 5576 98234",
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
                    "office@rocomp.at",
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
