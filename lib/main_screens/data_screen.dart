import 'package:csv/csv.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simple_nav_bar/responsive_screens/data/data_screens/import/importfiles.dart';
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
      home: DataPage(title: 'Data'),
      title: 'Flutter Theme Demo',
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
            height: MediaQuery.of(context).size.height*1,
            width: MediaQuery.of(context).size.width*1,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                    width: MediaQuery.of(context).size.width * 0.90,
                    height: MediaQuery.of(context).size.height*0.07,
                    child: FloatingActionButton(
                      elevation: 0,
                      heroTag: "btnImport",
                      backgroundColor: theme.cardColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      ),
                      onPressed: () {
                        //int pop = 1;
                        //Navigator.push(context, MaterialPageRoute(builder: (_) => ExistingCustomerPage(title: 'Existing Customer',pop: pop,)));
                        Navigator.push(context, MaterialPageRoute(builder: (_) => ImportFiles()));
                      },
                      child: Text(
                        'Import',
                        style: theme.textTheme.bodyText1,
                      ),
                    )
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 30),),
                SizedBox(
                    width: MediaQuery.of(context).size.width * 0.90,
                    height: MediaQuery.of(context).size.height*0.07,
                    child: FloatingActionButton(
                      elevation: 0,
                      heroTag: "btnExport",
                      backgroundColor: theme.cardColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      ),
                      onPressed: () {
                        //int pop = 1;
                        //Navigator.push(context, MaterialPageRoute(builder: (_) => ExistingCustomerPage(title: 'Existing Customer',pop: pop,)));
                        Navigator.push(context, MaterialPageRoute(builder: (_) => ExportFiles()));
                      },
                      child: Text(
                        'Export',
                        style: theme.textTheme.bodyText1,
                      ),
                    )
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}