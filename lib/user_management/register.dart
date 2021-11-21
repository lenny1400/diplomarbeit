import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:simple_nav_bar/themes.dart';
import 'package:simple_nav_bar/user_startup/startup.dart';

import '../nav.dart';
import 'login.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(RegisterForm());
}

class RegisterForm extends StatefulWidget {
  const RegisterForm({Key? key}) : super(key: key);

  @override
  _RegisterFormState createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {

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
      home: RegisterMainPage(),
      debugShowCheckedModeBanner: false,
      theme: CustomTheme.lightTheme,
      darkTheme: CustomTheme.darkTheme,
      themeMode: currentTheme.currentTheme,
    );
  }
}


class RegisterMainPage extends StatefulWidget {

  @override
  _RegisterMainPageState createState() => _RegisterMainPageState();
}

class _RegisterMainPageState extends State<RegisterMainPage> {

  TextEditingController myName = TextEditingController();
  TextEditingController myEmail = TextEditingController();
  TextEditingController myPassword = TextEditingController();
  TextEditingController myPasswordConfirm = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Firebase.initializeApp();
  }

  Future<void> registerUser(String _email, String _password) async {

    try {
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _email,
          password: _password
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
    isRegistered();
  }

  void isRegistered(){
    FirebaseAuth.instance
        .userChanges()
        .listen((User? user) {
      if (user == null) {
        print('User is currently signed out!');
      } else {
        print('User is signed in!');
        startUp(FirebaseAuth.instance.currentUser!.uid);
        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => Nav()),(route) => false,);
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.backgroundColor,
      resizeToAvoidBottomInset: false,
      body: Center(
        child: FittedBox(
          fit: BoxFit.fitHeight,
          child: Container(
            width: MediaQuery.of(context).size.width*1,
            height: MediaQuery.of(context).size.height*1,
            child: Center(
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.1),
                    child: Container(
                      height: MediaQuery.of(context).size.height*0.1,
                      child: Text(
                        "Register",
                        style: theme.textTheme.bodyText2,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.1,right: MediaQuery.of(context).size.width*0.1, top: MediaQuery.of(context).size.height*0.08 ),
                    child: Container(
                      width: MediaQuery.of(context).size.width*0.8,
                      height: MediaQuery.of(context).size.height*0.07,
                      child: TextField(
                        controller: myName,
                        style: TextStyle(
                          color: theme.shadowColor,
                        ),
                        decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(10.0)),
                              borderSide: BorderSide(color: theme.shadowColor),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(10.0)),
                              borderSide: BorderSide(color: theme.cardColor),
                            ),
                            labelText: 'Full Name',
                            labelStyle: TextStyle(
                                color: theme.shadowColor
                            ),
                            hintText: 'Enter your full name',
                            hintStyle: TextStyle(
                                color: theme.cardColor,
                                fontSize: MediaQuery.of(context).size.height*0.02
                            )
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.1,right: MediaQuery.of(context).size.width*0.1,top: MediaQuery.of(context).size.height*0.03),
                    child: Container(
                      width: MediaQuery.of(context).size.width*0.8,
                      height: MediaQuery.of(context).size.height*0.07,
                      child: TextField(
                        controller: myEmail,
                        style: TextStyle(
                          color: theme.shadowColor,
                        ),
                        decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(10.0)),
                              borderSide: BorderSide(color: theme.shadowColor),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(10.0)),
                              borderSide: BorderSide(color: theme.cardColor),
                            ),
                            labelText: 'Email',
                            labelStyle: TextStyle(
                                color: theme.shadowColor
                            ),
                            hintText: 'Enter valid mail',
                            hintStyle: TextStyle(
                                color: theme.cardColor,
                                fontSize: MediaQuery.of(context).size.height*0.02
                            )
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.1,right: MediaQuery.of(context).size.width*0.1, top: MediaQuery.of(context).size.height*0.03),
                    child: Container(
                      width: MediaQuery.of(context).size.width*0.8,
                      height: MediaQuery.of(context).size.height*0.07,
                      child: TextField(
                        controller: myPassword,
                        style: TextStyle(
                            color: theme.shadowColor
                        ),
                        obscureText: true,
                        decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(10.0)),
                              borderSide: BorderSide(color: theme.shadowColor),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(10.0)),
                              borderSide: BorderSide(color: theme.cardColor),
                            ),
                            labelText: 'Password',
                            labelStyle: TextStyle(
                                color: theme.shadowColor
                            ),
                            hintText: 'Enter your secure password',
                            hintStyle: TextStyle(
                                color: theme.cardColor,
                                fontSize: MediaQuery.of(context).size.height*0.02
                            )
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.1,right: MediaQuery.of(context).size.width*0.1,top: MediaQuery.of(context).size.height*0.03 ),
                    child: Container(
                      width: MediaQuery.of(context).size.width*0.8,
                      height: MediaQuery.of(context).size.height*0.07,
                      child: TextField(
                        controller: myPasswordConfirm,
                        style: TextStyle(
                            color: theme.shadowColor
                        ),
                        obscureText: true,
                        decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(10.0)),
                              borderSide: BorderSide(color: theme.shadowColor),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(10.0)),
                              borderSide: BorderSide(color: theme.cardColor),
                            ),
                            labelText: 'Confirm password',
                            labelStyle: TextStyle(
                                color: theme.shadowColor
                            ),
                            hintText: 'Enter your secure password',
                            hintStyle: TextStyle(
                                color: theme.cardColor,
                                fontSize: MediaQuery.of(context).size.height*0.02
                            )
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.06),
                    child: Container(
                      height: MediaQuery.of(context).size.height*0.06,
                      width: MediaQuery.of(context).size.width*0.5,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20)),
                      child: FloatingActionButton(
                        elevation: 0,
                        backgroundColor: theme.cardColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        onPressed: () {
                          if(myPassword.text == myPasswordConfirm.text){
                            registerUser(myEmail.text, myPasswordConfirm.text);
                          }
                        },
                        child: Text(
                          'Sign up',
                          style: theme.textTheme.bodyText1,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.15),
                    child: TextButton(
                      onPressed: (){
                        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => LoginForm()), (Route route) => true);
                      },
                      child: Text(
                        'Already have an Account?',
                        style: theme.textTheme.headline1,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}