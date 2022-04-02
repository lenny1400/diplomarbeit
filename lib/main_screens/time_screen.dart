import 'dart:async';
import 'dart:io';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:simple_nav_bar/custom_widgets/models.dart';
import '../themes.dart';
import '../responsive_screens/time/my_flutter_app_icons.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:simple_nav_bar/custom_widgets/preferences_service.dart';

void main() {
  // add these lines
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  runApp(Time());
}

class Time extends StatefulWidget {
  const Time({Key? key}) : super(key: key);

  @override
  _TimeState createState() => _TimeState();
}

class _TimeState extends State<Time> {

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
    initializeDateFormatting();
    return MaterialApp(
      home: TimePage(title: 'ti_appbar1'.tr),
      title: 'Flutter Theme Demo',
      debugShowCheckedModeBanner: false,
      theme: CustomTheme.lightTheme,
      darkTheme: CustomTheme.darkTheme,
      themeMode: currentTheme.currentTheme,
    );
  }

  updateLocale(Locale locale, BuildContext context){
    Navigator.of(context).pop();
    Get.updateLocale(locale);
  }
}

class TimePage extends StatefulWidget {
  TimePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _TimePageState createState() => _TimePageState();
}

class _TimePageState extends State<TimePage> {
  //service call
  final _preferencesService = PreferenceService();


  //variables for View
  var hour;
  var min;
  var sec;
  final String defaultLocale = Platform.localeName; // Phone local

  static String _getLocalizedWeekDay(String local, DateTime date) {
    final formatter = DateFormat(DateFormat.WEEKDAY, local);
    return formatter.format(date);
  }

  //var dayofweek; //= DateFormat('EEEE', ).format(DateTime.now());
  var dayofweek = DateFormat.EEEE(Get.locale.toString()).format(DateTime.now());
  var dayofmonth = DateTime.now().day;
  var month = DateFormat.MMMM(Get.locale.toString()).format(DateTime.now());

  //Buttons
  bool btnArrive = false;
  bool btnLeave = true;
  //variables for Currently Working
  int seconds = 0;
  int minutes = 0;
  int hours = 0;
  String currentlyWorking = "";
  //formatting for currently working
  int timeSec = 0;
  int timeMin = 0;
  int timeHour = 0;
  //after time edit
  var data;
  //used for Time Edit
  String newCurrentlyWorking ="";
  //Time Now
  int setTimestamp = 0;
  int diffTimestamp = 0;
  var timestampIn;
  var timestampOut;
  var checkTimestamp;
  var transfer;


  //Saves the objects for the Shared Preferences
  void _saveTime(){
    final newTimeStuff = TimeStuff(
        timestampIn: timestampIn
    );
    _preferencesService.saveTime(newTimeStuff);
  }

  //Reloads & Uploads the state of the switch
  void _populateFields() async{
    final timeStuff = await _preferencesService.getTimeStuff();
    setState(() {
      timestampIn = timeStuff.timestampIn;
    });
    print('Populate Fields - TimestampIn $timestampIn');
    if(timestampIn != ""){
      currentWorkTime(timestampIn);
    }
  }

  void currentWorkTime(String editTimestamp){
    var nowTimestamp = new DateTime.now();
    var newTimestamp = DateTime.parse(DateFormat(editTimestamp).format(nowTimestamp));

    currentlyWorking = nowTimestamp.difference(newTimestamp).toString().split(".").first.padLeft(8,"0");
    print('Currentworktime $currentlyWorking');

    timeHour = int.parse(currentlyWorking.split(":")[0]);
    timeMin = int.parse(currentlyWorking.split(":")[1]);
    timeSec = int.parse(currentlyWorking.split(":")[2]);

    if(timestampIn != null){
      if (this.mounted) {
        setState(() {
          btnArrive = false;
        });
      }
    }

    if (this.mounted) {
      setState(() {
        _start = timeSec;
        timeWorkUpdate();
        if(!btnArrive && btnLeave){
          btnArrive = true;
          btnLeave = false;
          startTimer(btnArrive);
        }
      });
    }
  }

  void time(){
    hour = DateTime.now().hour;
    min = DateTime.now().minute;
    sec = DateTime.now().second;
    dayofweek = _getLocalizedWeekDay(Get.locale.toString(), DateTime.now());

    //if min smaller than 10
    if (min < 10){
      min = "0" + min.toString();
    }
    currentlyWorking = "00:00:00";
  }

  Timer? _timer;
  int _start = 0;

  void timeEdit(String saveTimestamp ){
    var nowTimestamp = new DateTime.now();
    var newTimestamp = DateTime.parse(DateFormat('yyyy-MM-dd $saveTimestamp').format(nowTimestamp));

    setState(() {
      timestampIn = newTimestamp.toString().split(".")[0];
      _saveTime();
    });

    data = nowTimestamp.difference(newTimestamp).toString().split(".")[0];

    timeHour = int.parse(data.split(":")[0]);
    timeMin = int.parse(data.split(":")[1]);
    timeSec = int.parse(data.split(":")[2]);

    _start = timeSec;
  }

  void leaveBtnTime(){
    var timestampLeave = new DateTime.now(); //Timestamp when the worker has finished the work
    var timestampArrive = DateTime.parse(DateFormat(timestampIn).format(timestampLeave)); //Timestamp when the worker started the work
    var requiredTime;

    //Calculation of the required time
    requiredTime = timestampLeave.difference(timestampArrive).toString().split(".").first.padLeft(8,"0");
    print('Worktime $requiredTime');

    setState(() {
      timestampOut = timestampLeave.toString().split(".")[0];
      print('TimestampOut $timestampOut');
      timestampIn = "";
      //print(timestampIn);
      _saveTime();
    });
  }

  void timeWorkUpdate() {
    String sec = "";
    String min = "";
    String hour = "";
    timeSec = _start;

    if (timeSec > 59) {
      timeSec = 0;
      timeMin++;
      if (timeMin > 59) {
        timeMin = 0;
        timeHour++;
      }
    }

    if (timeSec < 10) {
      sec = "0" + timeSec.toString();
    } else {
      sec = timeSec.toString();
    }
    if (timeMin < 10) {
      min = "0" + timeMin.toString();
    } else {
      min = timeMin.toString();
    }
    if (timeHour < 10) {
      hour = "0" + timeHour.toString();
    } else {
      hour = timeHour.toString();
    }
    currentlyWorking = hour + ":" + min + ":" + sec;
  }

  void startTimer(bool _change) {
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec,
          (Timer timer) {
          setState(() {
            _start++;
            if(_start > 60){
              _start = 1;
            }
            timeWorkUpdate();
            print(_start);
          });
      },
    );
  }

  void readTimestamp(int setTimestamp) {
    var now = new DateTime.now();
    checkTimestamp = new DateTime.fromMicrosecondsSinceEpoch(setTimestamp * 1000);
    print('ReadTimestamp $setTimestamp');
    print('checkTimestamp $checkTimestamp');
    var diff = checkTimestamp.difference(now);

    print('timestamp $checkTimestamp');
    if (diff.inSeconds <= 0 || diff.inSeconds > 0 && diff.inMinutes == 0 || diff.inMinutes > 0 && diff.inHours == 0 || diff.inHours > 0 && diff.inDays == 0) {
      setState(() {
        transfer = checkTimestamp.toString().split(".")[0];
        timestampIn = transfer;
        print('timestamp after split $timestampIn');
        _saveTime();
      });
    }
  }

  @override
  void initState() {
    super.initState();
    initializeDateFormatting(defaultLocale);
    _populateFields();
    time();
  }

  @override
  void dispose() {
    var t = _timer;
    if(t != null) {
      t.cancel();
    }

    //_timer?.cancel();
    super.dispose();
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
          alignment: Alignment.center,
          fit: BoxFit.fitHeight,
          child: Container(
            height: MediaQuery.of(context).size.height*1,
            width: MediaQuery.of(context).size.width*1,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Align(
                    alignment: Alignment.center,
                    child: Padding(
                      padding: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.02, top: MediaQuery.of(context).size.height*0.08),
                      child: Text(
                          dayofweek.toString() + ", " + dayofmonth.toString() + ". " + month.toString(),
                        style: TextStyle(
                          color: theme.shadowColor,
                          fontFamily: 'Moon',
                          fontSize: MediaQuery.of(context).size.height*0.027,
                        ),
                      ),
                    )
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height*0.02,
                ),
                Align(
                    alignment: Alignment.center,
                    child: Padding(
                      padding: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.02, top: MediaQuery.of(context).size.height*0.02,),
                      child: Text(
                        hour.toString() + ":" + min.toString(),
                        style: TextStyle(
                          color: theme.shadowColor,
                          fontFamily: 'Moon',
                          fontSize: MediaQuery.of(context).size.width*0.26,
                        ),
                      ),
                    )
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height*0.125,
                ),
                Container(
                  width: MediaQuery.of(context).size.width*1,
                  height: MediaQuery.of(context).size.height*0.225,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Expanded(
                              flex: 3,
                              child: Align(
                                alignment: Alignment.center,
                                child: IconButton(
                                    alignment: Alignment.center,
                                    iconSize: MediaQuery.of(context).size.width*0.25,
                                    padding: EdgeInsets.all(0),
                                    onPressed: (){
                                      if(!btnArrive && btnLeave){
                                        btnArrive = true;
                                        btnLeave = false;
                                        startTimer(btnArrive);
                                      }
                                      setTimestamp = new DateTime.now().millisecondsSinceEpoch;
                                      readTimestamp(setTimestamp);
                                    },
                                    icon: Icon(
                                      MyFlutterApp.box_arrow_in_down,
                                      color: theme.shadowColor,
                                    )
                                ),
                              ),
                            ),
                            Expanded(
                              child: SizedBox(),
                              flex: 1,
                            ),
                            Expanded(
                              flex: 1,
                              child: Align(
                                alignment: Alignment.center,
                                child: Text(
                                  "ti_arrive".tr,
                                  style: TextStyle(
                                    color: theme.shadowColor,
                                    fontFamily: 'Moon',
                                    fontSize: MediaQuery.of(context).size.height*0.025,
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                        flex: 1,
                      ),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Expanded(
                              child: SizedBox(),
                              flex: 1,
                            ),
                            Expanded(
                              flex: 3,
                              child: Align(
                                alignment: Alignment.center,
                                child: IconButton(
                                    alignment: Alignment.center,
                                    iconSize: MediaQuery.of(context).size.width*0.25,
                                    padding: EdgeInsets.all(0),
                                    onPressed: (){
                                      if(btnArrive && !btnLeave){
                                        btnArrive = false;
                                        btnLeave = true;
                                        _timer?.cancel();
                                      }
                                      leaveBtnTime();
                                      print('Timestamp abschicken!');
                                    },
                                    icon: Icon(
                                      MyFlutterApp.box_arrow_in_up,
                                      color: theme.shadowColor,
                                    )
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Align(
                                alignment: Alignment.center,
                                child: Text(
                                  "ti_leave".tr,
                                  style: TextStyle(
                                    color: theme.shadowColor,
                                    fontFamily: 'Moon',
                                    fontSize: MediaQuery.of(context).size.height*0.025,
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                        flex: 1,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width*1,
                  height: MediaQuery.of(context).size.height*0.125,
                ),
                Center(
                  child: Column(
                    children: <Widget>[
                      Text(
                        'ti_title1'.tr,
                        style: TextStyle(
                          color: theme.shadowColor,
                          fontSize: MediaQuery.of(context).size.height*0.03,
                          fontFamily: 'Moon',
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height*0.02,
                      ),
                      Text(
                        currentlyWorking,
                        style: TextStyle(
                          color: theme.shadowColor,
                          fontWeight: FontWeight.bold,
                          fontSize: MediaQuery.of(context).size.height*0.02,
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height*0.03,
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height*0.05,
                        width: MediaQuery.of(context).size.width*0.21,
                        child: FloatingActionButton(
                          elevation: 0,
                          onPressed: () async {
                            transfer = timestampIn + "|" + currentlyWorking;
                            data = await Navigator.push(context,MaterialPageRoute(builder: (context) => EditTime(time: transfer,)),
                            );
                            if(data != null){
                              timeEdit(data);
                            }
                          },
                          child: Text("ti_buttonText1".tr,style: TextStyle(fontSize: MediaQuery.of(context).size.height*0.02),),
                          backgroundColor: theme.cardColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(15.0)),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

class EditTime extends StatefulWidget {
  const EditTime({Key? key,required this.time}) : super(key: key);

  final String time;

  @override
  _EditTimeState createState() => _EditTimeState();
}

class _EditTimeState extends State<EditTime> {

  TextEditingController mymin = TextEditingController();
  TextEditingController mysec = TextEditingController();
  TextEditingController myhour = TextEditingController();
  TextEditingController currentlyWorkingHour = TextEditingController();
  TextEditingController currentlyWorkingMin = TextEditingController();
  TextEditingController currentlyWorkingSec = TextEditingController();

  @override
  void initState() {
    super.initState();

    myhour.text = widget.time.split(":")[0].split(" ")[1];
    mymin.text = widget.time.split(":")[1];
    mysec.text = widget.time.split(":")[2].split("|")[0];

    currentlyWorkingHour.text = widget.time.split(":")[2].split("|")[1];
    currentlyWorkingMin.text = widget.time.split(":")[3];
    currentlyWorkingSec.text = widget.time.split(":")[4];

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
    final theme = Theme.of(context);

    String newCurrentlyWorking;

    return Scaffold(
      backgroundColor: theme.backgroundColor,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text("ti_appbar2".tr,
          style: theme.textTheme.caption,
        ),
        elevation: 0,
      ),
      body: Center(
        child: FittedBox(
          fit: BoxFit.fitHeight,
          child: Container(
            height: MediaQuery.of(context).size.height*1,
            width: MediaQuery.of(context).size.width*1,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.05),
                  child: Column(
                    children: <Widget>[
                      Align(
                        alignment: Alignment.center,
                        child: Text(
                          "ti_initialTime".tr,
                          style: TextStyle(
                              fontSize: MediaQuery.of(context).size.height*0.06
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(bottom: MediaQuery.of(context).size.height*0.10),
                        child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            widget.time.split("|")[1],
                            style: TextStyle(
                              fontSize: MediaQuery.of(context).size.height*0.06
                            ),
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Column(
                            children: <Widget>[
                              Align(
                                alignment: Alignment.center,
                                child: Text(
                                    "ti_hours".tr,
                                  style: TextStyle(
                                    fontSize: MediaQuery.of(context).size.height*0.05
                                  ),
                                ),
                              ),
                              Align(
                                alignment: Alignment.center,
                                child: Container(
                                  width: MediaQuery.of(context).size.width*0.2,
                                  height: MediaQuery.of(context).size.height*0.1,
                                  child: TextFormField(
                                    keyboardType: TextInputType.datetime,
                                    inputFormatters:[
                                      LengthLimitingTextInputFormatter(3),
                                    ],
                                    controller: myhour,
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              )
                            ],
                          ),
                          Column(
                            children: <Widget>[
                              Align(
                                alignment: Alignment.center,
                                child: Text(
                                  "ti_minutes".tr,
                                  style: TextStyle(
                                      fontSize: MediaQuery.of(context).size.height*0.05
                                  ),
                                ),
                              ),
                              Align(
                                alignment: Alignment.center,
                                child: Container(
                                  width: MediaQuery.of(context).size.width*0.2,
                                  height: MediaQuery.of(context).size.height*0.1,
                                  child: TextFormField(
                                    keyboardType: TextInputType.datetime,
                                    inputFormatters:[
                                      LengthLimitingTextInputFormatter(2),
                                    ],
                                    controller: mymin,
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              )
                            ],
                          ),
                          Column(
                            children: <Widget>[
                              Align(
                                alignment: Alignment.center,
                                child: Text(
                                  "ti_seconds".tr,
                                  style: TextStyle(
                                      fontSize: MediaQuery.of(context).size.height*0.05
                                  ),
                                ),
                              ),
                              Align(
                                alignment: Alignment.center,
                                child: Container(
                                  width: MediaQuery.of(context).size.width*0.2,
                                  height: MediaQuery.of(context).size.height*0.1,
                                  child: TextFormField(
                                    keyboardType: TextInputType.datetime,
                                    inputFormatters:[
                                      LengthLimitingTextInputFormatter(2),
                                    ],
                                    controller: mysec,
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            )
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
          onPressed: (){
            newCurrentlyWorking = myhour.text +":"+ mymin.text +":"+ mysec.text;
            Navigator.pop(context, newCurrentlyWorking);
          },
          label: Text("ti_buttonText2".tr),
          backgroundColor: theme.cardColor,
      ),
    );
  }
}
