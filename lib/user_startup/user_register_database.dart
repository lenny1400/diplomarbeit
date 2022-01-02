// Firebase reference for user_id
import 'package:firebase_database/firebase_database.dart';

final DatabaseReference ref_user_id = FirebaseDatabase(databaseURL: "https://rocomp-app-d6d31-default-rtdb.europe-west1.firebasedatabase.app/").reference().child("User").child("user_id");
final DatabaseReference _ref_Intern_Task = FirebaseDatabase(databaseURL: "https://rocomp-app-d6d31-default-rtdb.europe-west1.firebasedatabase.app/").reference().child("Intern");

void setValuesDatabase(String uid, String myEmail, String myName){
  final DatabaseReference ref_user_id_child = FirebaseDatabase(databaseURL: "https://rocomp-app-d6d31-default-rtdb.europe-west1.firebasedatabase.app/").reference().child("User").child("user_id").child(uid);
  //Saving email and fullname to database
  ref_user_id.set(uid);
  ref_user_id_child.child("email").set(myEmail);
  ref_user_id_child.child("fullname").set(myName);

  //creating task and children
  _ref_Intern_Task.set(uid);

}