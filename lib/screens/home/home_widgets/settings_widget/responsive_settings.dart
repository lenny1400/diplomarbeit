import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:simple_nav_bar/screens/login/login_register.dart';

import '../../../../themes.dart';

class ResponsiveSettings extends StatefulWidget {
  const ResponsiveSettings({
    Key? key,
    required this.constraints,
    required this.cons1,
    required this.cons2,
    required this.cons3,
    required this.cons4,
    required this.cons5,
  }) : super(key: key);

  final constraints;
  final cons1;
  final cons2;
  final cons3;
  final cons4;
  final cons5;

  @override
  _ResponsiveSettingsState createState() => _ResponsiveSettingsState();
}

class _ResponsiveSettingsState extends State<ResponsiveSettings> {

  final switchData = GetStorage();
  bool isSwitched = false;

  @override
  void initState() {
    super.initState();

    if(switchData.read('isSwitched') != null)
    {
      setState(() {
        isSwitched = switchData.read('isSwitched');
      });
    }
  }

  final List locales =[
    {
      'name': 'English',
      'locale': Locale('en', 'US')
    },
    {
      'name': 'Deutsch',
      'locale': Locale('de', 'DE')
    },
  ];


  showLocaleDialog(BuildContext context) {
    final theme = Theme.of(context);

    showDialog(context: context,

      builder: (_) => AlertDialog(
        backgroundColor: theme.backgroundColor,
        title: Text(
          "se_dialogText".tr,
          style: TextStyle(
            color: theme.shadowColor,
          ),
        ),
        content: Container(
          width: double.maxFinite,
          child: ListView.separated(
            shrinkWrap: true,
              itemBuilder: (context, index) =>
                  InkWell(
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 8.0),
                      child: Text(
                          locales[index]['name'],
                        style: TextStyle(
                          color: theme.cardColor,
                        ),
                      ),
                    ),
                    onTap: () => updateLocale(
                        locales[index]['locale'],
                        context
                    ),
                  ),
              separatorBuilder: (context, index) =>
                  Divider(
                    color: theme.dividerColor,
                  ),
              itemCount: 2
          ),
        ),
      ),
    );
  }

  updateLocale(Locale locale, BuildContext context){
    Navigator.of(context).pop();
    Get.updateLocale(locale);
  }

  void signOut(){

    FirebaseAuth.instance
        .authStateChanges()
        .listen((User? user) async {
      if (user == null) {
        print('User is currently signed out!');
      } else {
        print('User is signed in!');
        await FirebaseAuth.instance.signOut();
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginRegister()),);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final mdHeight = MediaQuery.of(context).size.height*1;
    final mdWidth = MediaQuery.of(context).size.width*1;
    //constants
    final _cons1 = widget.cons1;
    final _cons2 = widget.cons2;
    final _cons3 = widget.cons3;
    final _cons4 = widget.cons4;
    final _cons5 = widget.cons5;
    // const main size constraint
    final constraintX = widget.constraints;

    return Center(
      child: FittedBox(
        fit: BoxFit.fitHeight,
        alignment: Alignment.center,
        child: Container(
          width: mdWidth,
          height: mdHeight,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: _cons4,left: _cons3),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'se_title1'.tr,
                    style: TextStyle(
                      fontSize: _cons2,
                      color: theme.dividerColor,
                      fontWeight: FontWeight.w500
                    ),
                  ),
                ),
              ),
              Flexible(
                  child: Padding(
                    padding: EdgeInsets.only(left: _cons2, right: _cons2, top: _cons1),
                    child: Container(
                      height: _cons5,
                      child: TextButton(
                        onPressed: (){
                          //Navigator.push(context, MaterialPageRoute(builder: (_) => LoginRegister()));
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
                                        color: theme.cardColor,
                                        size: _cons4
                                    ),
                                    child: Icon(CupertinoIcons.person_alt),
                                  ),
                                ),
                              ),
                              flex: 1,
                            ),
                            Expanded(
                              child: Padding(
                                padding: EdgeInsets.only(left: _cons2, right: _cons1,top: _cons1,bottom: _cons1),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Padding(
                                        padding: EdgeInsets.only(left: _cons1),
                                        child: Text(
                                          "Romeo Colic",
                                          style: TextStyle(
                                            color: theme.dividerColor,
                                            fontSize: _cons2,
                                            fontWeight: FontWeight.w500
                                          ),
                                        ),
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment.centerRight,
                                      child: IconTheme(
                                        data: new IconThemeData(
                                            color: theme.cardColor,
                                            size: _cons3
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
                padding: EdgeInsets.only(top: _cons3,left: _cons3),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'se_title2'.tr,
                    style: TextStyle(
                        fontSize: _cons2,
                        color: theme.dividerColor,
                        fontWeight: FontWeight.w500
                    ),
                  ),
                ),
              ),
              Flexible(
                  child: Padding(
                    padding: EdgeInsets.only(left: _cons2,right: _cons2,top: _cons1),
                    child: Container(
                      height: _cons5,
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
                                        color: theme.cardColor,
                                        size: _cons4
                                    ),
                                    child: Icon(CupertinoIcons.moon_fill),
                                  ),
                                ),
                              ),
                              flex: 1,
                            ),
                            Expanded(
                              child: Padding(
                                padding: EdgeInsets.only(left: _cons2, right: _cons1,top: _cons1,bottom: _cons1),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Padding(
                                        padding: EdgeInsets.only(left: _cons1),
                                        child: Text(
                                          "se_subtitle1".tr,
                                          style: TextStyle(
                                              color: theme.dividerColor,
                                              fontSize: _cons2,
                                              fontWeight: FontWeight.w500
                                          ),
                                        ),
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment.centerRight,
                                      child: Padding(
                                        padding: EdgeInsets.only(left: _cons2),
                                        child: Transform.scale(
                                          scale: 1.5,
                                          child: Switch(
                                            activeTrackColor: theme.scaffoldBackgroundColor,
                                            activeColor: theme.dividerColor,
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
                    padding: EdgeInsets.only(left: _cons2,right: _cons2,top: _cons1),
                    child: Container(
                      height: _cons5,
                      child: TextButton(
                        onPressed: () => showLocaleDialog(context),
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
                                        color: theme.cardColor,
                                        size: _cons4
                                    ),
                                    child: Icon(CupertinoIcons.bubble_left_bubble_right_fill),
                                  ),
                                ),
                              ),
                              flex: 1,
                            ),
                            Expanded(
                              child: Padding(
                                padding: EdgeInsets.only(left: _cons2, right: _cons1,top: _cons1,bottom: _cons1),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Padding(
                                        padding: EdgeInsets.only(left: _cons1),
                                        child: Text(
                                          "se_subtitle2".tr,
                                          style: TextStyle(
                                              color: theme.dividerColor,
                                              fontSize: _cons2,
                                              fontWeight: FontWeight.w500
                                          ),
                                        ),
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment.centerRight,
                                      child: Padding(
                                        padding: EdgeInsets.only(left: _cons1),
                                        child: Text(
                                          "se_select".tr,
                                          style: TextStyle(
                                            color: theme.cardColor,
                                            fontSize: _cons2/1.35,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment.center,
                                      child: IconTheme(
                                        data: new IconThemeData(
                                            color: theme.cardColor,
                                            size: _cons3
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
                    padding: EdgeInsets.only(left: _cons2,right: _cons2,top: _cons1),
                    child: Container(
                      height: _cons5,
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
                                        color: theme.cardColor,
                                        size: _cons4
                                    ),
                                    child: Icon(CupertinoIcons.bell_fill),
                                  ),
                                ),
                              ),
                              flex: 1,
                            ),
                            Expanded(
                              child: Padding(
                                padding: EdgeInsets.only(left: _cons2, right: _cons1,top: _cons1,bottom: _cons1),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Padding(
                                        padding: EdgeInsets.only(left: _cons1),
                                        child: Text(
                                          "se_subtitle3".tr,
                                          style: TextStyle(
                                              color: theme.dividerColor,
                                              fontSize: _cons2,
                                              fontWeight: FontWeight.w500
                                          ),
                                        ),
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment.centerRight,
                                      child: IconTheme(
                                        data: new IconThemeData(
                                            color: theme.cardColor,
                                            size: _cons3
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
                    padding: EdgeInsets.only(left: _cons2, right: _cons2,top: _cons1,),
                    child: Container(
                      height: _cons5,
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
                                        color: theme.cardColor,
                                        size: _cons4
                                    ),
                                    child: Icon(CupertinoIcons.mail_solid),
                                  ),
                                ),
                              ),
                              flex: 1,
                            ),
                            Expanded(
                              child: Padding(
                                padding: EdgeInsets.only(left: _cons2, right: _cons1,top: _cons1,bottom: _cons1),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Padding(
                                        padding: EdgeInsets.only(left: _cons1),
                                        child: Text(
                                          "se_subtitle4".tr,
                                          style: TextStyle(
                                              color: theme.dividerColor,
                                              fontSize: _cons2,
                                              fontWeight: FontWeight.w500
                                          ),
                                        ),
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment.centerRight,
                                      child: IconTheme(
                                        data: new IconThemeData(
                                            color: theme.cardColor,
                                            size: _cons3
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
                    padding: EdgeInsets.only(left: _cons2,right: _cons2,top: _cons1),
                    child: Container(
                      height: _cons5,
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
                                        color: theme.cardColor,
                                        size: _cons4
                                    ),
                                    child: Icon(CupertinoIcons.info_circle_fill),
                                  ),
                                ),
                              ),
                              flex: 1,
                            ),
                            Expanded(
                              child: Padding(
                                padding: EdgeInsets.only(left: _cons2, right: _cons1,top: _cons1,bottom: _cons1),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Padding(
                                        padding: EdgeInsets.only(left: _cons1),
                                        child: Text(
                                          "se_subtitle5".tr,
                                          style: TextStyle(
                                              color: theme.dividerColor,
                                              fontSize: _cons2,
                                              fontWeight: FontWeight.w500
                                          ),
                                        ),
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment.centerRight,
                                      child: IconTheme(
                                        data: new IconThemeData(
                                            color: theme.cardColor,
                                            size: _cons3
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
                    padding: EdgeInsets.only(top: _cons2,),
                    child: Align(
                      alignment: Alignment.center,
                      child: Container(
                        width: mdWidth*0.5,
                        height: _cons4,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: theme.cardColor,
                            onPrimary: theme.cardColor,
                            shape: new RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(10.0),
                            ),
                          ),
                          onPressed: (){
                            setState(() {
                              signOut();
                            });
                          },
                          child: Text(
                            "se_logout".tr,
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                              fontSize: _cons2*1.2
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
