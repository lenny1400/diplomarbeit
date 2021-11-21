// File to run when app is started

// check if directory is created {Tasks, Customers}+
// save user data {firstname, lastname} to save data (request to server)

import 'dart:io';

import 'package:path_provider/path_provider.dart';

Future<void> startUp(String _uidUser)async {

  //get directory of Device
  final _directory = await getApplicationDocumentsDirectory();

  // create path ..app/User/xxx
  final _pathUser = Directory(_directory.path + "/User/$_uidUser");
  // create path ..app/User/Task/xxx
  final _pathTask = Directory(_directory.path + "/User/$_uidUser/Tasks");
  // create path ..app/User/Customer/xxx
  final _pathCustomer = Directory(_directory.path + "/User/$_uidUser/Customer");
  final _pathCustomerPath = _directory.path + "/User/$_uidUser/Customer";
  //file Path
  final File _customerFile = File('$_pathCustomerPath/Customer.csv');

  if ((await _pathUser.exists())){
    print("user already exists");
  }else{
    await _pathUser.create(recursive: true);
  }

  if ((await _pathTask.exists())){
    print("Task Path already exists");
  }else{
    await _pathTask.create(recursive: true);
  }

  if ((await _pathCustomer.exists())){
    print("CustomerPath already exists");
  }else{
    await _pathCustomer.create(recursive: true);
  }

  if ((await _customerFile.exists())){
    print("CustomerPath already exists");
  }else{
    await _customerFile.create(recursive: true);
  }
}