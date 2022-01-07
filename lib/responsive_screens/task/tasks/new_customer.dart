import 'dart:io';

import 'package:csv/csv.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:path_provider/path_provider.dart';
import 'package:simple_nav_bar/responsive_screens/task/tasks/existing_customer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../themes.dart';
import 'existing_customer.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(NewCustomer());
}

class NewCustomer extends StatefulWidget {
  const NewCustomer({Key? key}) : super(key: key);

  @override
  _NewCustomerState createState() => _NewCustomerState();
}

class _NewCustomerState extends State<NewCustomer> {

  @override
  void initState() {
    super.initState();
    currentTheme.addListener(() {
      if (this.mounted) { // check whether the state object is in tree
        setState(() {
          // make changes here
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: NewCustomerPage(title: 'New Customer'),
      title: 'Flutter Theme Demo',
      routes: {
        '/existing_cust': (context) => ExistingCustomerPage(title: 'Existing Customer', pop: 0),
      },
      debugShowCheckedModeBanner: false,
      theme: CustomTheme.lightTheme,
      darkTheme: CustomTheme.darkTheme,
      themeMode: currentTheme.currentTheme,
    );
  }
}

class NewCustomerPage extends StatefulWidget {
  const NewCustomerPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _NewCustomerPageState createState() => _NewCustomerPageState();
}

class _NewCustomerPageState extends State<NewCustomerPage> {

  final myControllerCompany = TextEditingController();
  final myControllerFirstName = TextEditingController();
  final myControllerLastName = TextEditingController();
  final myControllerStreet = TextEditingController();
  final myControllerStreetNr = TextEditingController();
  final myControllerProvince = TextEditingController();
  final myControllerZipCode = TextEditingController();
  final myControllerCountry = TextEditingController();
  final myControllerPhone = TextEditingController();
  final myControllerEmail = TextEditingController();
  final myControllerFax = TextEditingController();
  final myControllerNumber = TextEditingController();
  final myControllerTitle = TextEditingController();

   bool customerexists = false;

  String errorText = "";
  Color errorTextColor = Colors.red;

  //Saving File to Storage
  Future<void> saveToStorage() async {
    final _company = myControllerCompany.text;
    final _firstname = myControllerFirstName.text;
    final _lastname = myControllerLastName.text;
    final _street = myControllerStreet.text;
    final _streetnr = myControllerStreetNr.text;
    final _province= myControllerProvince.text;
    final _zipcode = myControllerZipCode.text;
    final _country = myControllerCountry.text;
    final _email = myControllerPhone.text;
    final _phone = myControllerEmail.text;
    final _fax = myControllerFax.text;
    final _title = myControllerTitle.text;
    final _number = myControllerNumber.text;

    String user = FirebaseAuth.instance.currentUser!.uid;

    Directory? directory = await getApplicationDocumentsDirectory();

    String path = directory.path;

    String input = await File('$path/User/$user/Customer/Customer.csv').readAsString();

    input += "\r\n" + _company+";" + _number +";" + _title +";" +_firstname + ";"+_lastname + ";"+_street+ ";"+_streetnr+ ";"+_country+ ";"+_zipcode+ ";"+_province+ ";"+_phone+ ";"+_fax+ ";"+_email+ ";"+_number;

    await File('$path/User/$user/Customer/Customer.csv').writeAsString(input);

    setState(() {});
  }

  Future<void> checkCustomerexists() async{

    String user = FirebaseAuth.instance.currentUser!.uid;

    Directory? directory = await getApplicationDocumentsDirectory();

    String path = directory.path;

    await Directory('$path/User/$user/Customer/').create(recursive: true);

    String csv1 = await File('$path/User/$user/Customer/Customer.csv').readAsString();

    var list1 = const CsvToListConverter().convert(csv1);


    bool test = true;

    for(int i = 0; i<list1.length; i++){
      List<String> elems = list1[i].toString().split(";");
      if(i != 0){
        if(elems[0].split("[")[1] == myControllerCompany.text){
          errorText = "Kunde mit diesem Name existert bereits";
          test = false;
          break;
        }
      }
    }
    if(test){
      customerexists = true;
      errorText = "Data is Okay";
    }

    setState(() {});
  }

  @override
  void dispose() {
    myControllerCompany.dispose();
    myControllerFirstName.dispose();
    myControllerLastName.dispose();
    myControllerStreet.dispose();
    myControllerStreetNr.dispose();
    myControllerProvince.dispose();
    myControllerZipCode.dispose();
    myControllerCountry.dispose();
    myControllerTitle.dispose();
    myControllerNumber.dispose();
    myControllerFax.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final mdHeight = MediaQuery.of(context).size.height*1;
    final mdWidth = MediaQuery.of(context).size.width*1;
    //constant
    final boxHeight = mdHeight*0.065;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: theme.backgroundColor,
      appBar: AppBar(
        title: Text(widget.title,
          style: theme.textTheme.headline6,
        ),
        elevation: 0,
      ),
      body: Center(
        child: FittedBox(
          fit: BoxFit.fitHeight,
          alignment: Alignment.center,
          child: Container(
            width: mdWidth,
            height: mdHeight,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(top: mdHeight*0.085),
                  child: Container(
                      width: mdWidth,
                      height: boxHeight,
                      child: Align(
                          alignment: Alignment.centerLeft,
                          child: TextField(
                            controller: myControllerCompany,
                            textAlign: TextAlign.left,
                            maxLines: 1,
                            style: TextStyle(
                              color: theme.dividerColor,
                            ),
                            decoration: InputDecoration(
                                contentPadding: EdgeInsets.only(top: 15,left: 20,bottom: 10),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                  borderSide: BorderSide(color: theme.dividerColor),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                  borderSide: BorderSide(color: theme.dividerColor),
                                ),
                                labelText: "Company Name",
                                labelStyle: TextStyle(
                                    color: theme.dividerColor
                                ),
                                hintText: "Enter company name"
                            ),
                          )
                      )
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: mdHeight*0.02),
                  child: Container(
                    width: mdWidth,
                    height: boxHeight,
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Row(
                        children: <Widget>[
                          Container(
                            width: mdWidth*0.65,
                            child: TextField(
                              controller: myControllerNumber,
                              textAlign: TextAlign.left,
                              maxLines: 1,
                              style: TextStyle(
                                color: theme.dividerColor,
                              ),
                              decoration: InputDecoration(
                                  contentPadding: EdgeInsets.only(top: 15,left: 20,bottom: 10),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                    borderSide: BorderSide(color: theme.dividerColor),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                    borderSide: BorderSide(color: theme.dividerColor),
                                  ),
                                  labelText: "Customer Number",
                                  labelStyle: TextStyle(
                                      color: theme.dividerColor
                                  ),
                                  hintText: "Enter Customer Number"
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: mdWidth*0.05),
                            child: Container(
                              width: mdWidth*0.3,
                              child: TextField(
                                controller: myControllerTitle,
                                textAlign: TextAlign.center,
                                maxLines: 1,
                                style: TextStyle(
                                  color: theme.dividerColor,
                                ),
                                decoration: InputDecoration(
                                    contentPadding: EdgeInsets.all(15),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                      borderSide: BorderSide(color: theme.dividerColor),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                      borderSide: BorderSide(color: theme.dividerColor),
                                    ),
                                    labelText: "Title",
                                    labelStyle: TextStyle(
                                        color: theme.dividerColor
                                    ),
                                    hintText: "Title"
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: mdHeight*0.02),
                  child: Container(
                      width: mdWidth,
                      height: boxHeight,
                      child: Align(
                          alignment: Alignment.centerLeft,
                          child: TextField(
                            controller: myControllerFirstName,
                            textAlign: TextAlign.left,
                            maxLines: 1,
                            style: TextStyle(
                              color: theme.dividerColor,
                            ),
                            decoration: InputDecoration(
                                contentPadding: EdgeInsets.only(top: 15,left: 20,bottom: 10),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                  borderSide: BorderSide(color: theme.dividerColor),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                  borderSide: BorderSide(color: theme.dividerColor),
                                ),
                                labelText: "Firstname",
                                labelStyle: TextStyle(
                                    color: theme.dividerColor
                                ),
                                hintText: "Enter first name"
                            ),
                          )
                      )
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: mdHeight*0.02),
                  child: Container(
                      width: mdWidth,
                      height: boxHeight,
                      child: Align(
                          alignment: Alignment.centerLeft,
                          child: TextField(
                            controller: myControllerLastName,
                            textAlign: TextAlign.left,
                            maxLines: 1,
                            style: TextStyle(
                              color: theme.dividerColor,
                            ),
                            decoration: InputDecoration(
                                contentPadding: EdgeInsets.only(top: 15,left: 20,bottom: 10),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                  borderSide: BorderSide(color: theme.dividerColor),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                  borderSide: BorderSide(color: theme.dividerColor),
                                ),
                                labelText: "Lastname",
                                labelStyle: TextStyle(
                                    color: theme.dividerColor
                                ),
                                hintText: "Enter last name"
                            ),
                          )
                      )
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: mdHeight*0.02),
                  child: Container(
                    width: mdWidth,
                    height: boxHeight,
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Row(
                        children: <Widget>[
                          Container(
                            width: mdWidth*0.75,
                            child: TextField(
                              controller: myControllerStreet,
                              textAlign: TextAlign.left,
                              maxLines: 1,
                              style: TextStyle(
                                color: theme.dividerColor,
                              ),
                              decoration: InputDecoration(
                                  contentPadding: EdgeInsets.only(top: 15,left: 20,bottom: 10),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                    borderSide: BorderSide(color: theme.dividerColor),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                    borderSide: BorderSide(color: theme.dividerColor),
                                  ),
                                  labelText: "Street",
                                  labelStyle: TextStyle(
                                      color: theme.dividerColor
                                  ),
                                  hintText: "Enter street name"
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: mdWidth*0.05),
                            child: Container(
                              width: mdWidth*0.2,
                              child: TextField(
                                controller: myControllerStreetNr,
                                textAlign: TextAlign.center,
                                maxLines: 1,
                                style: TextStyle(
                                  color: theme.dividerColor,
                                ),
                                decoration: InputDecoration(
                                    contentPadding: EdgeInsets.all(15),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                      borderSide: BorderSide(color: theme.dividerColor),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                      borderSide: BorderSide(color: theme.dividerColor),
                                    ),
                                    labelText: "Nr",
                                    labelStyle: TextStyle(
                                        color: theme.dividerColor
                                    ),
                                    hintText: "Nr"
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: mdHeight*0.02),
                  child: Container(
                    width: mdWidth,
                    height: boxHeight,
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Row(
                        children: <Widget>[
                          Container(
                            width: mdWidth*0.65,
                            child: TextField(
                              controller: myControllerProvince,
                              textAlign: TextAlign.left,
                              maxLines: 1,
                              style: TextStyle(
                                color: theme.dividerColor,
                              ),
                              decoration: InputDecoration(
                                  contentPadding: EdgeInsets.only(top: 15,left: 20,bottom: 10),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                    borderSide: BorderSide(color: theme.dividerColor),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                    borderSide: BorderSide(color: theme.dividerColor),
                                  ),
                                  labelText: "Province",
                                  labelStyle: TextStyle(
                                      color: theme.dividerColor
                                  ),
                                  hintText: "Enter province name"
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: mdWidth*0.05),
                            child: Container(
                              width: mdWidth*0.3,
                              child: TextField(
                                inputFormatters: <TextInputFormatter>[
                                  FilteringTextInputFormatter.digitsOnly
                                ],
                                controller: myControllerZipCode,
                                textAlign: TextAlign.left,
                                maxLines: 1,
                                style: TextStyle(
                                  color: theme.dividerColor,
                                ),
                                decoration: InputDecoration(
                                    contentPadding: EdgeInsets.all(15),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                      borderSide: BorderSide(color: theme.dividerColor),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                      borderSide: BorderSide(color: theme.dividerColor),
                                    ),
                                    labelText: "Zip Code",
                                    labelStyle: TextStyle(
                                        color: theme.dividerColor
                                    ),
                                    hintText: "Zip"
                                ),
                              ),
                            ),
                          ),

                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: mdHeight*0.02),
                  child: Container(
                      width: mdWidth,
                      height: boxHeight,
                      child: Align(
                          alignment: Alignment.centerLeft,
                          child: TextField(
                            controller: myControllerCountry,
                            textAlign: TextAlign.left,
                            maxLines: 1,
                            style: TextStyle(
                              color: theme.dividerColor,
                            ),
                            decoration: InputDecoration(
                                contentPadding: EdgeInsets.only(top: 15,left: 20,bottom: 10),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                  borderSide: BorderSide(color: theme.dividerColor),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                  borderSide: BorderSide(color: theme.dividerColor),
                                ),
                                labelText: "Country",
                                labelStyle: TextStyle(
                                    color: theme.dividerColor
                                ),
                                hintText: "Enter country"
                            ),
                          )
                      )
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: mdHeight*0.02),
                  child: Container(
                      width: mdWidth,
                      height: boxHeight,
                      child: Align(
                          alignment: Alignment.centerLeft,
                          child: TextField(
                            controller: myControllerPhone,
                            keyboardType: TextInputType.number,
                            textAlign: TextAlign.left,
                            maxLines: 1,
                            style: TextStyle(
                              color: theme.dividerColor,
                            ),
                            decoration: InputDecoration(
                                contentPadding: EdgeInsets.only(top: 15,left: 20,bottom: 10),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                  borderSide: BorderSide(color: theme.dividerColor),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                  borderSide: BorderSide(color: theme.dividerColor),
                                ),
                                labelText: "Phone Number",
                                labelStyle: TextStyle(
                                    color: theme.dividerColor
                                ),
                                hintText: "Enter phone number"
                            ),
                          )
                      )
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: mdHeight*0.02),
                  child: Container(
                      width: mdWidth,
                      height: boxHeight,
                      child: Align(
                          alignment: Alignment.centerLeft,
                          child: TextField(
                            controller: myControllerEmail,
                            textAlign: TextAlign.left,
                            maxLines: 1,
                            style: TextStyle(
                              color: theme.dividerColor,
                            ),
                            decoration: InputDecoration(
                                contentPadding: EdgeInsets.only(top: 15,left: 20,bottom: 10),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                  borderSide: BorderSide(color: theme.dividerColor),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                  borderSide: BorderSide(color: theme.dividerColor),
                                ),
                                labelText: "Email",
                                labelStyle: TextStyle(
                                    color: theme.dividerColor
                                ),
                                hintText: "Enter email address"
                            ),
                          )
                      )
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: mdHeight*0.02),
                  child: Container(
                      width: mdWidth,
                      height: boxHeight,
                      child: Align(
                          alignment: Alignment.centerLeft,
                          child: TextField(
                            controller: myControllerFax,
                            textAlign: TextAlign.left,
                            maxLines: 1,
                            style: TextStyle(
                              color: theme.dividerColor,
                            ),
                            decoration: InputDecoration(
                                contentPadding: EdgeInsets.only(top: 15,left: 20,bottom: 10),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                  borderSide: BorderSide(color: theme.dividerColor),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                  borderSide: BorderSide(color: theme.dividerColor),
                                ),
                                labelText: "Fax",
                                labelStyle: TextStyle(
                                    color: theme.dividerColor
                                ),
                                hintText: "Enter Fax number"
                            ),
                          )
                      )
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: mdHeight*0.02),
                  child: Container(
                    child: Align(
                        alignment: Alignment.center,
                        child: (customerexists)
                            ? Align(
                                alignment: Alignment.center,
                                child: Text(
                                  errorText,
                                  style: TextStyle(
                                    color: Colors.green.shade500,
                                    fontSize: 17,
                                  ),
                                ),
                              )
                            : Align(
                                alignment: Alignment.center,
                                child: Text(
                                  errorText,
                                  style: TextStyle(
                                    color: Colors.red,
                                    fontSize: 17,
                                  ),
                                ),
                              )
                    ),
                  ),
                ),
              ],
            ),
          ),
        )
      ),
        floatingActionButton: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10,right: 10,bottom: 10),
                child: Container(
                  height: mdHeight*0.07,
                  width: mdHeight*0.07,
                  child: (customerexists)
                    ? FloatingActionButton(
                      backgroundColor: theme.cardColor,
                      child: Icon(
                        Icons.save,
                        color: theme.primaryColor,
                        size: mdHeight*0.07/2,
                      ),
                      onPressed: () {
                          saveToStorage();
                          Navigator.pop(context);
                      },
                      heroTag: "ChecknSave",
                    )
                  : FloatingActionButton(
                      backgroundColor: theme.cardColor,
                      child: Icon(
                        Icons.check,
                        color: theme.primaryColor,
                        size: mdHeight*0.07/2,
                      ),
                      onPressed: () {
                        checkCustomerexists();
                      },
                      heroTag: "ChecknSave",
                      ),
                ),
              )
            ]
        )
    );
  }
}
