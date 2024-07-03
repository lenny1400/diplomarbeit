import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:get/get.dart';
import 'package:simple_nav_bar/responsive_screens/home/detailed_task.dart';

class MobileHome extends StatefulWidget {
  const MobileHome({
    Key? key,
    required this.constraint,
    required this.cons1,
    required this.cons2,
    required this.cons3,
    required this.cons4,
    required this.cons5,
    required this.itemCount,
  }) : super(key: key);

  final constraint;
  final cons1;
  final cons2;
  final cons3;
  final cons4;
  final cons5;
  final itemCount;

  @override
  _MobileHomeState createState() => _MobileHomeState();
}

class _MobileHomeState extends State<MobileHome> {

  //List<String> list = [];
  int length = 0;

  Future<List<String>> getLocalTasks() async {

    List<String> list = [];

    String user = FirebaseAuth.instance.currentUser!.uid;

    Directory? directory = await getApplicationDocumentsDirectory();
    String path = directory.path;

    directory = await Directory('$path/User/$user/tasks/extern/');

    List<FileSystemEntity> tasks = directory.listSync();

    for(int i = 0; i<tasks.length;i++){
      list.add(tasks[i].toString().split("/").last.split("'")[0]);
    }

    length = list.length;

    list = list.reversed.toList();

    return list;
  }

  @override
  void initState() {
    super.initState();
    getLocalTasks();
  }

  @override
  Widget build(BuildContext context) {
    //themeData
    final theme = Theme.of(context);
    // const main size constraint
    final constraintX = widget.constraint;
    //Green Output to Screen for debugging purposes
    final mdHeight = MediaQuery.of(context).size.height;
    final mdWidth = MediaQuery.of(context).size.width;
    //item count of finished contract;

    final _itemCount  = widget.itemCount;

    //final _itemCount = widget.itemCount;
    //constants
    final _cons1 = widget.cons1;
    final _cons2 = widget.cons2;
    final _cons3 = widget.cons3;
    final _cons4 = widget.cons4;
    final _cons5 = widget.cons5;
    final _boxHeight = (((2*_cons1) +_cons4)*_itemCount);


    return Center(
      child: FittedBox(
        fit: BoxFit.fitHeight,
        alignment: Alignment.center,
        child: SizedBox(
          height: constraintX,
          width: mdWidth,
          child:  Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(left: _cons4,top: _cons2),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "ho_titleTasks".tr,
                    style: TextStyle(
                        color: theme.dividerColor,
                        fontSize: _cons3,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: mdWidth,
                height: (MediaQuery.of(context).size.height/2) * 1.4,
                child: FutureBuilder(
                  future: getLocalTasks(),
                  builder: (BuildContext context, AsyncSnapshot<List<String>> snapshot) {
                  if(snapshot.connectionState == ConnectionState.none || snapshot.data == null || snapshot.data!.isEmpty) {
                    return Container(
                      child: Padding(
                        padding: EdgeInsets.only(top: _cons2),
                        child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            "ho_noTasks".tr,
                            style: TextStyle(
                                fontSize: _cons3,
                            ),
                          ),
                        ),
                      ),
                    );
                  }
                  else if(snapshot.connectionState == ConnectionState.waiting || snapshot.data == null || snapshot.data!.isEmpty){
                    return Container(
                        child: SizedBox(
                            child: CircularProgressIndicator(
                              color: theme.canvasColor,
                            ),
                          ),
                    );
                  }
                  else{
                      return ListView.builder(
                        primary: false,
                        shrinkWrap: true,
                        reverse: false,
                        physics: const ClampingScrollPhysics(),
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: EdgeInsets.only(left: _cons4, right: _cons4,top: _cons1,bottom: _cons1),
                            child: SizedBox(
                              height: _cons4,
                              width: mdWidth,
                              child: Align(
                                alignment: Alignment.center,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      foregroundColor: theme.canvasColor, backgroundColor: theme.colorScheme.surface,
                                      side: BorderSide(
                                        width: 1,
                                        color: theme.dividerColor,
                                      ),
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(5)
                                      )
                                  ),
                                  onPressed: (){
                                    Navigator.push(context, MaterialPageRoute(builder: (_) => detailedTask(taskName: snapshot.data![index])));
                                  },
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Expanded(
                                        child: Padding(
                                          padding: EdgeInsets.only(left: _cons1),
                                          child: Align(
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              snapshot.data![index],
                                              style: TextStyle(
                                                color: theme.dividerColor,
                                                fontSize: _cons2,
                                              ),
                                            ),
                                          ),
                                        ),
                                        flex: 3,
                                      ),
                                      Flexible(
                                        child: Align(
                                          alignment: Alignment.centerRight,
                                          child: Text(
                                            "ho_buttonText1".tr,
                                            style: TextStyle(
                                                color: theme.dividerColor,
                                                fontSize: _cons1
                                            ),
                                          ),
                                        ),
                                        flex: 1,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    }
                  },
                )
              ),
              /*Padding(
                padding: EdgeInsets.only(left: _cons3, right: _cons3,top: _cons1),
                child: SizedBox(
                  width: mdWidth,
                  height: _cons5,
                  child: TextButton(
                      style: TextButton.styleFrom(
                        primary: theme.backgroundColor,
                      ),
                      onPressed: (){
                        Navigator.pushNamed(context, '/alltasks');
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          Flexible(
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                padding: EdgeInsets.only(left: _cons2),
                                child: Text(
                                  "ho_subtitle1".tr,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: theme.dividerColor,
                                      fontSize: _cons2
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.centerRight,
                            child: IconTheme(
                              data: IconThemeData(
                                  color: theme.dividerColor,
                                  size: _cons3
                              ),
                              child: const Icon(Icons.keyboard_arrow_right_sharp),
                            ),
                          ),
                        ],
                      )
                  ),
                ),
              ),*/
            ],
          ),
        ),
      ),
    );
  }
}