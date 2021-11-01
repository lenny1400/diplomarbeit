import 'dart:async';
import 'dart:io';
import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

import '../../themes.dart';
import 'my_flutter_app_icons.dart';
import 'package:intl/date_symbol_data_local.dart';

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
    return MaterialApp(
      home: TimePage(title: 'Time'),
      title: 'Flutter Theme Demo',
      debugShowCheckedModeBanner: false,
      theme: CustomTheme.lightTheme,
      darkTheme: CustomTheme.darkTheme,
      themeMode: currentTheme.currentTheme,
    );
  }

}


class TimePage extends StatefulWidget {
  TimePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _TimePageState createState() => _TimePageState();
}

class _TimePageState extends State<TimePage> {

  //variables for View
  var hour;
  var min;
  var sec;
  final String defaultLocale = Platform.localeName; // Phone local

  static String _getLocalizedWeekDay(String local, DateTime date) {
    final formatter = DateFormat(DateFormat.WEEKDAY, local);
    return formatter.format(date);
  }

  var dayofweek; //= DateFormat('EEEE', ).format(DateTime.now());
  var dayofmonth = DateTime.now().day;
  var month = DateFormat('MMMM').format(DateTime.now());

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

  void time(){
    hour = DateTime.now().hour;
    min = DateTime.now().minute;
    sec = DateTime.now().second;
    dayofweek = _getLocalizedWeekDay("de_DE", DateTime.now());

    //if min smaller than 10
    if (min < 10){
      min = "0" + min.toString();
    }

    currentlyWorking = "00:00:00";
  }

  Timer? _timer;
  int _start = 0;

  void timeWorkUpdate(){
    String sec = "";
    String min = "";
    String hour = "";


    timeSec = _start;

    if(timeSec > 59){
      timeSec = 0;
      timeMin++;
      if(timeMin > 59){
        timeMin = 0;
        timeHour++;
      }
    }

    if(timeSec < 10){
      sec = "0" + timeSec.toString();
    }else{
      sec = timeSec.toString();
    }
    if(timeMin < 10){
      min = "0" + timeMin.toString();
    }else{
      min = timeMin.toString();
    }
    if(timeHour < 10){
      hour = "0" + timeHour.toString();
    }else{
      hour = timeHour.toString();
    }

    currentlyWorking = hour+ ":" + min + ":" + sec;
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

  @override
  void initState() {
    super.initState();
    initializeDateFormatting(defaultLocale);
    time();
  }

  @override
  void dispose() {
    _timer?.cancel();
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
                  height: MediaQuery.of(context).size.height*0.2,
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
                                  "Arrive",
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
                                  "Leave",
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
                        'Currently working',
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
                        width: MediaQuery.of(context).size.width*0.18,
                        child: FloatingActionButton(
                          elevation: 0,
                          onPressed: () {
                            Navigator.push(context,MaterialPageRoute(builder: (context) => EditTime(time: currentlyWorking,)),
                            );
                          },
                          child: Text("Edit",style: TextStyle(fontSize: MediaQuery.of(context).size.height*0.02),),
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

  @override
  void initState() {
    super.initState();

    mymin.text = "00";
    mysec.text = "00";
    myhour.text = "00";

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

    return Scaffold(
      backgroundColor: theme.backgroundColor,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text("Edit Time",
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
                          "Initial Time",
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
                            widget.time,
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
                                    "Hours",
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
                                  "Minutes",
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
                                  "Seconds",
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
          onPressed: (){},
          label: Text("Check Time"),
          backgroundColor: theme.cardColor,
      ),
    );
  }
}
