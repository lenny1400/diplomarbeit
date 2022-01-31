import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simple_nav_bar/custom_widgets/preferences_service.dart';
import 'package:simple_nav_bar/responsive_screens/home/home_widgets/settings_widget/settings_pages/help.dart';
import 'package:simple_nav_bar/responsive_screens/home/home_widgets/settings_widget/settings_pages/notifications.dart';
import 'package:simple_nav_bar/responsive_screens/home/home_widgets/settings_widget/settings_pages/support.dart';
import 'package:simple_nav_bar/user_management/login_register.dart';
import '../../../../themes.dart';
import '../../../../custom_widgets/models.dart';

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

  final _preferencesService = PreferenceService();
  bool isSwitched = false;


  @override
  void initState() {
    super.initState();
    _populateFields(); //Activates the Function to load the Shared Preferences
    currentTheme.addListener(() {
      if(this.mounted) { // check whether the state object is in tree
        setState(() {
          // make changes here
        });
      }
    });
  }

  //Saves the objects for the Shared Preferences
  void _saveSettings(){
    final newSettings = Settings(
        //language: locales['locale'],
        isSwitched: isSwitched);
    _preferencesService.saveSettings(newSettings);
  }

  //Reloads & Uploads the state of the switch
  void _populateFields() async{
    final settings = await _preferencesService.getSettings();
    setState(() {
      isSwitched = settings.isSwitched;
    });
  }

  @override
  void dispose() {
    super.dispose();
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

  void signOut() async{
    await FirebaseAuth.instance.signOut();
    Navigator.of(context, rootNavigator: true).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => LoginRegister()),(route) => false,);
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
              Flexible(
                  child: Padding(
                    padding: EdgeInsets.only(left: _cons2,right: _cons2,top: _cons1+35),
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
                                                _saveSettings();
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
                    padding: EdgeInsets.only(left: _cons2,right: _cons2,top: _cons1+15),
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
              /*Flexible(
                  child: Padding(
                    padding: EdgeInsets.only(left: _cons2,right: _cons2,top: _cons1),
                    child: Container(
                      height: _cons5,
                      child: TextButton(
                        onPressed: (){
                          Navigator.push(context, MaterialPageRoute(builder: (_) => const NotificationsPageWidget()));
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
              ),*/
              Flexible(
                  child: Padding(
                    padding: EdgeInsets.only(left: _cons2, right: _cons2,top: _cons1+15,),
                    child: Container(
                      height: _cons5,
                      child: TextButton(
                        onPressed: (){
                          Navigator.push(context, MaterialPageRoute(builder: (_) => const SupportWidgetPage()));
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
                    padding: EdgeInsets.only(left: _cons2,right: _cons2,top: _cons1+15),
                    child: Container(
                      height: _cons5,
                      child: TextButton(
                        onPressed: (){
                          Navigator.push(context, MaterialPageRoute(builder: (_) => const HelpWidgetPage()));
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
