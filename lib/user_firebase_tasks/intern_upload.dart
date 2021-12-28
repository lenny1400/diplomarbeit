import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

final DatabaseReference _refIntern = FirebaseDatabase(databaseURL: "https://rocomp-app-d6d31-default-rtdb.europe-west1.firebasedatabase.app/").reference().child("Intern");


void uploadInternTask(String _doneTask, String _date, String _timeStart, String _timeEnd){

  Future<DataSnapshot> snapshot = _refIntern.child(FirebaseAuth.instance.currentUser!.uid).child(_date).child(_timeStart+"-"+_timeEnd).once();
  //hierarchy
  _refIntern.set(FirebaseAuth.instance.currentUser!.uid);
  _refIntern.child(FirebaseAuth.instance.currentUser!.uid).set(_date);
  _refIntern.child(FirebaseAuth.instance.currentUser!.uid).child(_date).set(_timeStart+"-"+_timeEnd);
  _refIntern.child(FirebaseAuth.instance.currentUser!.uid).child(_date).child(_timeStart+"-"+_timeEnd).child("Task").set(_doneTask);
}