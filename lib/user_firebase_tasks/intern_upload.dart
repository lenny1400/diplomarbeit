import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

final DatabaseReference _refIntern = FirebaseDatabase(databaseURL: "https://rocomp-app-d6d31-default-rtdb.europe-west1.firebasedatabase.app/").reference().child("Intern");


void uploadInternTask(String _doneTask, String _date, String _timeStart, String _timeEnd) async{

  //Check if data is already saved
  try{
    var _snpShot;
    await _refIntern.child(FirebaseAuth.instance.currentUser!.uid).child(_date).once().then((value) => _snpShot);

    if(_snpShot == null){
      print("Date is not added");
      _refIntern.child(FirebaseAuth.instance.currentUser!.uid).set(_date);
    }else{
      print("Date is added");
    }

  }on Exception catch (Exception){
    print("Exception: " + Exception.toString());
  }
/*  //hierarchy
  _refIntern.set(FirebaseAuth.instance.currentUser!.uid);
  _refIntern.child(FirebaseAuth.instance.currentUser!.uid).set(_date);
  _refIntern.child(FirebaseAuth.instance.currentUser!.uid).child(_date).set(_timeStart+"-"+_timeEnd);
  _refIntern.child(FirebaseAuth.instance.currentUser!.uid).child(_date).child(_timeStart+"-"+_timeEnd).child("Task").set(_doneTask);*/
}