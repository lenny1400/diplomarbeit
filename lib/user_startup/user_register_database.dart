// Firebase reference for user_id
import 'package:firebase_database/firebase_database.dart';

final DatabaseReference ref_user_id = FirebaseDatabase(databaseURL: "https://rocomp-app-d6d31-default-rtdb.europe-west1.firebasedatabase.app/").reference().child("User").child("user_id");

void setValuesDatabase(String uid, String myEmail, String myName){
  final DatabaseReference ref_user_id_child = FirebaseDatabase(databaseURL: "https://rocomp-app-d6d31-default-rtdb.europe-west1.firebasedatabase.app/").reference().child("User").child("user_id").child(uid);

  ref_user_id.set(uid);
  ref_user_id_child.child("email").set(myEmail);
  ref_user_id_child.child("fullname").set(myName);
}