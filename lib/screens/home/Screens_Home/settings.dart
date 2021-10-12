import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:simple_nav_bar/screens/login/login_register.dart';
import '../../../themes.dart';
import 'package:get_storage/get_storage.dart';

Future main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  await GetStorage.init();

  runApp(Settings(title: 'Settings',));
}

class Settings extends StatefulWidget {
  const Settings({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
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
      home: SettingsPage(title: 'Settings'),
      title: 'Flutter Theme Demo',
      debugShowCheckedModeBanner: false,
      theme: CustomTheme.lightTheme,
      darkTheme: CustomTheme.darkTheme,
      themeMode: currentTheme.currentTheme,
    );
  }
}

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key,required this.title}) : super(key: key);

  final String title;

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {

  final switchData = GetStorage();
  bool isSwitched = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    if(switchData.read('isSwitched') != null)
      {
        setState(() {
          isSwitched = switchData.read('isSwitched');
        });
      }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.backgroundColor,
        appBar: AppBar(
          title: Text(widget.title,
          style: theme.textTheme.caption,
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
              Padding(padding: EdgeInsets.only(top: 40)),
              Padding(
                padding: EdgeInsets.only(left: 40),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Account',
                    style: theme.textTheme.caption,
                  ),
                ),
              ),
              Padding(padding: EdgeInsets.only(top: 20)),
              Flexible(
                  child: Padding(
                    padding: EdgeInsets.only(left: 40,right: 20),
                    child: Container(
                      height: MediaQuery.of(context).size.height*0.1,
                      child: TextButton(
                        onPressed: (){
                          Navigator.push(context, MaterialPageRoute(builder: (_) => LoginRegister()));
                        },
                        style: TextButton.styleFrom(
                            onSurface: theme.backgroundColor,
                            primary: theme.backgroundColor
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(5),
                                child: Align(
                                  alignment: Alignment.center,
                                  child: IconTheme(
                                    data: new IconThemeData(
                                        color: theme.shadowColor,
                                        size: 60
                                    ),
                                    child: Icon(CupertinoIcons.person_alt),
                                  ),
                                ),
                              ),
                              flex: 1,
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(left: 10, right: 10,top: 5,bottom: 5),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Padding(
                                        padding: EdgeInsets.only(left: 10),
                                        child: Text(
                                          "Romeo Colic",
                                          style: theme.textTheme.headline5,
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
                                ),
                              ),
                              flex: 3,
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
              ),
              Padding(
                padding: EdgeInsets.only(left: 40, top: 20,bottom: 20),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Settings',
                    style: theme.textTheme.caption,
                  ),
                ),
              ),
              Flexible(
                  child: Padding(
                    padding: EdgeInsets.only(left: 40,right: 20),
                    child: Container(
                      height: MediaQuery.of(context).size.height*0.1,
                      child: TextButton(
                        onPressed: (){},
                        style: TextButton.styleFrom(
                            onSurface: theme.backgroundColor,
                            primary: theme.backgroundColor
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(5),
                                child: Align(
                                  alignment: Alignment.center,
                                  child: IconTheme(
                                    data: new IconThemeData(
                                        color: theme.shadowColor,
                                        size: 60
                                    ),
                                    child: Icon(CupertinoIcons.moon_fill),
                                  ),
                                ),
                              ),
                              flex: 1,
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(left: 10, right: 10,top: 5,bottom: 5),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Padding(
                                        padding: EdgeInsets.only(left: 10),
                                        child: Text(
                                          "Theme",
                                          style: theme.textTheme.headline5,
                                        ),
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment.centerRight,
                                      child: Padding(
                                        padding: EdgeInsets.only(left: 30),
                                        child: Transform.scale(
                                          scale: 1.5,
                                          child: Switch(
                                            activeTrackColor: theme.cardColor,
                                            activeColor: theme.shadowColor,
                                            inactiveTrackColor: theme.canvasColor,
                                            inactiveThumbColor: theme.scaffoldBackgroundColor,
                                            value: isSwitched,
                                            onChanged: (value){
                                              setState(() {
                                                isSwitched = value;
                                                switchData.write('isSwitched', isSwitched);
                                                currentTheme.toggleTheme();
                                              });
                                            },
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              flex: 3,
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
              ),
              Flexible(
                  child: Padding(
                    padding: EdgeInsets.only(left: 40,right: 20),
                    child: Container(
                      height: MediaQuery.of(context).size.height*0.1,
                      child: TextButton(
                        onPressed: (){},
                        style: TextButton.styleFrom(
                            onSurface: theme.backgroundColor,
                            primary: theme.backgroundColor
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(5),
                                child: Align(
                                  alignment: Alignment.center,
                                  child: IconTheme(
                                    data: new IconThemeData(
                                        color: theme.shadowColor,
                                        size: 60
                                    ),
                                    child: Icon(CupertinoIcons.bubble_left_bubble_right_fill),
                                  ),
                                ),
                              ),
                              flex: 1,
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(left: 10, right: 10,top: 5,bottom: 5),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Padding(
                                        padding: EdgeInsets.only(left: 10),
                                        child: Text(
                                          "Language",
                                          style: theme.textTheme.headline5,
                                        ),
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment.centerRight,
                                      child: Padding(
                                        padding: EdgeInsets.only(left: 10),
                                        child: Text(
                                          "English",
                                          style: theme.textTheme.subtitle1,
                                        ),
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment.center,
                                      child: IconTheme(
                                        data: new IconThemeData(
                                            color: theme.shadowColor,
                                            size: 35
                                        ),
                                        child: Icon(Icons.keyboard_arrow_right_sharp),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              flex: 3,
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
              ),
              Flexible(
                  child: Padding(
                    padding: EdgeInsets.only(left: 40,right: 20),
                    child: Container(
                      height: MediaQuery.of(context).size.height*0.1,
                      child: TextButton(
                        onPressed: (){},
                        style: TextButton.styleFrom(
                            onSurface: theme.backgroundColor,
                            primary: theme.backgroundColor
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(5),
                                child: Align(
                                  alignment: Alignment.center,
                                  child: IconTheme(
                                    data: new IconThemeData(
                                        color: theme.shadowColor,
                                        size: 60
                                    ),
                                    child: Icon(CupertinoIcons.bell_fill),
                                  ),
                                ),
                              ),
                              flex: 1,
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(left: 10, right: 10,top: 5,bottom: 5),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Padding(
                                        padding: EdgeInsets.only(left: 10),
                                        child: Text(
                                          "Notifications",
                                          style: theme.textTheme.headline5,
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
                                ),
                              ),
                              flex: 3,
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
              ),
              Flexible(
                  child: Padding(
                    padding: EdgeInsets.only(left: 40,right: 20),
                    child: Container(
                      height: MediaQuery.of(context).size.height*0.1,
                      child: TextButton(
                        onPressed: (){},
                        style: TextButton.styleFrom(
                            onSurface: theme.backgroundColor,
                            primary: theme.backgroundColor
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(5),
                                child: Align(
                                  alignment: Alignment.center,
                                  child: IconTheme(
                                    data: new IconThemeData(
                                        color: theme.shadowColor,
                                        size: 60
                                    ),
                                    child: Icon(CupertinoIcons.mail_solid),
                                  ),
                                ),
                              ),
                              flex: 1,
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(left: 10, right: 10,top: 5,bottom: 5),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Padding(
                                        padding: EdgeInsets.only(left: 10),
                                        child: Text(
                                          "Support",
                                          style: theme.textTheme.headline5,
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
                                ),
                              ),
                              flex: 3,
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
              ),
              Flexible(
                  child: Padding(
                    padding: EdgeInsets.only(left: 40,right: 20),
                    child: Container(
                      height: MediaQuery.of(context).size.height*0.1,
                      child: TextButton(
                        onPressed: (){},
                        style: TextButton.styleFrom(
                            onSurface: theme.backgroundColor,
                            primary: theme.backgroundColor
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(5),
                                child: Align(
                                  alignment: Alignment.center,
                                  child: IconTheme(
                                    data: new IconThemeData(
                                        color: theme.shadowColor,
                                        size: 60
                                    ),
                                    child: Icon(CupertinoIcons.info_circle_fill),
                                  ),
                                ),
                              ),
                              flex: 1,
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(left: 10, right: 10,top: 5,bottom: 5),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Padding(
                                        padding: EdgeInsets.only(left: 10),
                                        child: Text(
                                          "Help",
                                          style: theme.textTheme.headline5,
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
                                ),
                              ),
                              flex: 3,
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
              ),
              Expanded(
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
                    child: Align(
                      alignment: Alignment.center,
                      child: Container(
                        width: MediaQuery.of(context).size.width*0.4,
                        height: MediaQuery.of(context).size.height*0.06,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: theme.shadowColor,
                            onPrimary: theme.shadowColor,
                          ),
                          onPressed: (){},
                          child: Text(
                              "Log out",
                            style: theme.textTheme.subtitle2,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        )
      ),
    ),
    );
  }
}

