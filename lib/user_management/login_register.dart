import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:simple_nav_bar/user_management/register.dart';
import 'package:simple_nav_bar/user_management/login.dart';
import 'package:simple_nav_bar/themes.dart';

import '../nav.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(LoginRegister());
}

class LoginRegister extends StatefulWidget {
  LoginRegister({Key? key}) : super(key: key);

  @override
  _LoginRegisterState createState() => _LoginRegisterState();
}

class _LoginRegisterState extends State<LoginRegister> {

  @override
  void initState() {
    super.initState();
    currentTheme.addListener(() {
      if(this.mounted) { // check whether the state object is in tree
        setState(() {
          print("LoginRegister Widget");
        });
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LoginRegisterPage(),
      debugShowCheckedModeBanner: false,
      theme: CustomTheme.lightTheme,
      darkTheme: CustomTheme.darkTheme,
      themeMode: currentTheme.currentTheme,
    );
  }
}


class LoginRegisterPage extends StatefulWidget {

  @override
  _LoginRegisterPageState createState() => _LoginRegisterPageState();

}

class _LoginRegisterPageState extends State<LoginRegisterPage> {

  //logged out is set to false, so the white screen is shown first, after checkUser() it will show login/register screen
  bool _isLoggedOut = false;

  @override
  void initState() {
    print("LoginRegister is loaded" + _isLoggedOut.toString());
    // TODO: implement initState
    super.initState();
    setState(() {
      Firebase.initializeApp().whenComplete(() => checkUser()).whenComplete(() => refreshPage());
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  void refreshPage(){
    setState(() {});
  }

  void checkUser() {
    FirebaseAuth.instance
        .authStateChanges()
        .listen((User? user) {
      if (user == null) {
        print('User is currently signed out!');
        _isLoggedOut = true;
      } else {
        _isLoggedOut = false;
        print('User is signed in!');
        print(user.uid.toString());
        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => Nav()),(route) => false,);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.backgroundColor,
      body: Center(
        child: (_isLoggedOut)
        //if user is logged out, this will be shown
            ? FittedBox(
                fit: BoxFit.fitHeight,
                alignment: Alignment.center,
                child: Container(
                  padding: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.05),
                  width: MediaQuery.of(context).size.width*1,
                  height: MediaQuery.of(context).size.height*1,
                  child: Center(
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(bottom: MediaQuery.of(context).size.height*0.10),
                          child: Container(
                            width: MediaQuery.of(context).size.width*0.9,
                            child: Align(
                              alignment: Alignment.topLeft,
                              child: IconButton(
                                color: theme.iconTheme.color,
                                icon: const Icon(
                                  Icons.brightness_4_rounded,
                                ),
                                onPressed: () {
                                  setState(() {
                                    currentTheme.toggleTheme();
                                  });
                                },
                              ),
                            ),
                          ),
                        ),
                        Container(
                          height: MediaQuery.of(context).size.height*0.2,
                          width: MediaQuery.of(context).size.width*0.5,
                          child: Image.asset(
                            theme.backgroundColor == Colors.white
                                ? 'assets/logo_black_login.png'
                                : 'assets/logo_white_login.png',
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.1),
                          child: SizedBox(
                            height: MediaQuery.of(context).size.height*0.06,
                            width: MediaQuery.of(context).size.width*0.7,
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    primary: theme.cardColor,
                                    fixedSize: Size.fromHeight(50),
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                                    textStyle: TextStyle(
                                      fontSize: MediaQuery.of(context).size.height*0.03,
                                    )
                                ),
                                onPressed: (){
                                  Navigator.push(context,MaterialPageRoute(builder: (context) => LoginForm()),);
                                },
                                child: Text(
                                  "Login",
                                  style: theme.textTheme.bodyText1,
                                )
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.05),
                          child: SizedBox(
                            height: MediaQuery.of(context).size.height*0.06,
                            width: MediaQuery.of(context).size.width*0.7,
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    primary: theme.cardColor,
                                    fixedSize: Size.fromHeight(50),
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                                    textStyle: TextStyle(
                                        fontSize: MediaQuery.of(context).size.height*0.03
                                    )
                                ),
                                onPressed: (){
                                  Navigator.push(context,MaterialPageRoute(builder: (context) => RegisterForm()),);
                                },
                                child: Text(
                                  "Register",
                                  style: theme.textTheme.bodyText1,
                                )
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.2),
                          child: Container(
                            height: MediaQuery.of(context).size.height*0.06,
                            width: MediaQuery.of(context).size.width*0.5,
                            child: Image.asset(
                              theme.backgroundColor == Colors.white
                                  ? 'assets/rocomp_black.png'
                                  : 'assets/rocomp_white.png',
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
            )
            : FittedBox(
                fit: BoxFit.fitHeight,
                alignment: Alignment.center,
                child: Container(
                  padding: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.05),
                  width: MediaQuery.of(context).size.width*1,
                  height: MediaQuery.of(context).size.height*1,
                  color: theme.backgroundColor,
                ),
            )
      ),
    );

  }
}