import 'package:csv/csv.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:io' as io;

import '../../../../themes.dart';
import 'importedfiles.dart';

Future main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(FromFile());
}

class FromFile extends StatefulWidget {
  const FromFile({Key? key}) : super(key: key);

  @override
  _FromFileState createState() => _FromFileState();
}

class _FromFileState extends State<FromFile> {
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
      home: FromFilePage(title: 'From Files'),
      debugShowCheckedModeBanner: false,
      theme: CustomTheme.lightTheme,
      darkTheme: CustomTheme.darkTheme,
      themeMode: currentTheme.currentTheme,
    );
  }
}

class FromFilePage extends StatefulWidget {
  const FromFilePage({Key? key,required this.title}) : super(key: key);

  final String title;

  @override
  _FromFilePageState createState() => _FromFilePageState();
}

class _FromFilePageState extends State<FromFilePage> {

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
          alignment: Alignment.center,
          fit: BoxFit.fitHeight,
          child: Container(
            height: MediaQuery.of(context).size.height*1,
            width: MediaQuery.of(context).size.width*1,
            child: Align(
              alignment: Alignment.center,
              child: Container(
                height: MediaQuery.of(context).size.height*0.07,
                width: MediaQuery.of(context).size.width*0.8,
                child: CupertinoButton(
                  onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (_) => Selected(theme: theme,)));
                  },
                  color: theme.cardColor,
                  padding: EdgeInsets.all(15),
                  child: Text('Pick File', style: theme.textTheme.bodyText1,),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class Selected extends StatefulWidget {
  const Selected({Key? key,required this.theme}) : super(key: key);

  final ThemeData theme;

  @override
  _SelectedState createState() => _SelectedState();
}

class _SelectedState extends State<Selected> {

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  String? _fileName;
  List<PlatformFile>? _paths;
  String? _directoryPath;
  String? _extension;
  String? filePath;
  bool _loadingPath = false;
  bool _multiPick = false;
  bool selectedFile = false;
  bool fromDatabaseBtnVisibile = true;
  FileType _pickingType = FileType.any;
  TextEditingController _controller = TextEditingController();

  late final bool isMultiPath;

  final String name = 'File';
  final String sizename = 'Size';
  final String datename = 'Date added';

  late final String filesize;
  final String date = new DateTime.now().toString();


  List<List<dynamic>> CSVList = List.empty();
  String fileName = "";

  void _openFileExplorer() async {
    setState(() => _loadingPath = true);
    try {
      _directoryPath = null;
      _paths = (await FilePicker.platform.pickFiles(
        type: _pickingType,
        allowMultiple: _multiPick,
        allowedExtensions: (_extension?.isNotEmpty ?? false)
            ? _extension?.replaceAll(' ', '').split(',')
            : null,
      ))
          ?.files;
    } on PlatformException catch (e) {
      print("Unsupported operation" + e.toString());
    } catch (ex) {
      print(ex);
    }

    filePath = _paths!.first.path.toString();

    if (!mounted) return;
    setState(() {
      _loadingPath = false;
      fileName = _paths!.first.name.toString();
      if(_paths!.first.size>0)
        selectedFile = true;
      fromDatabaseBtnVisibile = false;
      _fileName =
      _paths != null ? _paths!.map((e) => e.name).toString() : '...';
    });

    filesize = _paths!.first.size.toString()+' Bytes';

    readCounter();
  }

  Future<String?> get _localPath async {
    final directory = filePath;
    return directory;
  }

  Future<io.File> get _localFile async {
    final path = await _localPath;
    return io.File(path!);
  }

  Future<int> readCounter() async {
    try {
      final file = await _localFile;
      // Read the file
      final contents = await file.readAsString();
      List<List<dynamic>> rowsAsListOfValues = const CsvToListConverter(fieldDelimiter: ";").convert(contents);
      CSVList = rowsAsListOfValues;
      return int.parse(contents);
    } catch (e) {
      // If encountering an error, return 0
      return 0;
    }
  }
  //path = /data/user/0/com.example.btn_screen_data/cache/file_picker/testData.csv

  void _clearCachedFiles() {
    FilePicker.platform.clearTemporaryFiles().then((result) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: result! ? Colors.green : Colors.red,
          content: Text((result
              ? 'Temporary files removed with success.'
              : 'Failed to clean temporary files')),
        ),
      );
    });
  }

  @override
  void initState() {
    _openFileExplorer();
    super.initState();
    _controller.addListener(() => _extension = _controller.text);
  }

  @override
  Widget build(BuildContext context) {
    if(selectedFile){
      return Scaffold(
        backgroundColor: widget.theme.backgroundColor,
        appBar: AppBar(
          title: Text("Selected File",
            style: widget.theme.textTheme.caption,
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
              child: Align(
                alignment: Alignment.center,
                child: Padding(
                  padding: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.3),
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        height: 60,
                        child: ListTile(
                          title: Text(name,style: TextStyle(color: widget.theme.shadowColor,fontSize: 35,),),
                          contentPadding: EdgeInsets.only(bottom: 10,),
                          subtitle: Text(fileName,style: TextStyle(color: widget.theme.shadowColor,fontSize: 25,),),
                        ),
                      ),
                      SizedBox(
                        height: 50,
                      ),
                      Container(
                        height: 60,
                        child: ListTile(
                          title: Text(sizename,style: TextStyle(color: widget.theme.shadowColor,fontSize: 35,),),
                          contentPadding: EdgeInsets.only(bottom: 20,),
                          subtitle: Text(filesize,style: TextStyle(color: widget.theme.shadowColor,fontSize: 25,),),
                        ),
                      ),
                      SizedBox(
                        height: 50,
                      ),
                      Container(
                        height: 60,
                        child: ListTile(
                          title: Text(datename,style: TextStyle(color: widget.theme.shadowColor,fontSize: 35,),),
                          contentPadding: EdgeInsets.only(bottom: 20,),
                          subtitle: Text(date,style: TextStyle(color: widget.theme.shadowColor,fontSize: 25,),),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
          floatingActionButton: Padding(
              padding: const EdgeInsets.only(bottom:10, right: 5.0),
              child: Container(
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: Stack(
                    children: <Widget>[
                      if (selectedFile) FloatingActionButton(
                        elevation: 0,
                        backgroundColor: widget.theme.cardColor,
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => ImportedFilesPage(title: 'Imported Files', fileName: fileName,CSVList: CSVList,)));
                        },
                        child: Icon(CupertinoIcons.forward,color: Colors.white,),
                      ), // visible if showShould is true
                    ],
                  ),
                ),
              )
          )
      );
    }else{
      return Scaffold(
          backgroundColor: widget.theme.backgroundColor,
          appBar: AppBar(
            title: Text("No File found",
              style: widget.theme.textTheme.caption,
            ),
            elevation: 0,
          ),
          body: Center(
            child: Container(
              height: MediaQuery.of(context).size.height*0.07,
              width: MediaQuery.of(context).size.width*0.8,
              child: CupertinoButton(
                onPressed: (){
                  Navigator.pop(context);
                },
                color: widget.theme.cardColor,
                padding: EdgeInsets.all(15),
                child: Text("Go back"),
              ),
            )
          ),
      );
    }
  }
}


