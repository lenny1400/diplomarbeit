import 'dart:io';
import 'dart:typed_data';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:signature/signature.dart';
import 'package:simple_nav_bar/user_startup/user_task.dart';


final String user = FirebaseAuth.instance.currentUser!.uid;
final DatabaseReference _refIntern = FirebaseDatabase(databaseURL: "https://rocomp-app-d6d31-default-rtdb.europe-west1.firebasedatabase.app/").reference().child("Intern");
final DatabaseReference _refExtern = FirebaseDatabase(databaseURL: "https://rocomp-app-d6d31-default-rtdb.europe-west1.firebasedatabase.app/").reference().child("Extern");

Future<int> saveCountIntern() async {

  DataSnapshot _snpShot = await _refIntern.child(FirebaseAuth.instance.currentUser!.uid).child("count").once();

  if(_snpShot.value!=null) {
    final snapshot = await _refIntern.child(FirebaseAuth.instance.currentUser!.uid).child("count").once();
    int value = snapshot.value + 1;
    _refIntern.child(FirebaseAuth.instance.currentUser!.uid).child("count").set(value);
    return value;
  }
  else{
    _refIntern.set( FirebaseAuth.instance.currentUser!.uid);
    _refIntern.child(FirebaseAuth.instance.currentUser!.uid).child("count").set(1);
    return 1;
  }
}

Future<int> getCountIntern () async {

  DataSnapshot _snpShot = await _refIntern.child(FirebaseAuth.instance.currentUser!.uid).child("count").once();

  if(_snpShot.value!=null) {
    final snapshot = await _refIntern.child(FirebaseAuth.instance.currentUser!.uid).child("count").once();
    int value = snapshot.value + 1;
    return value;
  }
  else{
    _refIntern.set( FirebaseAuth.instance.currentUser!.uid);
    _refIntern.child(FirebaseAuth.instance.currentUser!.uid).child("count").set(1);
    return 1;
  }
}

Future<int> getAndSaveCountExtern () async {

  DataSnapshot _snpShot = await _refExtern.child(FirebaseAuth.instance.currentUser!.uid).child("count").once();

  if(_snpShot.value!=null) {
    final snapshot = await _refExtern.child(FirebaseAuth.instance.currentUser!.uid).child("count").once();
    int value = snapshot.value + 1;
    _refExtern.child(FirebaseAuth.instance.currentUser!.uid).child("count").set(value);
    return value;
  }
  else{
    _refExtern.set( FirebaseAuth.instance.currentUser!.uid);
    _refExtern.child(FirebaseAuth.instance.currentUser!.uid).child("count").set(1);
    return 1;
  }
}