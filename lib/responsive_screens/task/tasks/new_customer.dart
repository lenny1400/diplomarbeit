import 'dart:io';

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

  bool _validateCompany = false;
  bool _validateFirstName = false;
  bool _validateLastName = false;
  bool _validateStreet = false;
  bool _validateStreetNr = false;
  bool _validateProvince = false;
  bool _validateZipCode = false;
  bool _validateCountry = false;

  bool _isEverythingOkay = false;

  String errorText = "";
  Color errorTextColor = Colors.red;

  void ctrlTxtFields(){
    final _company = myControllerCompany.text;
    final _firstname = myControllerFirstName.text;
    final _lastname = myControllerLastName.text;
    final _street = myControllerStreet.text;
    final _streetnr = myControllerStreetNr.text;
    final _province= myControllerProvince.text;
    final _zipcode = myControllerZipCode.text;
    final _country = myControllerCountry.text;

    //Country
    if(_country.isEmpty){
      _validateCountry = false;
      errorText = "Country cant be empty";
    }else{
      _validateCountry = true;
    }
    //ZipCode
    if(_zipcode.isEmpty){
      _validateZipCode = false;
      errorText = "Zip Code cant be empty";
    }else{
      _validateZipCode = true;
    }
    //Province
    if(_province.isEmpty){
      _validateProvince = false;
      errorText = "Province cant be empty";
    }else{
      _validateProvince = true;
    }
    //StreetNr
    if(_streetnr.isEmpty){
      _validateStreetNr = false;
      errorText = "Street Nr cant be empty";
    }else{
      _validateStreetNr = true;
    }
    //Street
    if(_street.isEmpty){
      _validateStreet = false;
      errorText = "Street cant be empty";
    }else{
      _validateStreet = true;
    }
    //Last Name
    if(_lastname.isEmpty){
      _validateLastName = false;
      errorText = "Last Name cant be empty";
    }else{
      _validateLastName = true;
    }
    //First Name
    if(_firstname.isEmpty){
      _validateFirstName = false;
      errorText = "Firstname cant be empty";
    }else{
      _validateFirstName = true;
    }
    //Company Name
    if(_company.isEmpty){
      _validateCompany = false;
      errorText = "Company cant be empty";
    }else{
      _validateCompany = true;
    }
    //check everything
    if(_validateCompany&&_validateFirstName&&_validateLastName&&_validateStreet&&_validateStreetNr&&_validateProvince&&_validateProvince&&_validateZipCode&&_validateCountry){
      _isEverythingOkay = true;
      errorText = "Data is Okay";
    }

    setState(() {});
  }


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

    String fileInput = formatFile(_company, _firstname, _lastname, _street, _streetnr, _province, _zipcode, _country, _email, _phone);
    String fileName = _lastname+"_"+_firstname+".csv";

    //get directory of Device
    final directory = await getApplicationDocumentsDirectory();
    // create path Year
    final _path= Directory(directory.path.toString() + "/Kunden");
    final _pathString = _path.path.toString();
    final _pathCustomer= File(_path.toString() + "/" + fileName);

    if ((await _path.exists())){
      if((await _pathCustomer.exists())){
        errorText = "Customer already exists";
        _isEverythingOkay = false;
        return null;
      }else{
        errorText = "Customer saved";
        _isEverythingOkay = true;
        final File file = File('$_pathString/$fileName');
        await file.writeAsString(fileInput);
      }
    }else{
      _path.create(recursive: true);
      if((await _pathCustomer.exists())){
        errorText = "Customer already exists";
        _isEverythingOkay = false;
        return null;
      }else{
        errorText = "Customer saved";
        _isEverythingOkay = true;
        final File file = File('$_pathString/$fileName');
        await file.writeAsString(fileInput);
      }
    }
    setState(() {});
  }

  String formatFile(String company, String fname, String lname, String street, String streetNr,String province, String zip, String country, String phone, String email){
    String output =
        "Company,Firstname,Lastname,Street,Street Nr,Province,Zip Code,Country,Email,Phone Nr\n" + "$company,$fname,$lname,$street,$streetNr,$province,$zip,$country,$phone,$email"
    ;

    return output;
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
                                labelText: "Company Name (required)",
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
                                labelText: "First Name (required)",
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
                                labelText: "Last Name (required)",
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
                                  labelText: "Street (required)",
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
                                    labelText: "Nr*",
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
                                  labelText: "Province (required)",
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
                                    labelText: "Zip Code*",
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
                                labelText: "Country (required)",
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
                    child: Align(
                        alignment: Alignment.center,
                        child: (_isEverythingOkay)
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
                padding: const EdgeInsets.only(right: 10,bottom: 10),
                child: Container(
                  height: mdHeight*0.07,
                  width: mdHeight*0.07,
                  child: (_isEverythingOkay)
                    ? FloatingActionButton(
                        backgroundColor: theme.cardColor,
                        child: Icon(
                          Icons.arrow_forward,
                          color: theme.primaryColor,
                          size: mdHeight*0.07/2,
                        ),
                        onPressed: () {},
                        heroTag: "Next",
                    )
                      : SizedBox(),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10,right: 10,bottom: 10),
                child: Container(
                  height: mdHeight*0.07,
                  width: mdHeight*0.07,
                  child: (_isEverythingOkay)
                    ? FloatingActionButton(
                      backgroundColor: theme.cardColor,
                      child: Icon(
                        Icons.save,
                        color: theme.primaryColor,
                        size: mdHeight*0.07/2,
                      ),
                      onPressed: () {
                          saveToStorage();
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
                        ctrlTxtFields();
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
