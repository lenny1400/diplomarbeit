import 'dart:io';
import 'dart:typed_data';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:path_provider/path_provider.dart';
import 'package:simple_nav_bar/fileManagement/saveCount.dart';
import 'package:simple_nav_bar/user_firebase_tasks/extern_upload.dart';
import 'package:simple_nav_bar/user_startup/user_customer.dart';
import 'package:simple_nav_bar/user_startup/user_task.dart';

class detailedTask extends StatefulWidget {
  const detailedTask({Key? key, required this.taskName}) : super(key: key);

  final String taskName;

  @override
  _detailedTaskState createState() => _detailedTaskState(taskName);
}

class _detailedTaskState extends State<detailedTask> {

  final String taskName;

  _detailedTaskState(this.taskName);

  Future<List<String>> getTask () async {
    String user = FirebaseAuth.instance.currentUser!.uid;

    Directory? directory = await getApplicationDocumentsDirectory();
    String path = directory.path;

    directory = await Directory('$path/User/$user/tasks/extern/');

    String taskData = await File('${directory.path}$taskName/task.txt').readAsString();

    List<String> task = [];

    for(int i = 0; i<taskData.split("\n").length; i++){
      task.add(taskData.split("\n")[i]);
    }

    return task;
  }

  Future<Uint8List> getSignature () async {

    Uint8List signature;

    String user = FirebaseAuth.instance.currentUser!.uid;

    Directory? directory = await getApplicationDocumentsDirectory();
    String path = directory.path;

    directory = await Directory('$path/User/$user/tasks/extern/$taskName');

    signature = await File('${directory.path}/signature.png').readAsBytes();

    return signature;
  }


  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
        backgroundColor: theme.backgroundColor,
      appBar: AppBar(
        title: Text("ho_appbarDetailedTask".tr,style: theme.textTheme.caption),
      ),
      body: Center(
        child: FutureBuilder(
          future: getTask(),
          builder: (BuildContext context, AsyncSnapshot<List<String>> snapshot) {
            if(snapshot.connectionState == ConnectionState.none || snapshot.data == null){
              return Container();
            }
            else{
              return Container(
                child: Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: ListView.builder(
                      itemCount: 1,
                        itemBuilder: (context, index){
                          return Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                      snapshot.data![0],
                                      style: theme.textTheme.headline3
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                      snapshot.data![1],
                                      style: theme.textTheme.headline3
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                      snapshot.data![2],
                                      style: theme.textTheme.headline3
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                      snapshot.data![3],
                                      style: theme.textTheme.headline3
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                      snapshot.data![4],
                                      style: theme.textTheme.headline3
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                      snapshot.data![5],
                                      style: theme.textTheme.headline3
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                      snapshot.data![6],
                                      style: theme.textTheme.headline3
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                      "ho_signature".tr,
                                      style: theme.textTheme.headline3
                                  ),
                                ),
                                FutureBuilder(
                                  future: getSignature(),
                                  builder: (BuildContext context,
                                      AsyncSnapshot<Uint8List> snapshot) {
                                    if(snapshot.data == null){
                                      return Container();
                                    }
                                    else{
                                      return Image.memory(snapshot.data!);
                                    }
                                  },
                                ),
                                Align(
                                  alignment: Alignment.center,
                                  child: Container(
                                      height: MediaQuery.of(context).size.height*0.06,
                                      width: MediaQuery.of(context).size.width*0.4,
                                      child: Padding(
                                        padding: EdgeInsets.all(0),
                                        child: FloatingActionButton(
                                          elevation: 0,
                                          heroTag: "btnBack",
                                          backgroundColor: theme.cardColor,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                          ),
                                          onPressed: () {
                                            getTask();
                                            Navigator.pop(context);
                                          },
                                          child: Text(
                                            "ho_buttonBack".tr,
                                            style: theme.textTheme.bodyText1,
                                          ),
                                        ),
                                      )
                                  ),
                                )

                              ]
                          );
                        }
                    )
                  ),
                )
              );
            }
          },
        ),
      )
    );
  }
}
