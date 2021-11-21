import 'dart:io' as io;

import 'package:camera/camera.dart';
import 'package:signature/signature.dart';
import 'package:simple_nav_bar/responsive_screens/task/camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:simple_nav_bar/responsive_screens/task/signature/signature.dart';
import 'package:simple_nav_bar/themes.dart';
import 'package:flutter/services.dart';
import 'package:simple_nav_bar/user_startup/user_task.dart';

// Future main() async {
//
//   WidgetsFlutterBinding.ensureInitialized();
//   await SystemChrome.setPreferredOrientations([
//     DeviceOrientation.portraitUp,
//     DeviceOrientation.portraitDown,
//   ]);
//
//   runApp(ExistingCustomerSecondPage());
//
// }
/*
class ExistingCustomerSecondPage extends StatefulWidget {
  final int pop;
  const ExistingCustomerSecondPage({Key? key, required this.pop}) : super(key: key);

  @override
  _ExistingCustomerSecondPageState createState() => _ExistingCustomerSecondPageState(pop);
}

class _ExistingCustomerSecondPageState extends State<ExistingCustomerSecondPage> {

  int pop;
  _ExistingCustomerSecondPageState(this.pop);

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
      home: CreateTask(title: 'Existing Customer',pop: pop),
      title: 'Flutter Theme Demo',
      debugShowCheckedModeBanner: false,
      theme: CustomTheme.lightTheme,
      darkTheme: CustomTheme.darkTheme,
      themeMode: currentTheme.currentTheme,
    );
  }
}
*/
class CreateTask extends StatefulWidget {
  const CreateTask({Key? key, required this.title,required this.pop, required this.task}) : super(key: key);

  final User_task task;
  final String title;
  final int pop;

  @override
  _CreateTaskState createState() => _CreateTaskState(pop,task);
}

class _CreateTaskState extends State<CreateTask> {

  final User_task task;
  int pop;
  _CreateTaskState(this.pop,this.task);

  bool _isTextFieldDTOkay = false;
  bool _isTextFieldMAOkay = false;

  bool _isEverythingOkay = false;
  Color _isEverythingOkayColor = Colors.red;

  final myControllerDoneTask = TextEditingController();
  final myControllerMaterial = TextEditingController();


  String errorText = "";

  void controllEverything(){

    if(myControllerMaterial.text.isEmpty){
      _isTextFieldMAOkay = false;
      errorText = "Please fill out Textfield 2";
      _isEverythingOkayColor = Colors.red;
    }else{
      _isTextFieldMAOkay = true;
      errorText = "";
    }

    if(myControllerDoneTask.text.isEmpty){
      _isTextFieldDTOkay = false;
      errorText = "Please fill out Textfield 1";
      _isEverythingOkayColor = Colors.red;
    }else{
      _isTextFieldDTOkay = true;
      errorText = "";
    }

    if(_isTextFieldDTOkay && _isTextFieldMAOkay){
      _isEverythingOkay = true;
    }

  }

  @override
  void initState() {
    super.initState();
    second();
  }

  late final CameraDescription camera;

  Future second()async{
    // Ensure that plugin services are initialized so that `availableCameras()`
    // can be called before `runApp()`
    WidgetsFlutterBinding.ensureInitialized();

    // Obtain a list of the available cameras on the device.
    final cameras = await availableCameras();
    print(cameras);
    // Get a specific camera from the list of available cameras.
    final firstCamera = cameras.first;

    camera = firstCamera;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

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
            child: Container(
              width: MediaQuery.of(context).size.width*1,
              height: MediaQuery.of(context).size.height*1,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    height: MediaQuery.of(context).size.height*0.07,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width*0.85,
                    height: MediaQuery.of(context).size.height*0.05,
                    child: Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: EdgeInsets.only(left: 40,),
                          child: Text(
                            "Durchgeführte Tätigkeit",
                            style: theme.textTheme.headline5,
                          ),
                        )
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width*0.85,
                    height: MediaQuery.of(context).size.height*0.02,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width*1,
                    height: MediaQuery.of(context).size.height*0.15,
                    child: Padding(
                      padding: EdgeInsets.only(left: 40,right:60),
                      child: TextField(
                        controller: myControllerDoneTask,
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
                    )
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width*0.85,
                    height: MediaQuery.of(context).size.height*0.02,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width*0.85,
                    height: MediaQuery.of(context).size.height*0.05,
                    child: Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: EdgeInsets.only(left: 40,),
                          child: Text(
                            "Materialaufwand",
                            style: theme.textTheme.headline5,
                          ),
                        )
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width*0.85,
                    height: MediaQuery.of(context).size.height*0.02,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width*1,
                    height: MediaQuery.of(context).size.height*0.15,
                    child: Padding(
                      padding: EdgeInsets.only(left: 40,right: 60),
                      child: TextField(
                        controller: myControllerMaterial,
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
                    )
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width*0.85,
                    height: MediaQuery.of(context).size.height*0.04,
                  ),
                  FittedBox(
                    fit: BoxFit.fitWidth,
                    alignment: Alignment.center,
                    child: Container(
                      width: MediaQuery.of(context).size.width*1,
                      height: MediaQuery.of(context).size.height*0.1,
                      child: Padding(
                        padding: EdgeInsets.only(left: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.only(left: 20),
                              child: Text(
                                "Bilder",
                                style: theme.textTheme.caption,
                              ),
                            ),
                            Padding(
                                padding: EdgeInsets.only(right: 60),
                                child: Row(
                                  children: <Widget>[
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: IconButton(
                                        onPressed: (){
                                          Navigator.push(context, MaterialPageRoute(builder: (_) => TakePictureScreen(camera: camera, task: task)));
                                        },
                                        icon: Icon(CupertinoIcons.camera),
                                        iconSize: 50,
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment.centerRight,
                                      child: IconButton(
                                        onPressed: (){
                                          print("Show Picture");
                                        },
                                        icon: Icon(CupertinoIcons.photo),
                                        iconSize: 50,
                                      ),
                                    )
                                  ],
                                )
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width*0.95,
                    height: MediaQuery.of(context).size.height*0.13,
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
                    height: MediaQuery.of(context).size.height*0.025,
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
                            heroTag: "btnNewCustomer",
                            backgroundColor: theme.cardColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(Radius.circular(10.0)),
                            ),
                            onPressed: () {
                              setState(() {

                                task.material = myControllerMaterial.text;
                                task.text = myControllerDoneTask.text;

                                controllEverything();

                                if(_isEverythingOkay){
                                  errorText = "Done";
                                  _isEverythingOkayColor = Colors.green;
                                }


                                if(errorText == "Done"){

                                  pop = pop + 1;

                                  Navigator.push(context, MaterialPageRoute(builder: (_) => SignatureApp(pop: pop, task: task)));
                                  //var count = 0;
                                  //Navigator.popUntil(context, (route) {return count++ == pop;});
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
          )
      ),
    );
  }
}