import 'dart:io';
import 'dart:typed_data';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:simple_nav_bar/user_startup/user_task.dart';
import 'package:firebase_storage/firebase_storage.dart';

final DatabaseReference _refIntern = FirebaseDatabase(databaseURL: "https://rocomp-app-d6d31-default-rtdb.europe-west1.firebasedatabase.app/").reference().child("Extern");

Future<void> uploadExternTask(User_task task)async {

  print(task.text);
  print(task.customer.company);
  print(task.customer.number);
  print(task.material);
  print(task.Anfahrt);
  print(task.time);

  try{
    _refIntern.set( FirebaseAuth.instance.currentUser!.uid);
    var _snpShot;
    await _refIntern.child(FirebaseAuth.instance.currentUser!.uid).child(task.name).once().then((value)=>_snpShot);

    if(_snpShot==null){
      //hierarchy
      _refIntern.child( FirebaseAuth.instance.currentUser!.uid).push().set(task.name);
      _refIntern.child( FirebaseAuth.instance.currentUser!.uid).child(task.name).child("Kunde").set(task.customer.company);
      _refIntern.child( FirebaseAuth.instance.currentUser!.uid).child(task.name).child("Kundennummer").set(task.customer.number);

      if(task.Anfahrt){
        _refIntern.child( FirebaseAuth.instance.currentUser!.uid).child(task.name).child("Anfahrt").set(task.km.toString() + " km");
        //_refIntern.child( FirebaseAuth.instance.currentUser!.uid).child(task.name).child("Anfahrt").set(task.km);
      }else{
        _refIntern.child( FirebaseAuth.instance.currentUser!.uid).child(task.name).child("Anfahrt").set("false");
      }
      _refIntern.child( FirebaseAuth.instance.currentUser!.uid).child(task.name).child("Zeit").set(task.time);
      _refIntern.child( FirebaseAuth.instance.currentUser!.uid).child(task.name).child("Arbeit").set(task.text);
      _refIntern.child( FirebaseAuth.instance.currentUser!.uid).child(task.name).child("Material").set(task.material);
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

  if(Signature.existsSync()) {

    FirebaseStorage firebaseStorage = FirebaseStorage.instance;

    Reference storageReference = FirebaseStorage.instance.ref().child(
        "gs://rocomp-app-d6d31.appspot.com/$name");

    final UploadTask uploadTask = storageReference.putFile(Signature);

    final TaskSnapshot downloadUrl = (await uploadTask);

    final String url = await downloadUrl.ref.getDownloadURL();

    print(url);

  }

}