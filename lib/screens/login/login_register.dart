import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:simple_nav_bar/screens/login/register.dart';
import 'package:simple_nav_bar/screens/login/login.dart';
import 'package:simple_nav_bar/themes.dart';

import '../../nav.dart';

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
          // make changes here
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LoginRegisterPage(),
      routes: {
        '/login': (context) => LoginForm(),
        '/register': (context) => RegisterForm(),
        '/nav': (context) => Nav(),
      },
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

  bool buildIt = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Firebase.initializeApp().whenComplete(() => checkUser());
  }

  void checkUser(){
    FirebaseAuth.instance
        .authStateChanges()
        .listen((User? user) {
      if (user == null) {
        print('User is currently signed out!');
        buildIt = false;
      } else {
        print('User is signed in!');
        print(user.uid.toString());
        Navigator.pushNamedAndRemoveUntil(context, '/nav', (Route<dynamic> route) => false);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.backgroundColor,
      body: Center(
        child: (buildIt)
            ? FittedBox(
                fit: BoxFit.fitHeight,
                alignment: Alignment.center,
                child: Container(
                  padding: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.05),
                  width: MediaQuery.of(context).size.width*1,
                  height: MediaQuery.of(context).size.height*1,
                  color: theme.primaryColor,
          ),
        )
            : FittedBox(
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
                                  Navigator.pushNamed(context,'/login');
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
                                  Navigator.pushNamed(context,'/register');
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
      ),
    );

  }
}