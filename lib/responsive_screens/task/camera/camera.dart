import 'dart:async';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:simple_nav_bar/user_startup/user_customer.dart';
import 'package:simple_nav_bar/user_startup/user_task.dart';

// A screen that allows users to take a picture using a given camera.
class TakePictureScreen extends StatefulWidget {
  const TakePictureScreen({
    Key? key,
    required this.camera,
    required this.task
  }) : super(key: key);

  final User_task task;
  final CameraDescription camera;
  @override
  TakePictureScreenState createState() => TakePictureScreenState(this.task);
}

class TakePictureScreenState extends State<TakePictureScreen> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;

  User_task task;

  TakePictureScreenState(this.task);


  @override
  void initState() {
    super.initState();

    // To display the current output from the Camera,
    // create a CameraController.
    _controller = CameraController(
      // Get a specific camera from the list of available cameras.
      widget.camera,
      // Define the resolution to use.
      ResolutionPreset.ultraHigh,
    );

    // Next, initialize the controller. This returns a Future.
    _initializeControllerFuture = _controller.initialize();
  }

  @override
  void dispose() {
    // Dispose of the controller when the widget is disposed.
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Take a picture'),elevation: 0,),
      // You must wait until the controller is initialized before displaying the
      // camera preview. Use a FutureBuilder to display a loading spinner until the
      // controller has finished initializing.
      body: FutureBuilder<void>(
        future: _initializeControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            // If the Future is complete, display the preview.
            return Container(
              width: MediaQuery.of(context).size.width*1,
              height: MediaQuery.of(context).size.height*1,
              child: CameraPreview(_controller)
            );
          } else {
            // Otherwise, display a loading indicator.
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButton: Padding(
        padding: EdgeInsets.only(right: 30, bottom: 30),
        child: FloatingActionButton(
          elevation: 0,
          heroTag: "picture",
          // Provide an onPressed callback.
          onPressed: () async {
            // Take the Picture in a try / catch block. If anything goes wrong,
            // catch the error.
            try {
              // Ensure that the camera is initialized.
              await _initializeControllerFuture;
              // Attempt to take a picture and get the file `image`
              // where it was saved.
              final image = await _controller.takePicture();

              // If the picture was taken, display it on a new screen.
              await Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => DisplayPictureScreen(
                    // Pass the automatically generated path to
                    // the DisplayPictureScreen widget.
                    imagePath: image.path,
                    task: task,
                  ),
                ),
              );
            } catch (e) {
              // If an error occurs, log the error to the console.
              print(e);
            }
          },
          child: const Icon(Icons.camera_alt),
        ),
      )
    );
  }
}


// A widget that displays the picture taken by the user.
class DisplayPictureScreen extends StatefulWidget {
  final String imagePath;
  final User_task task;

  const DisplayPictureScreen({Key? key, required this.imagePath, required this.task})
      : super(key: key);

  @override
  _DisplayPictureScreenState createState() => _DisplayPictureScreenState(this.task);
}

class _DisplayPictureScreenState extends State<DisplayPictureScreen> {

  String user = FirebaseAuth.instance.currentUser!.uid;
  late String folderName = "";
  late String fileName = "";
  late int itemCount = 0;
  List<FileSystemEntity> file = [];
  bool done = false;

  final User_task task;

  _DisplayPictureScreenState(this.task);

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  checkifFolderExists() async {
    String taskname = task.name;
    final directory = await _localPath;
    bool existsTask = await Directory(directory+"/User/$user/tasks/extern/$taskname").exists();

    if(!existsTask){
      new Directory(directory+"/User/$user/tasks/extern/$taskname").create();
    }
  }

  checkImageExists() async {
    final path = widget.imagePath;
    bool isExist = await File(path).exists();
    if (isExist) {
      return true;
    }else{
      return false;
    }
  }

  _deleteImage() async {
    final path = widget.imagePath;
    bool ifExist = await Directory(path).exists();
    if (ifExist) {
      await File(path).delete();
    }

    done = true;
  }

  saveImage() async {
    File file = File(widget.imagePath);
    file.copy('$folderName/$fileName');

    //_deleteImage();
  }

  createFolder()async{


    String taskname = task.name;

    late TimeOfDay time = TimeOfDay.now();

    final directory = await _localPath;
    folderName = directory + "/User/$user/tasks/extern/$taskname/";

    final directory1 = Directory(folderName);

    int count = await directory1.list().length + 1;

    fileName = "picture_" + count.toString() + ".jpg";

    saveImage();
  }

  @override
  void initState() {
    checkifFolderExists();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Display the Picture'),elevation: 0,),
      // The image is stored as a file on the device. Use the `Image.file`
      // constructor with the given path to display the image.
      body: Container(
        width: MediaQuery.of(context).size.width*1,
        height: MediaQuery.of(context).size.height*1,
        child: FittedBox(
          fit: BoxFit.fill,
          child: Image.file(File(widget.imagePath)),
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 20, bottom: 20),
            child: FloatingActionButton(
              elevation: 0,
              heroTag: "retry",
              onPressed: (){
                _deleteImage();
                Navigator.pop(context);
              },
              child: Icon(Icons.refresh),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 20, bottom: 20,right: 20),
            child: FloatingActionButton(
              elevation: 0,
              heroTag: "Save",
              onPressed: ()async{
                createFolder();
                await Future.delayed(Duration(milliseconds: 300));
                var count = 0;
                Navigator.popUntil(context, (route) {
                  return count++ == 2;
                });
              },
              child: Icon(Icons.save),
            ),
          ),
        ],
      ),
    );
  }
}
