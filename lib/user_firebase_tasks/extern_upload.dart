import 'dart:io';
import 'dart:typed_data';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:simple_nav_bar/fileManagement/saveCount.dart';
import 'package:simple_nav_bar/user_startup/user_task.dart';
import 'package:firebase_storage/firebase_storage.dart';

final DatabaseReference _refExtern = FirebaseDatabase(databaseURL: "https://rocomp-app-d6d31-default-rtdb.europe-west1.firebasedatabase.app/").reference().child("Extern");

Future<void> uploadExternTask(User_task task)async {

  print(task.text);
  print(task.customer.company);
  print(task.customer.number);
  print(task.material);
  print(task.Anfahrt);
  print(task.time);

  try{
    _refExtern.set( FirebaseAuth.instance.currentUser!.uid);
    var _snpShot;
    await _refExtern.child(FirebaseAuth.instance.currentUser!.uid).child(task.name).once().then((value)=>_snpShot);

    if(_snpShot==null){
      //hierarchy
      _refExtern.child( FirebaseAuth.instance.currentUser!.uid).push().set(task.name);
      _refExtern.child( FirebaseAuth.instance.currentUser!.uid).child(task.name).child("Kunde").set(task.customer.company);
      _refExtern.child( FirebaseAuth.instance.currentUser!.uid).child(task.name).child("Kundennummer").set(task.customer.number);

      if(task.Anfahrt){
        _refExtern.child( FirebaseAuth.instance.currentUser!.uid).child(task.name).child("Anfahrt").set(task.km.toString() + " km");
        //_refIntern.child( FirebaseAuth.instance.currentUser!.uid).child(task.name).child("Anfahrt").set(task.km);
      }else{
        _refExtern.child( FirebaseAuth.instance.currentUser!.uid).child(task.name).child("Anfahrt").set("false");
      }
      _refExtern.child( FirebaseAuth.instance.currentUser!.uid).child(task.name).child("Zeit").set(task.time);
      _refExtern.child( FirebaseAuth.instance.currentUser!.uid).child(task.name).child("Arbeit").set(task.text);
      _refExtern.child( FirebaseAuth.instance.currentUser!.uid).child(task.name).child("Material").set(task.material);


    }
  }on Exception catch (Exception){
    print("Exception: " + Exception.toString());
  }


  //Save PICTURES

  //FirebaseStorage.instance.ref();
  String name = task.name;
  String user = FirebaseAuth.instance.currentUser!.uid;
  Directory? directory = await getApplicationDocumentsDirectory();
  String path = directory.path;
  File Signature =  File('$path/User/$user/tasks/extern/$name/signature.png');
  final DateTime now = DateTime.now();
  final DateFormat formatter = DateFormat('yyyy-MM-dd');
  final String formatted = formatter.format(now);


  if(Signature.existsSync()) {

    Reference storageReference = FirebaseStorage.instance.ref("${FirebaseAuth.instance.currentUser!.uid}/${formatted}/${task.name}").child("signature");

    final UploadTask uploadTask = storageReference.putFile(Signature);

    final TaskSnapshot downloadUrl = (await uploadTask);

    final String url = await downloadUrl.ref.getDownloadURL();

    print(url);

  }

  Directory? directory1 = Directory('$path/User/$user/tasks/extern/$name');



  for(int i = 0; i<directory1.listSync().length;i++){

    List<String> string = directory1.listSync()[i].toString().split("/").last.split(".");

    if(string[1] == "jpg'"){
      String picturename = string[0].split("'")[0];

      print(picturename);

      File picture =  File('$path/User/$user/tasks/extern/$name/${picturename}.jpg');

      print(picture);

      Reference storageReference = FirebaseStorage.instance.ref("${FirebaseAuth.instance.currentUser!.uid}/${formatted}/${task.name}").child("${picturename}");

      final UploadTask uploadTask = storageReference.putFile(picture);

      final TaskSnapshot downloadUrl = (await uploadTask);

      final String url = await downloadUrl.ref.getDownloadURL();

      print(url);

    }
  }

}