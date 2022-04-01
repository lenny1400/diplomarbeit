import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'dart:io';
import 'package:archive/archive_io.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class export_task extends StatefulWidget {
  const export_task({Key? key}) : super(key: key);

  @override
  _export_taskState createState() => _export_taskState();
}

class _export_taskState extends State<export_task> {

  void convert_zip () async {

    try {
      String user = FirebaseAuth.instance.currentUser!.uid;
      Directory? directory = await getApplicationDocumentsDirectory();
      String path = directory.path;

      var encoder = ZipFileEncoder();
      encoder.create("/storage/emulated/0/Documents/tasks.zip");
      encoder.addDirectory(Directory("$path/User/$user/tasks/extern/"));
      encoder.close();


    }
    on Exception catch (_) {

      throw Exception("Error");
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
        backgroundColor: theme.backgroundColor,
        appBar: AppBar(
        title: Text("da_appbarExport".tr,
        style: theme.textTheme.caption,
    ),
    elevation: 0,
    ),
      body: Center(
          child: Container(
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.70,
              height: MediaQuery.of(context).size.height*0.06,
              child: FloatingActionButton(
                elevation: 0,
                heroTag: "btnExport",
                backgroundColor: theme.cardColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                ),
                onPressed: () {
                    convert_zip();
                },
                child: Text(
                  'Export as Zip'.tr,
                  style: theme.textTheme.bodyText1,
                ),
              )
          ),
      )));
  }
}
