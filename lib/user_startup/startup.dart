// File to run when app is started

// check if directory is created {Tasks, Customers}+
// save user data {firstname, lastname} to save data (request to server)

import 'dart:io';

import 'package:csv/csv.dart';
import 'package:path_provider/path_provider.dart';

Future<void> startUp(String _uidUser)async {

  //get directory of Device
  final _directory = await getApplicationDocumentsDirectory();

  // create path ..app/User/xxx
  final _pathUser = Directory(_directory.path + "/User/$_uidUser");
  // create path ..app/User/Task/xxx
  final _pathTask = Directory(_directory.path + "/User/$_uidUser/tasks");
  // create path ..app/User/Customer/xxx
  final _pathCustomer = Directory(_directory.path + "/User/$_uidUser/Customer");
  final _pathCustomerPath = _directory.path + "/User/$_uidUser/Customer";
  //file Path
  final File _customerFile = File('$_pathCustomerPath/Customer.csv');

  List<List<dynamic>> csv = [];

  List<dynamic> header= [];
  
  header.add("kurzbez");
  header.add("kundnr");
  header.add("anrede");
  header.add("name1");
  header.add("name2");
  header.add("strasse");
  header.add("land");
  header.add("plz");
  header.add("ort");
  header.add("telefon1");
  header.add("faxnr1");
  header.add("email1");
  header.add("ktofibu");

  csv.add(header);

  String input = "kurzbez" + ";" + "kundnr" + ";" +"anrede" + ";" +"name1" + ";"+"name2" + ";"+"strasse" + ";"+"land" + ";"+"land" + ";"+"plz" + ";"+"ort" + ";"+"telefon1" + ";"+"faxnr1" + ";"+"email1" + ";"+"ktofibu";

  //String input = const ListToCsvConverter().convert(csv);
  
  final countpath = _pathUser.path +"/tasks/extern/count.txt";

  final File _countFile =  File(countpath);

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
    _customerFile.writeAsString(input);
  }

}