import 'package:simple_nav_bar/screens/task/tasks/existing_customer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../themes.dart';

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
  String btnText = "Save";
  Color _isEverythingOkayColor = Colors.red;

  void controllTextCompany(){
    setState(() {
      if(myControllerCompany.text.isEmpty){
        errorText = "Company can't be empty";
        btnText = "Save";
        print(myControllerCompany.text);
        _isEverythingOkayColor = Colors.red;
      }else{
        _validateCompany = true;
        print(myControllerCompany.text);
      }
    });
  }

  void controllTextFirstName(){
    setState(() {
      if(myControllerFirstName.text.isEmpty){
        errorText = "First Name can't be empty";
        btnText = "Save";
        _isEverythingOkayColor = Colors.red;
        print(myControllerFirstName.text);
      }else{
        _validateFirstName = true;
        print(myControllerFirstName.text);
      }
    });
  }

  void controllTextLastName(){
    setState(() {
      if(myControllerLastName.text.isEmpty){
        errorText = "Last Name can't be empty";
        print(myControllerLastName.text);
        _isEverythingOkayColor = Colors.red;
        btnText = "Save";
      }else{
        _validateLastName = true;
        print(myControllerLastName.text);
      }
    });
  }

  void controllTextStreet(){
    setState(() {
      if(myControllerStreet.text.isEmpty){
        errorText = "Street can't be empty";
        _isEverythingOkayColor = Colors.red;
        print(myControllerStreet.text);
        btnText = "Save";
      }else{
        _validateStreet = true;
        print(myControllerStreet.text);
      }
    });
  }

  void controllTextStreetNr(){
    setState(() {
      if(myControllerStreetNr.text.isEmpty){
        errorText = "Street Nr can't be empty";
        _isEverythingOkayColor = Colors.red;
        print(myControllerStreetNr.text);
        btnText = "Save";
      }else{
        _validateStreetNr = true;
        print(myControllerStreetNr.text);
      }
    });
  }

  void controllTextProvince(){
    setState(() {
      if(myControllerProvince.text.isEmpty){
        errorText = "Province can't be empty";
        btnText = "Save";
        _isEverythingOkayColor = Colors.red;
        print(myControllerProvince.text);
      }else{
        _validateProvince = true;
        print(myControllerProvince.text);
      }
    });
  }

  void controllTextZipCode(){
    setState(() {
      if(myControllerZipCode.text.isEmpty){
        errorText = "ZipCode can't be empty";
        btnText = "Save";
        _isEverythingOkayColor = Colors.red;
        print(myControllerZipCode.text);
      }else{
        _validateZipCode = true;
        print(myControllerZipCode.text);
      }
    });
  }

  void controllTextCountry(){
    setState(() {
      if(myControllerCountry.text.isEmpty){
        errorText = "Country can't be empty";
        btnText = "Save";
        _isEverythingOkayColor = Colors.red;
        print(myControllerCountry.text);
      }else{
        _validateCountry = true;
        print(myControllerCountry.text);
      }
    });
  }

  void controllEverything(){
    setState(() {
      if(_validateCompany && _validateFirstName && _validateLastName && _validateStreet && _validateStreetNr && _validateProvince && _validateZipCode && _validateCountry){
        errorText = "Perfect";
        btnText = "Next";
        _isEverythingOkay = true;
        _isEverythingOkayColor = Colors.green;
        int pop = 2;
        Navigator.push(context, MaterialPageRoute(builder: (_) => ExistingCustomerPage(title: 'New Customer', pop: pop)));
      }
    });
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
            width: MediaQuery.of(context).size.width*1,
            height: MediaQuery.of(context).size.height*1,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height: MediaQuery.of(context).size.height*0.1,
                ),
                Container(
                    width: MediaQuery.of(context).size.width*0.97,
                    height: MediaQuery.of(context).size.height*0.05,
                    child: Padding(
                      padding: EdgeInsets.only(left: 20),
                      child: Align(
                          alignment: Alignment.centerLeft,
                          child: TextField(
                            controller: myControllerCompany,
                            textAlign: TextAlign.left,
                            maxLines: 1,
                            style: TextStyle(
                              color: theme.accentColor,
                            ),
                            decoration: InputDecoration(
                                contentPadding: EdgeInsets.only(top: 15,left: 20,bottom: 10),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                  borderSide: BorderSide(color: theme.accentColor),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                  borderSide: BorderSide(color: theme.accentColor),
                                ),
                                labelText: "Company Name*",
                                labelStyle: TextStyle(
                                    color: theme.accentColor
                                ),
                                hintText: "Enter company name"
                            ),
                          )
                      ),
                    )
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width*1,
                  height: MediaQuery.of(context).size.height*0.02,
                ),
                Container(
                    width: MediaQuery.of(context).size.width*0.6,
                    height: MediaQuery.of(context).size.height*0.05,
                    child: Padding(
                      padding: EdgeInsets.only(left: 20),
                      child: Align(
                          alignment: Alignment.centerLeft,
                          child: TextField(
                            controller: myControllerFirstName,
                            textAlign: TextAlign.left,
                            maxLines: 1,
                            style: TextStyle(
                              color: theme.accentColor,
                            ),
                            decoration: InputDecoration(
                                contentPadding: EdgeInsets.only(top: 15,left: 20,bottom: 10),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                  borderSide: BorderSide(color: theme.accentColor),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                  borderSide: BorderSide(color: theme.accentColor),
                                ),
                                labelText: "First Name*",
                                labelStyle: TextStyle(
                                    color: theme.accentColor
                                ),
                                hintText: "Enter first name"
                            ),
                          )
                      ),
                    )
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width*1,
                  height: MediaQuery.of(context).size.height*0.02,
                ),
                Container(
                    width: MediaQuery.of(context).size.width*0.6,
                    height: MediaQuery.of(context).size.height*0.05,
                    child: Padding(
                      padding: EdgeInsets.only(left: 20),
                      child: Align(
                          alignment: Alignment.centerLeft,
                          child: TextField(
                            controller: myControllerLastName,
                            textAlign: TextAlign.left,
                            maxLines: 1,
                            style: TextStyle(
                              color: theme.accentColor,
                            ),
                            decoration: InputDecoration(
                                contentPadding: EdgeInsets.only(top: 15,left: 20,bottom: 10),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                  borderSide: BorderSide(color: theme.accentColor),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                  borderSide: BorderSide(color: theme.accentColor),
                                ),
                                labelText: "Last Name*",
                                labelStyle: TextStyle(
                                    color: theme.accentColor
                                ),
                                hintText: "Enter last name"
                            ),
                          )
                      ),
                    )
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width*0.85,
                  height: MediaQuery.of(context).size.height*0.02,
                ),
                Container(
                  width: MediaQuery.of(context).size.width*1,
                  height: MediaQuery.of(context).size.height*0.05,
                  child: Padding(
                    padding: EdgeInsets.only(left: 20),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Row(
                        children: <Widget>[
                          Container(
                            width: MediaQuery.of(context).size.width*0.7,
                            child: TextField(
                              controller: myControllerStreet,
                              textAlign: TextAlign.left,
                              maxLines: 1,
                              style: TextStyle(
                                color: theme.accentColor,
                              ),
                              decoration: InputDecoration(
                                  contentPadding: EdgeInsets.only(top: 15,left: 20,bottom: 10),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                    borderSide: BorderSide(color: theme.accentColor),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                    borderSide: BorderSide(color: theme.accentColor),
                                  ),
                                  labelText: "Street*",
                                  labelStyle: TextStyle(
                                      color: theme.accentColor
                                  ),
                                  hintText: "Enter street name"
                              ),
                            ),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width*0.02,
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width*0.20,
                            child: TextField(
                              controller: myControllerStreetNr,
                              textAlign: TextAlign.center,
                              maxLines: 1,
                              style: TextStyle(
                                color: theme.accentColor,
                              ),
                              decoration: InputDecoration(
                                  contentPadding: EdgeInsets.all(15),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                    borderSide: BorderSide(color: theme.accentColor),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                    borderSide: BorderSide(color: theme.accentColor),
                                  ),
                                  labelText: "Nr*",
                                  labelStyle: TextStyle(
                                      color: theme.accentColor
                                  ),
                                  hintText: "Nr"
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width*0.85,
                  height: MediaQuery.of(context).size.height*0.02,
                ),
                Container(
                  width: MediaQuery.of(context).size.width*1,
                  height: MediaQuery.of(context).size.height*0.05,
                  child: Padding(
                    padding: EdgeInsets.only(left: 20),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Row(
                        children: <Widget>[
                          Container(
                            width: MediaQuery.of(context).size.width*0.6,
                            child: TextField(
                              controller: myControllerProvince,
                              textAlign: TextAlign.left,
                              maxLines: 1,
                              style: TextStyle(
                                color: theme.accentColor,
                              ),
                              decoration: InputDecoration(
                                  contentPadding: EdgeInsets.only(top: 15,left: 20,bottom: 10),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                    borderSide: BorderSide(color: theme.accentColor),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                    borderSide: BorderSide(color: theme.accentColor),
                                  ),
                                  labelText: "Province*",
                                  labelStyle: TextStyle(
                                      color: theme.accentColor
                                  ),
                                  hintText: "Enter province name"
                              ),
                            ),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width*0.02,
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width*0.3,
                            child: TextField(
                              inputFormatters: <TextInputFormatter>[
                                FilteringTextInputFormatter.digitsOnly
                              ],
                              controller: myControllerZipCode,
                              textAlign: TextAlign.left,
                              maxLines: 1,
                              style: TextStyle(
                                color: theme.accentColor,
                              ),
                              decoration: InputDecoration(
                                  contentPadding: EdgeInsets.all(15),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                    borderSide: BorderSide(color: theme.accentColor),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                    borderSide: BorderSide(color: theme.accentColor),
                                  ),
                                  labelText: "Zip Code*",
                                  labelStyle: TextStyle(
                                      color: theme.accentColor
                                  ),
                                  hintText: "Zip"
                              ),
                            ),
                          ),

                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width*0.85,
                  height: MediaQuery.of(context).size.height*0.02,
                ),
                Container(
                    width: MediaQuery.of(context).size.width*0.65,
                    height: MediaQuery.of(context).size.height*0.05,
                    child: Padding(
                      padding: EdgeInsets.only(left: 20),
                      child: Align(
                          alignment: Alignment.centerLeft,
                          child: TextField(
                            controller: myControllerCountry,
                            textAlign: TextAlign.left,
                            maxLines: 1,
                            style: TextStyle(
                              color: theme.accentColor,
                            ),
                            decoration: InputDecoration(
                                contentPadding: EdgeInsets.only(top: 15,left: 20,bottom: 10),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                  borderSide: BorderSide(color: theme.accentColor),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                  borderSide: BorderSide(color: theme.accentColor),
                                ),
                                labelText: "Country*",
                                labelStyle: TextStyle(
                                    color: theme.accentColor
                                ),
                                hintText: "Enter country"
                            ),
                          )
                      ),
                    )
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width*0.85,
                  height: MediaQuery.of(context).size.height*0.02,
                ),
                Container(
                    width: MediaQuery.of(context).size.width*0.65,
                    height: MediaQuery.of(context).size.height*0.05,
                    child: Padding(
                      padding: EdgeInsets.only(left: 20),
                      child: Align(
                          alignment: Alignment.centerLeft,
                          child: TextField(
                            keyboardType: TextInputType.number,
                            textAlign: TextAlign.left,
                            maxLines: 1,
                            style: TextStyle(
                              color: theme.accentColor,
                            ),
                            decoration: InputDecoration(
                                contentPadding: EdgeInsets.only(top: 15,left: 20,bottom: 10),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                  borderSide: BorderSide(color: theme.accentColor),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                  borderSide: BorderSide(color: theme.accentColor),
                                ),
                                labelText: "Phone Number",
                                labelStyle: TextStyle(
                                    color: theme.accentColor
                                ),
                                hintText: "Enter phone number"
                            ),
                          )
                      ),
                    )
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width*0.85,
                  height: MediaQuery.of(context).size.height*0.02,
                ),
                Container(
                    width: MediaQuery.of(context).size.width*0.97,
                    height: MediaQuery.of(context).size.height*0.05,
                    child: Padding(
                      padding: EdgeInsets.only(left: 20),
                      child: Align(
                          alignment: Alignment.centerLeft,
                          child: TextField(
                            textAlign: TextAlign.left,
                            maxLines: 1,
                            style: TextStyle(
                              color: theme.accentColor,
                            ),
                            decoration: InputDecoration(
                                contentPadding: EdgeInsets.only(top: 15,left: 20,bottom: 10),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                  borderSide: BorderSide(color: theme.accentColor),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                  borderSide: BorderSide(color: theme.accentColor),
                                ),
                                labelText: "Email",
                                labelStyle: TextStyle(
                                    color: theme.accentColor
                                ),
                                hintText: "Enter email address"
                            ),
                          )
                      ),
                    )
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width*0.95,
                  height: MediaQuery.of(context).size.height*0.13,
                ),
                Container(
                  child: Align(
                      alignment: Alignment.center,
                      child: (_isEverythingOkay)
                          ? Align(
                        alignment: Alignment.center,
                        child: Text(
                          errorText,
                          style: TextStyle(
                            color: _isEverythingOkayColor,
                            fontSize: 17,
                          ),
                        ),
                      )
                          : Align(
                        alignment: Alignment.center,
                        child: Text(
                          errorText,
                          style: TextStyle(
                            color: _isEverythingOkayColor,
                            fontSize: 17,
                          ),
                        ),
                      )
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width*0.85,
                  height: MediaQuery.of(context).size.height*0.02,
                ),
                Align(
                  alignment: Alignment.center,
                  child: Container(
                      height: MediaQuery.of(context).size.height*0.06,
                      width: MediaQuery.of(context).size.width*0.85,
                      child: Padding(
                        padding: EdgeInsets.all(0),
                        child: FloatingActionButton(
                          elevation: 0,
                          heroTag: "btnNewCustomer",
                          backgroundColor: theme.cardColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          ),
                          onPressed: () {
                            setState(() {
                              controllEverything();
                              controllTextCountry();
                              controllTextZipCode();
                              controllTextProvince();
                              controllTextStreetNr();
                              controllTextStreet();
                              controllTextLastName();
                              controllTextFirstName();
                              controllTextCompany();
                            });
                          },
                          child: Text(
                            btnText,
                            style: theme.textTheme.bodyText1,
                          ),
                        ),
                      )
                  ),
                )
              ],
            ),
          ),
        )
      ),
    );
  }
}
