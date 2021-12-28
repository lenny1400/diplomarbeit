import 'package:firebase_auth/firebase_auth.dart';

class User_customer{

  String company;
  String number;
  String Anrede;
  String name1;
  late String name2;
  String street;
  String country;
  int zipcode;
  String province;
  String phone;
  String fax;
  String email;

  User_customer(this.company, this.number, this.Anrede, this.name1, this.street, this.country, this.zipcode, this.province, this.phone, this.fax, this.email);
}