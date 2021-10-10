import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:simple_nav_bar/screens/login/register.dart';
import 'package:simple_nav_bar/themes.dart';

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
      home: MainPage(title: 'Flutter Theme Demo'),
      title: 'Flutter Theme Demo',
      theme: CustomTheme.lightTheme,
      darkTheme: CustomTheme.darkTheme,
      themeMode: currentTheme.currentTheme,
    );
  }
}


class MainPage extends StatefulWidget {
  final String title;

  const MainPage({
    required this.title,
  });

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.backgroundColor,
      resizeToAvoidBottomInset: false,
      body: Center(
        child: FittedBox(
          fit: BoxFit.fitHeight,
          alignment: Alignment.center,
          child: Container(
            width: MediaQuery.of(context).size.width*1,
            height: MediaQuery.of(context).size.height*1,
            padding: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.1),
            child: Center(
              child: Column(
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height*0.1,
                      child: Text(
                        "Login",
                        style: theme.textTheme.bodyText2,
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height*0.07,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.1,right: MediaQuery.of(context).size.width*0.1 ),
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
                                color: theme.cardColor
                            )
                        ),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height*0.03,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.1,right: MediaQuery.of(context).size.width*0.1 ),
                      child: TextField(
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
                              color: theme.cardColor
                            )
                        ),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height*0.01,
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
                    SizedBox(
                      height: MediaQuery.of(context).size.height*0.01,
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height*0.055,
                      width: MediaQuery.of(context).size.width*0.5,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20)),
                      child: FloatingActionButton(
                        elevation: 0,
                        backgroundColor: theme.cardColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15.0)),
                        ),
                        onPressed: () {
                          // Navigator.push(
                          //     context, MaterialPageRoute(builder: (_) => MainPage(title: 'Hello',)));
                        },
                        child: Text(
                          'Sign in',
                          style: theme.textTheme.bodyText1,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height*0.3,
                    ),
                    TextButton(
                      onPressed: (){
                        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
                            RegisterForm()), (Route route) => true);
                      },
                      child: Text(
                        'Create Account',
                        style: theme.textTheme.headline2,
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