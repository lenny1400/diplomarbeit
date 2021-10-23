import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:simple_nav_bar/nav.dart';
import 'package:simple_nav_bar/screens/login/register.dart';
import 'package:simple_nav_bar/themes.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(LoginForm());
}

class LoginForm extends StatefulWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {

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
      home: MainPage(),
      debugShowCheckedModeBanner: false,
      theme: CustomTheme.lightTheme,
      darkTheme: CustomTheme.darkTheme,
      themeMode: currentTheme.currentTheme,
    );
  }
}


class MainPage extends StatefulWidget {

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {

  final myEmail = TextEditingController();
  final myPassword = TextEditingController();

  Future<void> loginUser(String _email, String _password) async {

    try {
      UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _email,
          password: _password
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
    isSignedin();
  }

  void isSignedin(){
    FirebaseAuth.instance
        .authStateChanges()
        .listen((User? user) {
      if (user == null) {
        print('User is currently signed out!');
      } else {
        print('User is signed in!');
        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => Nav()),(route) => false,);
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Firebase.initializeApp();
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
            padding: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.1),
            child: Center(
              child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.07),
                      child: Container(
                        height: MediaQuery.of(context).size.height*0.1,
                        child: Text(
                          "Login",
                          style: theme.textTheme.bodyText2,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.1,right: MediaQuery.of(context).size.width*0.1,top: MediaQuery.of(context).size.height*0.1 ),
                      child: Container(
                        width: MediaQuery.of(context).size.width*0.8,
                        height: MediaQuery.of(context).size.height*0.07,
                        child: TextField(
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
                          controller: myEmail,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.1,right: MediaQuery.of(context).size.width*0.1, top: MediaQuery.of(context).size.height*0.03 ),
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
                                  color: theme.shadowColor,
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
                    TextButton(
                      onPressed: (){
                        //TODO FORGOT PASSWORD SCREEN GOES HERE
                      },
                      child: Text(
                        'Forgot Password',
                        style: theme.textTheme.headline1,
                      ),
                    ),
                    Container(
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
                          print(myEmail.text);
                          print(myPassword.text);
                          loginUser(myEmail.text,myPassword.text);
                        },
                        child: Text(
                          'Sign in',
                          style: theme.textTheme.bodyText1,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.2),
                      child: TextButton(
                        onPressed: (){
                          Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
                              RegisterForm()), (Route route) => true);
                        },
                        child: Text(
                          'Create Account',
                          style: theme.textTheme.headline1,
                        ),
                      ),
                    ),
                  ],
                ),
            )
          ),
        ),
      ),
    );
  }
}