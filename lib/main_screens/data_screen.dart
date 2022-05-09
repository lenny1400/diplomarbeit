import 'package:csv/csv.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simple_nav_bar/responsive_screens/data/data_screens/export/export_task.dart';
import 'package:simple_nav_bar/responsive_screens/data/data_screens/import/importfiles.dart';
import 'package:simple_nav_bar/responsive_screens/data/data_screens/taskmanagement/taskmanagement.dart';
import 'package:simple_nav_bar/responsive_screens/home/settings.dart';
import 'dart:io' as io;
import '../themes.dart';
import '../responsive_screens/data/data_screens/export/exportfiles.dart';

Future main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(Data());
}

class Data extends StatefulWidget {
  const Data({Key? key}) : super(key: key);

  @override
  _DataState createState() => _DataState();
}

class _DataState extends State<Data> {

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
      home: DataPage(title: 'da_appbarData'.tr),
      debugShowCheckedModeBanner: false,
      theme: CustomTheme.lightTheme,
      darkTheme: CustomTheme.darkTheme,
      themeMode: currentTheme.currentTheme,
    );
  }
}

class DataPage extends StatefulWidget {
  const DataPage({Key? key,required this.title}) : super(key: key);

  final String title;

  @override
  _DataPageState createState() => _DataPageState();
}

class _DataPageState extends State<DataPage> {

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final currentWidth = (MediaQuery.of(context).size.width.toString()).split(".")[0];
    final currentHeight = (MediaQuery.of(context).size.height + (MediaQuery.of(context).padding.top + kToolbarHeight)).toString().split(".")[0];
    final _bodyHeight = MediaQuery.of(context).size.height - (MediaQuery.of(context).padding.top + kToolbarHeight);
    final _bottomNavBarHeight = MediaQuery.of(context).size.height - _bodyHeight;
    print("Navbar: " + _bottomNavBarHeight.toString());
    return Scaffold(
      backgroundColor: theme.backgroundColor,
      appBar: AppBar(
        title: Text("da_appbarData".tr + " " + currentWidth+"x"+currentHeight,
          style: theme.textTheme.caption,
        ),
        elevation: 0,
        actions: [
          Padding(
              padding: const EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (_) => const SettingsPage(title: "se_appbar1")));
                },
                child: const Icon(
                    Icons.settings
                ),
              )
          ),
        ],
        actionsIconTheme: IconThemeData(
            size: 30.0,
            color: theme.shadowColor,
            opacity: 12.0
        ),
      ),
      body: Center(
        child: FittedBox(
          fit: BoxFit.fitHeight,
          alignment: Alignment.center,
          child: Container(
            height: _bodyHeight,
            width: MediaQuery.of(context).size.width*1,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  width: MediaQuery.of(context).size.width*1,
                  height: _bodyHeight*0.07,
                ),
                SizedBox(
                    width: MediaQuery.of(context).size.width * 0.90,
                    height: _bodyHeight*0.07,
                    child: FloatingActionButton(
                      elevation: 0,
                      backgroundColor: theme.cardColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      ),
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (_) => ImportFiles()));
                      },
                      child: Text(
                        'da_import'.tr,
                        style: theme.textTheme.bodyText1,
                      ),
                    )
                ),
                Padding(
                  padding: EdgeInsets.only(top: _bodyHeight*0.03),
                ),
                SizedBox(
                    width: MediaQuery.of(context).size.width * 0.90,
                    height: _bodyHeight*0.07,
                    child: FloatingActionButton(
                      elevation: 0,
                      backgroundColor: theme.cardColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      ),
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (_) => export_task()));
                      },
                      child: Text(
                        'da_export'.tr,
                        style: theme.textTheme.bodyText1,
                      ),
                    )
                ),
                Padding(
                  padding: EdgeInsets.only(top: _bodyHeight*0.03),
                ),
                SizedBox(
                    width: MediaQuery.of(context).size.width * 0.90,
                    height: _bodyHeight*0.07,
                    child: FloatingActionButton(
                      elevation: 0,
                      backgroundColor: theme.cardColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      ),
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (_) => ManagementPage(title: "da_appbarManage".tr)));
                      },
                      child: Text(
                        'da_manage'.tr,
                        style: theme.textTheme.bodyText1,
                      ),
                    )
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}