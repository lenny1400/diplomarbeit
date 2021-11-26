import 'dart:io';
import 'dart:typed_data';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:signature/signature.dart';
import 'package:simple_nav_bar/user_startup/user_task.dart';

void saveCount () async {

  String user = FirebaseAuth.instance.currentUser!.uid;

  final directory = await getApplicationDocumentsDirectory();

  String path =directory.path;

  int count = int.parse(await File('$path/User/$user/tasks/extern/count.txt').readAsString());

  count += 1;

  File('$path/User/$user/tasks/extern/count.txt').writeAsString(count.toString());

  print(count);

}