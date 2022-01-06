import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:path_provider/path_provider.dart';
import 'package:simple_nav_bar/fileManagement/saveCount.dart';

final DatabaseReference _refIntern = FirebaseDatabase(databaseURL: "https://rocomp-app-d6d31-default-rtdb.europe-west1.firebasedatabase.app/").reference().child("Intern");

//This Function saves Intern Tasks to our Firebase Database
Future<void> uploadInternTask(String _doneTask, String _date, String _timeStart, String _timeEnd) async {

    int number = await saveCountIntern();
    String _fileName = "intern_" + number.toString();

  try{
    var _snpShot;
    await _refIntern.child(FirebaseAuth.instance.currentUser!.uid).child(_fileName).once().then((value)=>_snpShot);

    if(_snpShot==null){
      //hierarchy
      _refIntern.set( FirebaseAuth.instance.currentUser!.uid);
      _refIntern.child( FirebaseAuth.instance.currentUser!.uid).push().set(_fileName);
      _refIntern.child( FirebaseAuth.instance.currentUser!.uid).child(_fileName).child("Date").set(_date);
      _refIntern.child( FirebaseAuth.instance.currentUser!.uid).child(_fileName).child("Time").set(_timeStart+"-"+_timeEnd);
      _refIntern.child( FirebaseAuth.instance.currentUser!.uid).child(_fileName).child("Task").set(_doneTask);
    }
  }on Exception catch (Exception){
    print("Exception: " + Exception.toString());
  }
}