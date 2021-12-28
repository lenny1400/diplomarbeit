import 'dart:io';

import 'package:csv/csv.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:simple_nav_bar/themes.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:simple_nav_bar/user_startup/user_customer.dart';
import 'package:simple_nav_bar/user_startup/user_task.dart';

import 'existing_customer_page_2.dart';



class ExistingCustomerPage extends StatefulWidget {
  const ExistingCustomerPage({Key? key, required this.title, required this.pop,}) : super(key: key);

  final String title;
  final int pop;

  @override
  _ExistingCustomerPageState createState() => _ExistingCustomerPageState(pop);
}

class _ExistingCustomerPageState extends State<ExistingCustomerPage> {

  int pop;
  _ExistingCustomerPageState(this.pop);

  bool isCheckedYes = false;
  bool isCheckedNo = false;

  bool isEnabledYes = false;
  bool isEnabledNo = false;

  final myControllerKMStandA = TextEditingController();
  final myControllerKMStandB = TextEditingController();

  bool _validateKMStandA = false;
  bool _validateKMStandB = false;
  bool _validateUhrzeit = false;
  bool _isEverythingOkay = false;

  String errorText = "";
  Color _isEverythingOkayColor = Colors.red;

  late TimeOfDay time = TimeOfDay.now();
  late TimeOfDay time2 = TimeOfDay.fromDateTime(DateTime.now().add(Duration(minutes: 1)));

  late double newTime;
  late double newTime2;

  late int var1;
  late int var2;

  String dropdownValue = "Keine Kunden";
  List<String> list = [];
  bool Anfahrt = false;
  late List<List<dynamic>> list1;
  List<String> numberlist = [];

  Future<void> csvReader() async{

    print("Im Here");

    String user = FirebaseAuth.instance.currentUser!.uid;

    Directory? directory = await getApplicationDocumentsDirectory();

    String path = directory.path;

    await Directory('$path/User/$user/Customer/').create(recursive: true);

    String csv1 = await File('$path/User/$user/Customer/Customer.csv').readAsString();

    list1 = const CsvToListConverter().convert(csv1);

    String csvString = list1.toString();

    for(int i = 0; i<list1.length; i++){
      List<String> elems = list1[i].toString().split(";");
      if(i != 0){
        list.add(elems[0].split("[")[1]);
        numberlist.add(elems[1]);
      }
    }
    if(list.isEmpty){
      list.add("Keine Kunden");
    }
    else{
      dropdownValue = list.first;
    }
    print("Still Here");
    setState(() {
    });
  }


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
    // if (time == null) {
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
    if(isCheckedYes){
      if(myControllerKMStandA.text.isEmpty == false && myControllerKMStandB.text.isEmpty == false){
        if(_validateUhrzeit){
          if(_validateKMStandA && _validateKMStandB){
            errorText = "Passt";
            _isEverythingOkayColor = Colors.green;
            _isEverythingOkay = true;
          }
        }
      }
    }
    if(isCheckedNo){
      if(_validateUhrzeit){
        if(!_validateKMStandA && !_validateKMStandB){
          errorText = "Passt";
          _isEverythingOkayColor = Colors.green;
          _isEverythingOkay = true;
        }
      }
    }
  }

  void checkData(){
    newTime = time.hour.toDouble() + (time.minute.toDouble()/60);
    newTime2 = time2.hour.toDouble() + (time2.minute.toDouble()/60);
    _isEverythingOkayColor = Colors.red;

    if (newTime == newTime2){
      errorText = "Time can't be the same";
      _validateUhrzeit = false;
    }else if(newTime > newTime2){
      errorText = "FirsTime can't be bigger";
      _validateUhrzeit = false;
    }else{
      _validateUhrzeit = true;
    }

    if(myControllerKMStandA.text.isEmpty == false && myControllerKMStandB.text.isEmpty == false){
      var1 = int.parse(myControllerKMStandA.text);
      var2 = int.parse(myControllerKMStandB.text);
      if(var1>var2){
        errorText = "Anfang can't be bigger than Ende";
        _validateKMStandA = false;
        _validateKMStandB = false;
      }else if(var1 == var2){
        errorText = "Anfang and Ende can't be the same";
      }else if(var1<var2){
        _validateKMStandA = true;
        _validateKMStandB = true;
      }
    }

    if(myControllerKMStandA.text.isEmpty == false && myControllerKMStandB.text.isEmpty == true){
      errorText = "Enter value in Ende";
      _validateKMStandB = false;
    }

    if(myControllerKMStandA.text.isEmpty == true && myControllerKMStandB.text.isEmpty == false){
      errorText = "Enter value in Anfang";
      _validateKMStandA = false;
    }

    if(myControllerKMStandA.text.isEmpty == true && myControllerKMStandB.text.isEmpty == true && isEnabledYes == true && isEnabledNo == true){
      errorText = "Please fill out Kilometerstand";
    }

    if(!isCheckedYes){
      if(!isCheckedNo){
        errorText = "Please select Anfahrt";
      }
    }

    checkEverything();

  }

  @override
  void initState() {
    csvReader();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    Color getColor(Set<MaterialState> states) {
      const Set<MaterialState> interactiveStates = <MaterialState>{
        MaterialState.pressed,
        MaterialState.hovered,
        MaterialState.focused,
      };
      if (states.any(interactiveStates.contains)) {
        return Colors.white;
      }
      return Colors.black;
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: theme.backgroundColor,
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
            padding: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.01),
            child: Container(
              width: MediaQuery.of(context).size.width*1,
              height: MediaQuery.of(context).size.height*1,
              child: ListView(
                shrinkWrap: true,
                padding: EdgeInsets.all(15.0),
                children: <Widget>[
                  SizedBox(
                    height: MediaQuery.of(context).size.height*0.07,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width*0.85,
                    height: MediaQuery.of(context).size.height*0.05,
                    child: Padding(
                      padding: EdgeInsets.only(left: 60),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Kunde",
                          style: theme.textTheme.headline6,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width*0.85,
                    height: MediaQuery.of(context).size.height*0.01,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width*0.85,
                    height: MediaQuery.of(context).size.height*0.05,
                    child: Padding(
                      padding: EdgeInsets.only(left: 60),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Container(
                            child: DropdownButton<String>(
                              value: dropdownValue,
                              icon: const Icon(Icons.arrow_downward),
                              iconSize: 24,
                              elevation: 16,
                              style: const TextStyle(color: Colors.black, fontSize: 18),
                              underline: Container(
                                height: 2,
                                color: theme.cardColor,
                              ),
                              onChanged: (String? newValue) {
                                setState(() {
                                  dropdownValue = newValue!;
                                });
                              },
                              items:list
                                  .map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value,style: TextStyle(fontSize: 18)),
                                );
                              }).toList(),
                            ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width*0.85,
                    height: MediaQuery.of(context).size.height*0.01,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width*0.85,
                    height: MediaQuery.of(context).size.height*0.05,
                    child: Padding(
                      padding: EdgeInsets.only(left: 60),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Anfahrt",
                          style: theme.textTheme.headline6,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width*0.85,
                    height: MediaQuery.of(context).size.height*0.01,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width*0.85,
                    height: MediaQuery.of(context).size.height*0.05,
                    child: Padding(
                      padding: EdgeInsets.only(left: 48),
                      child: Align(
                          alignment: Alignment.centerLeft,
                          child: Row(
                            children: <Widget>[
                              Transform.scale(
                                scale: 1.3,
                                child: Checkbox(
                                  activeColor: theme.shadowColor,
                                  checkColor: theme.primaryColor,
                                  fillColor: MaterialStateProperty.all(theme.shadowColor),
                                  value: isCheckedYes,
                                  onChanged: (newValue){
                                    setState(() {
                                      if(!isCheckedYes) {
                                        isCheckedYes = newValue!;
                                        isCheckedNo = !isCheckedYes;
                                        isEnabledYes = true;
                                        isEnabledNo = true;
                                        Anfahrt = true;
                                      }
                                    });
                                  },
                                ),
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width*0.01,
                              ),
                              Text(
                                "Ja",
                                style: theme.textTheme.headline5,
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width*0.05,
                              ),
                              Transform.scale(
                                scale: 1.3,
                                child: Checkbox(
                                  activeColor: theme.shadowColor,
                                  checkColor: theme.primaryColor,
                                  fillColor: MaterialStateProperty.all(theme.shadowColor),
                                  value: isCheckedNo,
                                  onChanged: (newValue){
                                    setState(() {
                                      if(!isCheckedNo){
                                        isCheckedNo = newValue!;
                                        isCheckedYes = !isCheckedNo;
                                        isEnabledYes = false;
                                        isEnabledNo = false;
                                        Anfahrt = false;
                                        myControllerKMStandA.clear();
                                        myControllerKMStandB.clear();
                                      }
                                    });
                                  },
                                ),
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width*0.01,
                              ),
                              Text(
                                "Nein",
                                style: theme.textTheme.headline5,
                              ),
                            ],
                          )
                      ),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width*0.85,
                    height: MediaQuery.of(context).size.height*0.015,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width*0.85,
                    height: MediaQuery.of(context).size.height*0.05,
                    child: Padding(
                      padding: EdgeInsets.only(left: 60),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Kilometerstand",
                          style: theme.textTheme.headline6,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width*0.85,
                    height: MediaQuery.of(context).size.height*0.015,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width*0.85,
                    height: MediaQuery.of(context).size.height*0.06,
                    child: Padding(
                      padding: EdgeInsets.only(left: 60),
                      child: Align(
                          alignment: Alignment.centerLeft,
                          child: Row(
                            children: <Widget>[
                              Container(
                                width: MediaQuery.of(context).size.width*0.3,
                                child: TextField(
                                  enabled: isEnabledYes,
                                  inputFormatters: <TextInputFormatter>[
                                    FilteringTextInputFormatter.digitsOnly
                                  ],
                                  controller: myControllerKMStandA,
                                  textAlign: TextAlign.left,
                                  maxLines: 1,
                                  style: TextStyle(
                                    color: theme.shadowColor,
                                  ),
                                  decoration: InputDecoration(
                                      contentPadding: EdgeInsets.only(top: 15,left: 20,bottom: 10),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                        borderSide: BorderSide(color: theme.shadowColor),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                        borderSide: BorderSide(color: theme.shadowColor),
                                      ),
                                      labelText: "Anfang",
                                      labelStyle: TextStyle(
                                          color: theme.shadowColor,
                                      ),
                                      hintText: "Kilometer",
                                      hintStyle: TextStyle(
                                        color: theme.shadowColor,
                                      )
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width*0.05,
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width*0.3,
                                child: TextField(
                                  enabled: isEnabledNo,
                                  inputFormatters: <TextInputFormatter>[
                                    FilteringTextInputFormatter.digitsOnly
                                  ],
                                  controller: myControllerKMStandB,
                                  textAlign: TextAlign.left,
                                  maxLines: 1,
                                  style: TextStyle(
                                    color: theme.shadowColor,
                                  ),
                                  decoration: InputDecoration(
                                      contentPadding: EdgeInsets.only(top: 15,left: 20,bottom: 10),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                        borderSide: BorderSide(color: theme.shadowColor),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                        borderSide: BorderSide(color: theme.shadowColor),
                                      ),
                                      labelText: "Ende",
                                      labelStyle: TextStyle(
                                          color: theme.shadowColor
                                      ),
                                      hintText: "Kilometer",
                                      hintStyle: TextStyle(
                                        color: theme.shadowColor,
                                      )
                                  ),
                                ),
                              ),
                            ],
                          )
                      ),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width*0.85,
                    height: MediaQuery.of(context).size.height*0.015,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width*0.85,
                    height: MediaQuery.of(context).size.height*0.05,
                    child: Padding(
                      padding: EdgeInsets.only(left: 60),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Uhrzeit",
                          style: theme.textTheme.headline6,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width*0.85,
                    height: MediaQuery.of(context).size.height*0.015,
                  ),
                  Container(
                      child: Padding(
                        padding: EdgeInsets.only(left: 60),
                        child: Column(
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Container(
                                    width: MediaQuery.of(context).size.width*0.3,
                                    height: MediaQuery.of(context).size.height*0.05,
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
                                      padding: EdgeInsets.only(left: 00),
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
                                  width: MediaQuery.of(context).size.width*0.2,
                                ),
                                TextButton(
                                    onPressed: (){
                                      setState(() {
                                        time = TimeOfDay.now();
                                      });
                                    },
                                    child: Text(
                                      "Jetzt",
                                      style: TextStyle(
                                        fontSize: 23,
                                        decoration: TextDecoration.underline,
                                        color: theme.shadowColor,
                                      ),
                                    )
                                )
                              ],
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height*0.02,
                            ),
                            Row(
                              children: <Widget>[
                                Container(
                                    width: MediaQuery.of(context).size.width*0.3,
                                    height: MediaQuery.of(context).size.height*0.05,
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
                                      padding: EdgeInsets.only(left: 00),
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
                                SizedBox(
                                  width: MediaQuery.of(context).size.width*0.2,
                                ),
                                TextButton(
                                    onPressed: (){
                                      setState(() {
                                        time2 = TimeOfDay.now();
                                      });
                                    },
                                    child: Text(
                                      "Jetzt",
                                      style: TextStyle(
                                        fontSize: 23,
                                        decoration: TextDecoration.underline,
                                        color: theme.shadowColor,
                                      ),
                                    )
                                )
                              ],
                            ),
                          ],
                        ),
                      )
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width*0.85,
                    height: MediaQuery.of(context).size.height*0.1,
                  ),
                  Container(
                    child: Align(
                        alignment: Alignment.center,
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
                  SizedBox(
                    width: MediaQuery.of(context).size.width*0.85,
                    height: MediaQuery.of(context).size.height*0.01,
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Container(
                        height: MediaQuery.of(context).size.height*0.07,
                        width: MediaQuery.of(context).size.width*0.8,
                        child: Padding(
                          padding: EdgeInsets.all(0),
                          child: FloatingActionButton(
                            elevation: 0,
                            heroTag: "btnExisitngCustomer",
                            backgroundColor: theme.cardColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(Radius.circular(10.0)),
                            ),
                            onPressed: ()  async {

                              String user = FirebaseAuth.instance.currentUser!.uid;

                              final directory = await getApplicationDocumentsDirectory();

                              String path =directory.path;

                              String count = await File('$path/User/$user/tasks/extern/count.txt').readAsString();

                              User_customer customer = User_customer("company", "0000","Anrede", "name1", "street", "country", 0000, "province", "phone", "fax", "email");
                              User_task task = User_task("AUF0000",false, customer, "time", "text", "Material");

                              int hours = time2.hour.toInt() - time.hour.toInt();

                              int minutes =  time2.minute.toInt() - time.minute.toInt();

                              if(count.length == 1){
                                task.name = "AUF00000" + count.toString();
                              }
                              else if(count.length == 2){
                                task.name = "AUF0000" + count.toString();
                              }
                              else if(count.length == 3){
                                task.name = "AUF000" + count.toString();
                              }
                              else if(count.length == 4){
                                task.name = "AUF00" + count.toString();
                              }
                              else if(count.length == 5){
                                task.name = "AUF0" + count.toString();
                              }
                              else{
                                task.name = "AUF" + count.toString();
                              }

                              task.customer.company = dropdownValue;

                              for(int i =0;i<list.length;i++){
                                if(task.customer.company == list[i]){
                                  task.customer.number = numberlist[i];
                                }
                              }
                              task.Anfahrt = Anfahrt;

                              if(Anfahrt){
                               String anfang = myControllerKMStandA.text.toString();
                               String ende = myControllerKMStandB.text.toString();

                               int a = int.parse(anfang);
                               int e = int.parse(ende);
                               task.km= e-a;
                              }

                              task.time = hours.toString() + " Stunden und " + minutes.toString() + " Minuten!";

                              setState(()  {
                                getText();
                                getText2();
                                checkData();
                                if(_isEverythingOkay){
                                  pop = pop + 1;
                                  Navigator.push(context, MaterialPageRoute(builder: (_) => CreateTask(title:'Exisiting Customer',pop: pop,task: task)));
                                }
                              });
                            },
                            child: Text(
                              "Next",
                              style: theme.textTheme.bodyText1,
                            ),
                          ),
                        )
                    ),
                  )
                ],
              ),
            ),
          ),
        )
      ),
    );
  }
}
