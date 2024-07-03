
import 'package:csv/csv.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../themes.dart';

Future main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(ImportedFiles());
}

class ImportedFiles extends StatefulWidget {
  const ImportedFiles({Key? key}) : super(key: key);

  @override
  _ImportedFilesState createState() => _ImportedFilesState();
}

class _ImportedFilesState extends State<ImportedFiles> {
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
      home: ImportedFilesPage(title: 'Imported Files', CSVList: [], fileName: '',),
      title: 'Flutter Theme Demo',
      debugShowCheckedModeBanner: false,
      theme: CustomTheme.lightTheme,
      darkTheme: CustomTheme.darkTheme,
      themeMode: currentTheme.currentTheme,
    );
  }
}

class ImportedFilesPage extends StatefulWidget {
  const ImportedFilesPage({Key? key, required this.title,required this.fileName,required this.CSVList}) : super(key: key);

  final String title;
  final String fileName;
  final List<List<dynamic>> CSVList;

  @override
  _ImportedFilesPageState createState() => _ImportedFilesPageState(CSVList,fileName);
}

class _ImportedFilesPageState extends State<ImportedFilesPage> {

  final List<List<dynamic>> CSVList;
  final String fileName;
  double iconSize = 40;

  cleanCSVFile(){
    String csv = CSVList.toString();
    var header = csv.split("\n");
    var rmvFirst = header[0].split("[[");
    print(rmvFirst[1]);
    var countRow = rmvFirst[1].contains(";");

  }

  @override
  void initState(){
    cleanCSVFile();
    super.initState();
  }

  _ImportedFilesPageState(this.CSVList,this.fileName);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      appBar: AppBar(
        title: Text(widget.title,
          style: theme.textTheme.bodySmall,
        ),
        elevation: 0,
      ),
      body: Center(
        child: Container(
          height: MediaQuery.of(context).size.height*1,
          width: MediaQuery.of(context).size.width*1,
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Table(
                border: TableBorder.all(color: theme.shadowColor),
                defaultColumnWidth: IntrinsicColumnWidth(),
                children: CSVList.map((item) {
                  return TableRow(
                      children: item.map((row){
                        return Container(
                            child: Padding(
                              padding: const EdgeInsets.all(8),
                              child: Text(
                                row.toString(),
                                style: theme.textTheme.headlineMedium,
                              ),
                            )
                        );
                      }).toList());
                }).toList(),
              ),
            ),
          ),
        ),
      ),
        floatingActionButton: FloatingActionButton(
          elevation: 0,
          onPressed: () async {
            String msg = "";
            SharedPreferences prefs = await SharedPreferences.getInstance();
            String csv = const ListToCsvConverter().convert(CSVList);
            if(prefs.getString(fileName) == null) {
              try{
                prefs.setString(fileName, csv);
                prefs.setString('fileName', fileName);
                msg = 'File saved!';
              } catch(e){
                msg = e.toString();
              }
            }else{
              msg = 'File with same name already exists!';
            }
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(msg),
              ),
            );
          },
          backgroundColor: theme.cardColor,
          child: Icon(Icons.save,color: Colors.white,),
        )
    );
  }
}

