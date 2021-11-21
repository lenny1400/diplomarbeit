import 'dart:ffi';

import 'package:simple_nav_bar/user_startup/user_customer.dart';

class User_task{
  String name;
  bool Anfahrt;
  late int km;
  User_customer customer;
  String time;
  String text;
  String material;

  User_task(this.name, this.Anfahrt, this.customer,this.time,this.text,this.material);
}