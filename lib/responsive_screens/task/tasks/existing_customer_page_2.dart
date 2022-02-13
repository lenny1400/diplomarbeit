
import 'dart:io' as io;
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:path_provider/path_provider.dart';
import 'package:signature/signature.dart';
import 'package:simple_nav_bar/responsive_screens/task/camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:simple_nav_bar/responsive_screens/task/signature/signature.dart';
import 'package:simple_nav_bar/themes.dart';
import 'package:flutter/services.dart';
import 'package:simple_nav_bar/user_startup/user_task.dart';

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
    }

    if(myControllerDoneTask.text.isEmpty){
      _isTextFieldDTOkay = false;
      errorText = "Please fill out Textfield 1";
      _isEverythingOkayColor = Colors.red;
    }else{
      _isTextFieldDTOkay = true;
    }

    if(_isTextFieldDTOkay && _isTextFieldMAOkay){
      _isEverythingOkay = true;
      errorText = "";
      _isEverythingOkayColor = Colors.green;
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


  Future<void> safePicture(io.File file) async{

    final directory = await getApplicationDocumentsDirectory();

    String user = FirebaseAuth.instance.currentUser!.uid;

    final directory1 = await Directory(directory.path + "/User/$user/tasks/extern/${task.name}/").create(recursive: true);

    int count = await directory1.list().length + 1;

    String fileName = "picture_" + count.toString() + ".jpg";

    file.copy('${directory1.path}/$fileName');
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
                            "ta_titleActivity".tr,
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
                            "ta_titleMaterial".tr,
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
                                "ta_titlePictures".tr,
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
                                        onPressed: () async {

                                          FilePickerResult? result = await FilePicker.platform.pickFiles(
                                            type: FileType.custom,
                                            allowedExtensions: ['jpg', 'jpeg', 'png'],
                                          );

                                          if (result != null) {
                                            io.File file = io.File(result.files.single.path.toString());
                                            safePicture(file);
                                            errorText = "File Saved";
                                            _isEverythingOkayColor = Colors.green;
                                          } else {
                                            // User canceled the picker
                                            errorText ="No Files Selected";
                                            _isEverythingOkayColor = Colors.red;
                                          }
                                          setState(() {});
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
                                }

                              });

                            },
                            child: Text(
                              "ta_buttonNext".tr,
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