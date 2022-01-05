import 'dart:io';
import 'dart:typed_data';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:signature/signature.dart';
import 'package:simple_nav_bar/fileManagement/saveCount.dart';
import 'package:simple_nav_bar/user_firebase_tasks/extern_upload.dart';
import 'package:simple_nav_bar/user_startup/user_task.dart';



class SignatureApp extends StatefulWidget {

  const SignatureApp({Key? key, required this.pop, required this.task}) : super(key: key);

  final User_task task;
  final int pop;

  @override
  _SignatureAppState createState() => _SignatureAppState(this.pop,this.task);
}

class _SignatureAppState extends State<SignatureApp> {

  User_task task;
  int pop;
  _SignatureAppState(this.pop,this.task);

  final SignatureController _controller = SignatureController(
    penStrokeWidth: 1,
    penColor: Colors.black,
    exportBackgroundColor: Colors.white,
    onDrawStart: () => true,
    onDrawEnd: () => true,
  );



  @override
  void initState() {
    super.initState();
    _controller.addListener(() => true);
  }

  @override
  Widget build(BuildContext context) {

    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.backgroundColor,
          appBar: AppBar(
            title: Text("Unterschrift:",  style: theme.textTheme.headline6,),
          ),
          body: Align(
            alignment: Alignment.center,
            child: Container(
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.black)
              ),
              child: ListView(
                shrinkWrap: true,
                padding: const EdgeInsets.all(0),
                children: <Widget>[
                  //SIGNATURE CANVAS
                  Center(child: Signature(
                    controller: _controller,
                    height: 500,
                    backgroundColor: Colors.white,
                  )),
                ],
              ),
            ),
          ),
          floatingActionButton: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: EdgeInsets.only(left: 20, bottom: 20),
                child: FloatingActionButton(
                  elevation: 0,
                  backgroundColor: Colors.grey,
                  heroTag: "retry",
                  onPressed: () {
                    setState(() => _controller.clear());
                  },
                  child: Icon(Icons.refresh),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 20, bottom: 20,right: 20),
                child: FloatingActionButton(
                  elevation: 0,
                  heroTag: "Save",
                  backgroundColor: Colors.grey,
                  onPressed: () async {
                    if (_controller.isNotEmpty) {
                      final Uint8List? data =
                      await _controller.toPngBytes();

                      Image.memory(data!);

                      String user = FirebaseAuth.instance.currentUser!.uid;
                      String name = task.name;//id vom Auftag maybe?

                      Directory? directory = await getApplicationDocumentsDirectory();
                      String path = directory.path;
                      print(path);

                      await Directory('$path/User/$user/tasks/extern/$name').create(recursive: true);

                      File('$path/User/$user/tasks/extern/$name/signature.png')
                          .writeAsBytesSync(data.buffer.asInt8List());

                      var count = 0;

                      FocusScope.of(context).unfocus();

                      String content = "Auftrag: " + task.name + "\n";

                      if(task.Anfahrt){
                        content += "Eine Anfahrt von: " + task.km.toString()+ " km"+"\n";;
                      }

                      content += "Kunde: " + task.customer.company + "\n";

                      content += "Kundennummer: " + task.customer.number.toString() + "\n";

                      content += "Zeitaufwand: " + task.time + "\n" + "Arbeit: " + task.text + "\n" + "Materiel: " + task.material + "\n";

                      final File file =  File('$path/User/$user/tasks/extern/$name/task.txt');

                      file.writeAsString(content);

                      uploadExternTask(task);

                      Navigator.popUntil(context, (route) {return count++ == pop;});
                    }
                  },
                  child: Icon(Icons.save),
                ),
              ),
            ],
          ),
        );
  }
}