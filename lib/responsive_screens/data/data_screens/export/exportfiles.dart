import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../themes.dart';
import 'exportconfig.dart';

Future main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(ExportFiles());
}

class ExportFiles extends StatefulWidget {
  const ExportFiles({Key? key}) : super(key: key);

  @override
  _ExportFilesState createState() => _ExportFilesState();
}

class _ExportFilesState extends State<ExportFiles> {

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
      home: ExportFilesPage(),
      title: 'Flutter Theme Demo',
      debugShowCheckedModeBanner: false,
      theme: CustomTheme.lightTheme,
      darkTheme: CustomTheme.darkTheme,
      themeMode: currentTheme.currentTheme,
    );
  }

}

class ExportFilesPage extends StatefulWidget {
  const ExportFilesPage({Key? key}) : super(key: key);

  @override
  _ExportFilesPageState createState() => _ExportFilesPageState();
}

class _ExportFilesPageState extends State<ExportFilesPage> {
  int childrenCount = 0;
  List<String> csvFiles = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {sizeofCSVSP();});
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {getCSVSharedPreferences();});
    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      appBar: AppBar(
          title: Text("da_appbarExport".tr,
            style: theme.textTheme.bodySmall,
          ),
          elevation: 0,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(left: 10.0, right: 10.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ListView.builder(
                  padding: const EdgeInsets.all(8),
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: childrenCount,
                  itemBuilder: (BuildContext context, int index){
                    return Container(
                      margin: EdgeInsets.only(bottom: 5, right: 10,left: 10,top: 20),
                      child: CupertinoButton(
                        onPressed: () async {
                          String csvFile = '${csvFiles[index]}';
                          String data = await getStringSharedPreferences(csvFile);
                          Navigator.push(context, MaterialPageRoute(builder: (context) => ShowFile(csvFile: data,)));
                        },
                        child: Text(
                            ('${csvFiles[index]}')
                        ),
                        color: theme.cardColor,
                      ),
                    );
                  },
                )
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: theme.cardColor,
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => ExportOptions()));
        },
        child: Icon(CupertinoIcons.forward,color: theme.primaryColor,),
      ),
    );
  }

  Future<String> getStringSharedPreferences(String csvFile)async{
    final prefs = await SharedPreferences.getInstance();
    final String data;

    data = prefs.getString(csvFile+".csv").toString();
    return data;
  }

  Future<void> getCSVSharedPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    final keys = prefs.getKeys();

    for(String key in keys) {
      if(key.contains('.csv')){
        csvFiles.add(key.split('.')[0]);
      }
    }
  }

  void sizeofCSVSP() async {
    final prefs = await SharedPreferences.getInstance();
    final keys = prefs.getKeys();
    var count = 0;

    for(String key in keys) {
      //prefsMap[key] = prefs.get(key);
      if(key.contains('.csv')){
        count = count + 1;
      }
    }
    childrenCount = count;
  }
}

class ShowFile extends StatefulWidget {
  const ShowFile({Key? key,required this.csvFile}) : super(key: key);

  final String csvFile;

  @override
  _ShowFileState createState() => _ShowFileState();
}

class _ShowFileState extends State<ShowFile> {
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
      home: ShowFilePage(csvFile: widget.csvFile,),
      title: 'Flutter Theme Demo',
      debugShowCheckedModeBanner: false,
      theme: CustomTheme.lightTheme,
      darkTheme: CustomTheme.darkTheme,
      themeMode: currentTheme.currentTheme,
    );
  }
}

class ShowFilePage extends StatefulWidget {
  const ShowFilePage({Key? key, required this.csvFile}) : super(key: key);

  final String csvFile;

  @override
  _ShowFilePageState createState() => _ShowFilePageState();
}

class _ShowFilePageState extends State<ShowFilePage> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      appBar: AppBar(
        title: Text("Show File",
          style: theme.textTheme.bodySmall,
        ),
        elevation: 0,
      ),
      body: Center(
        child: FittedBox(
          alignment: Alignment.center,
          fit: BoxFit.fitHeight,
          child: Container(
            height: MediaQuery.of(context).size.height*1,
            width: MediaQuery.of(context).size.width*1,
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  widget.csvFile,
                style: theme.textTheme.headlineMedium,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}



