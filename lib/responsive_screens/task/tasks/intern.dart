import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';

import '../../../themes.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(Intern());
}

class Intern extends StatefulWidget {
  const Intern({Key? key}) : super(key: key);

  @override
  _InternState createState() => _InternState();
}

class _InternState extends State<Intern> {

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
      home: InternPage(title: 'Intern'),
      title: 'Flutter Theme Demo',
      debugShowCheckedModeBanner: false,
      theme: CustomTheme.lightTheme,
      darkTheme: CustomTheme.darkTheme,
      themeMode: currentTheme.currentTheme,
    );
  }
}


class InternPage extends StatefulWidget {
  InternPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _InternPageState createState() => _InternPageState();
}

class _InternPageState extends State<InternPage> {

  String _selectedDate = 'Tap to select date';

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? d = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2021),
      lastDate: DateTime.now(),
    );
    if (d != null)
      setState(() {
        _selectedDate = DateFormat('yMMMMd').format(d);
      });
  }

  final myControllerText = TextEditingController();

  late bool _isTimeOkay = false;
  late bool _isDateOkay = false;
  late bool _isTextOkay = false;
  late bool _isEverythingOkay = false;
  Color _isEverythingOkayColor = Colors.red;
  String errorText = "";
  late TimeOfDay time = TimeOfDay.now();
  late TimeOfDay time2 = TimeOfDay.fromDateTime(DateTime.now().add(Duration(minutes: 1)));

  String getText() {
    // if (time == null) {
    //   return 'Select Time';
    // } else {
      final hours = time.hour.toString().padLeft(2, '0');
      final minutes = time.minute.toString().padLeft(2, '0');

      return '$hours:$minutes';
    // }
  }

  String getText2() {
    // if (time2 == null) {
    //   return 'Select Time';
    // } else {
      final hours = time2.hour.toString().padLeft(2, '0');
      final minutes = time2.minute.toString().padLeft(2, '0');

      return '$hours:$minutes';
    // }
  }

  Future pickTime(BuildContext context) async {
    final newTime = await showTimePicker(
      context: context,
      initialTime: time,
    );

    if (newTime == null) return;

    setState(() => time = newTime);
  }

  Future pickTime2(BuildContext context) async {
    final newTime = await showTimePicker(
      context: context,
      initialTime: time2,
    );

    if (newTime == null) return;

    setState(() => time2 = newTime);
  }

  void checkEverything(){
    if((time.hour.toInt()+time.minute.toInt()) < (time2.hour.toInt()+time2.minute.toInt())){
      _isTimeOkay = true;
    }else{
      _isTimeOkay = false;
      _isEverythingOkayColor = Colors.red;
      errorText = "Incorrect Time";
    }

    if(_selectedDate.contains('202')){
      _isDateOkay = true;
    }else{
      if(_selectedDate == 'Tap to select date'){
        errorText = "Please select Date";
      }else{
        errorText = "Date not okay";
        _isDateOkay = false;
        _isEverythingOkayColor = Colors.red;
      }
    }

    if(myControllerText.text.isEmpty){
      errorText = "Fill out Textfield";
      _isTextOkay = false;
      _isEverythingOkayColor = Colors.red;
    }else{
      _isTextOkay = true;
    }

    if(_isTimeOkay && _isDateOkay && _isTextOkay){
      _isEverythingOkay = true;
      _isEverythingOkayColor = Colors.green;
      errorText = "Done";
    }

  }


  Future<void> saveToStorage() async {
    //get time of Input

    final directory = await getApplicationDocumentsDirectory();
    String path = directory.path + "/tasks/intern";
    await Directory(path).create(recursive: true);

    final timeSave = getText(); // Time start
    final time2Save = getText2(); // Time end
    final text = myControllerText.text;

    final directory1 = Directory(path);

    if(await directory1.exists()){
      int _countFilesinFolder = (await directory1.list().length)+1; //Folder Name

      String _fileName = "intern_" + _countFilesinFolder.toString() +  ".txt";

      final File file = File('$path/$_fileName');
      await file.writeAsString("Date of Task: " + _selectedDate + "\n" + "Task started: " + timeSave + "\n" + "Task ended: " + time2Save + "\n" + "Done Task: " + text + "\n");
    }












    /*
    final timeSave = getText(); // Time start
    final time2Save = getText2(); // Time end
    final _yearName = DateTime.now().year.toString(); //Year
    //get text
    final text = myControllerText.text;
    //create folder Name 'MMdd'
    final _monthName = (_selectedDate.split(" "))[0]; //Month Name
    final _dayName = (((_selectedDate.split(","))[0]).split(" "))[1];

    //get directory of Device
    final directory = await getApplicationDocumentsDirectory();
    // create path Year
    final _pathYearFolder= Directory(directory.path + "/Aufträge/Intern/" + "$_yearName");
    // create path Month
    final _pathMonthFolder= Directory(directory.path + "/Aufträge/Intern/" + "$_yearName" +"/"+_monthName);
    // create path Day
    final _pathDayFolder= Directory(directory.path + "/Aufträge/Intern/" + "$_yearName" +"/"+_monthName+"/"+_dayName);

    //checks if folder $Year exists
    if ((await _pathYearFolder.exists())){
      //checks if folder $Month exists
      if ((await _pathMonthFolder.exists())){
        //checks if folder $Day exists
        if ((await _pathDayFolder.exists())){
          // TODO: save file to storage
          int _countFilesinFolder = (await _pathDayFolder.list().length)+1; //Folder Name
          String _fileName = _countFilesinFolder.toString() + ".txt";
          await Directory(directory.path + "/Aufträge/Intern/" + "$_yearName" +"/"+_monthName+"/"+_dayName+"/"+_countFilesinFolder.toString()).create(recursive: true);
          final _pathFileSave = directory.path + "/Aufträge/Intern/" + "$_yearName" +"/"+_monthName+"/"+_dayName+"/"+_countFilesinFolder.toString();

          final File file = File('$_pathFileSave/$_fileName');
          await file.writeAsString("Date of Task: " + _selectedDate + "\n" + "Task started: " + timeSave + "\n" + "Task ended: " + time2Save + "\n" + "Done Task: " + text + "\n");
        }else{
          //create folder
          await _pathDayFolder.create(recursive: true);
        }
      }else{
        // if not exists creates Folder $Year
        await _pathMonthFolder.create(recursive: true);
      }
    }else{
      //create year folder
      await _pathYearFolder.create(recursive: true);
      if ((await _pathMonthFolder.exists())){
        //checks if folder $Day exists
        if ((await _pathDayFolder.exists())){
          // TODO: save file to storage
          int _countFilesinFolder = (await _pathDayFolder.list().length)+1; //Folder Name
          String _fileName = _countFilesinFolder.toString() + ".txt";
          await Directory(directory.path + "/Aufträge/Intern/" + "$_yearName" +"/"+_monthName+"/"+_dayName+"/"+_countFilesinFolder.toString()).create(recursive: true);
          final _pathFileSave = directory.path + "/Aufträge/Intern/" + "$_yearName" +"/"+_monthName+"/"+_dayName+"/"+_countFilesinFolder.toString();

          final File file = File('$_pathFileSave/$_fileName');
          await file.writeAsString("Date of Task: " + _selectedDate + "\n" + "Task started: " + timeSave + "\n" + "Task ended: " + time2Save + "\n" + "Done Task: " + text + "\n");
        }else{
          //create folder
          await _pathDayFolder.create(recursive: true);
          // TODO: save file to storage
          int _countFilesinFolder = (await _pathDayFolder.list().length)+1; //Folder Name
          String _fileName = _countFilesinFolder.toString() + ".txt";
          await Directory(directory.path + "/Aufträge/Intern/" + "$_yearName" +"/"+_monthName+"/"+_dayName+"/"+_countFilesinFolder.toString()).create(recursive: true);
          final _pathFileSave = directory.path + "/Aufträge/Intern/" + "$_yearName" +"/"+_monthName+"/"+_dayName+"/"+_countFilesinFolder.toString();

          final File file = File('$_pathFileSave/$_fileName');
          await file.writeAsString("Date of Task: " + _selectedDate + "\n" + "Task started: " + timeSave + "\n" + "Task ended: " + time2Save + "\n" + "Done Task: " + text + "\n");
        }
      }else{
        // if not exists creates Folder $Year
        await _pathMonthFolder.create(recursive: true);
        if ((await _pathDayFolder.exists())){
          // TODO: save file to storage
          int _countFilesinFolder = (await _pathDayFolder.list().length)+1; //Folder Name
          String _fileName = _countFilesinFolder.toString() + ".txt";
          await Directory(directory.path + "/Aufträge/Intern/" + "$_yearName" +"/"+_monthName+"/"+_dayName+"/"+_countFilesinFolder.toString()).create(recursive: true);
          final _pathFileSave = directory.path + "/Aufträge/Intern/" + "$_yearName" +"/"+_monthName+"/"+_dayName+"/"+_countFilesinFolder.toString();

          final File file = File('$_pathFileSave/$_fileName');
          await file.writeAsString("Date of Task: " + _selectedDate + "\n" + "Task started: " + timeSave + "\n" + "Task ended: " + time2Save + "\n" + "Done Task: " + text + "\n");
        }else{
          //create folder
          await _pathDayFolder.create(recursive: true);
          // TODO: save file to storage
          int _countFilesinFolder = (await _pathDayFolder.list().length)+1; //Folder Name
          String _fileName = _countFilesinFolder.toString() + ".txt";
          await Directory(directory.path + "/Aufträge/Intern/" + "$_yearName" +"/"+_monthName+"/"+_dayName+"/"+_countFilesinFolder.toString()).create(recursive: true);
          final _pathFileSave = directory.path + "/Aufträge/Intern/" + "$_yearName" +"/"+_monthName+"/"+_dayName+"/"+_countFilesinFolder.toString();

          final File file = File('$_pathFileSave/$_fileName');
          await file.writeAsString("Date of Task: " + _selectedDate + "\n" + "Task started: " + timeSave + "\n" + "Task ended: " + time2Save + "\n" + "Done Task: " + text + "\n");
        }
      }
    }
    /
   */
  }

  @override
  void initState() {
    String today = DateFormat('yMMMMd').format(new DateTime.now());
    _selectedDate = today;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.backgroundColor,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(widget.title,
          style: theme.textTheme.headline6,
        ),
        elevation: 0,
      ),
      body: Center(
          child: FittedBox(
            fit: BoxFit.fitHeight,
            alignment: Alignment.center,
            child: Padding(
              padding: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.05),
              child: Container(
                width: MediaQuery.of(context).size.width*1,
                height: MediaQuery.of(context).size.height*1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      width: MediaQuery.of(context).size.width*1,
                      height: MediaQuery.of(context).size.height*0.04,
                      child: Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.005,),
                            child: Text(
                              "Durchgeführte Tätigkeit",
                              style: theme.textTheme.headline3,
                            ),
                          )
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.005),
                      child: Container(
                        width: MediaQuery.of(context).size.width*1,
                        height: MediaQuery.of(context).size.height*0.3,
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
                    Container(
                      width: MediaQuery.of(context).size.width*1,
                      height: MediaQuery.of(context).size.height*0.04,
                      child: Align(
                          alignment: Alignment.topLeft,
                          child: Padding(
                            padding: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.005,),
                            child: Text(
                              "Datum und Uhrzeit",
                              style: theme.textTheme.headline3,
                            ),
                          )
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width*1,
                      height: MediaQuery.of(context).size.height*0.07,
                      decoration: BoxDecoration(
                          border: Border(
                            top: BorderSide(width: 1.0, color: theme.shadowColor),
                            left: BorderSide(width: 1.0, color: theme.shadowColor),
                            right: BorderSide(width: 1.0, color: theme.shadowColor),
                            bottom: BorderSide(width: 1.0, color: theme.shadowColor),
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(10))
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(1.0),
                        child: FittedBox(
                          alignment: Alignment.center,
                          fit: BoxFit.fitWidth,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.05,right:MediaQuery.of(context).size.width*0.1,),
                                child: InkWell(
                                  child: Text(
                                    _selectedDate,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: MediaQuery.of(context).size.height*0.02,
                                      fontWeight: FontWeight.bold
                                    ),
                                  ),
                                  onTap: () {
                                    _selectDate(context);
                                  },
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.1,right:MediaQuery.of(context).size.width*0.01,),
                                child: Align(
                                  alignment: Alignment.centerRight,
                                  child: Transform.scale(
                                    scale: 0.7,
                                    child: IconButton(
                                        onPressed: (){
                                          _selectDate(context);
                                        },
                                        tooltip: 'Tap to open date picker',
                                        icon: Icon(Icons.calendar_today)),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width*1,
                      height: MediaQuery.of(context).size.height*0.1,
                      child: Row(
                        children: <Widget>[
                          Container(
                              width: MediaQuery.of(context).size.width*0.45,
                              height: MediaQuery.of(context).size.height*0.06,
                              decoration: BoxDecoration(
                                  border: Border(
                                    top: BorderSide(width: 1.0, color: theme.shadowColor),
                                    left: BorderSide(width: 1.0, color: theme.shadowColor),
                                    right: BorderSide(width: 1.0, color: theme.shadowColor),
                                    bottom: BorderSide(width: 1.0, color: theme.shadowColor),
                                  ),
                                  borderRadius: BorderRadius.all(Radius.circular(10))
                              ),
                              child: Padding(
                                padding: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.005),
                                child: Align(
                                  alignment: Alignment.center,
                                  child: InkWell(
                                    child: Text(
                                      getText(),
                                      textAlign: TextAlign.center,
                                      style: theme.textTheme.headline5,
                                    ),
                                    onTap: (){
                                      pickTime(context);
                                    },
                                  ),
                                ),
                              )
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width*0.1,
                          ),
                          Container(
                              width: MediaQuery.of(context).size.width*0.45,
                              height: MediaQuery.of(context).size.height*0.06,
                              decoration: BoxDecoration(
                                  border: Border(
                                    top: BorderSide(width: 1.0, color: theme.shadowColor),
                                    left: BorderSide(width: 1.0, color: theme.shadowColor),
                                    right: BorderSide(width: 1.0, color: theme.shadowColor),
                                    bottom: BorderSide(width: 1.0, color: theme.shadowColor),
                                  ),
                                  borderRadius: BorderRadius.all(Radius.circular(10))
                              ),
                              child: Padding(
                                padding: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.005),
                                child: Align(
                                  alignment: Alignment.center,
                                  child: InkWell(
                                    child: Text(
                                      getText2(),
                                      textAlign: TextAlign.center,
                                      style: theme.textTheme.headline5,
                                    ),
                                    onTap: (){
                                      pickTime2(context);
                                    },
                                  ),
                                ),
                              )
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.2),
                      child: Container(
                          height: MediaQuery.of(context).size.height*0.03,
                          width: MediaQuery.of(context).size.width*0.85,
                          child: (_isEverythingOkay)
                              ? Align(
                            alignment: Alignment.center,
                            child: Text(
                              errorText,
                              style: TextStyle(
                                color: _isEverythingOkayColor,
                                fontSize: 17,
                              ),
                            ),
                          )
                              : Align(
                            alignment: Alignment.center,
                            child: Text(
                              errorText,
                              style: TextStyle(
                                color: _isEverythingOkayColor,
                                fontSize: 17,
                              ),
                            ),
                          )
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.02),
                      child: Container(
                          height: MediaQuery.of(context).size.height*0.09,
                          width: MediaQuery.of(context).size.width*1,
                          child: Padding(
                            padding: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.005),
                            child: FloatingActionButton(
                              elevation: 0,
                              heroTag: "Save",
                              backgroundColor: theme.cardColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                              ),
                              onPressed: () {
                                setState(() {
                                  checkEverything();
                                  if(errorText == "Done"){
                                    //Navigator.pop(context);
                                    saveToStorage();
                                  }
                                });
                                Navigator.pop(context);
                              },
                              child: Text(
                                'Speichern',
                                style: theme.textTheme.bodyText1,
                              ),
                            ),
                          )
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
