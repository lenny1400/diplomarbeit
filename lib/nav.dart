import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:simple_nav_bar/main_screens/home_screen.dart';
import 'package:simple_nav_bar/main_screens/task_screen.dart';
import 'package:simple_nav_bar/main_screens/time_screen.dart';
import 'package:simple_nav_bar/user_management/login_register.dart';

import 'main_screens/data_screen.dart';
import 'package:simple_nav_bar/themes.dart';

Future main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(Nav());
}

class Nav extends StatefulWidget {
  @override
  _NavState createState() => _NavState();
}

class _NavState extends State<Nav> {

  @override
  void initState() {
    super.initState();
    currentTheme.addListener(() {
      if (this.mounted) { // check whether the state object is in tree
        setState(() {
          // make changes here "New"
        });
      }
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    LoginRegister();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Navbar(),
      title: 'Flutter Theme Demo',
      debugShowCheckedModeBanner: false,
      theme: CustomTheme.lightTheme,
      darkTheme: CustomTheme.darkTheme,
      themeMode: currentTheme.currentTheme,
    );
  }

}

class Navbar extends StatefulWidget {
  const Navbar({Key? key}) : super(key: key);

  @override
  _NavbarState createState() => _NavbarState();
}

class _NavbarState extends State<Navbar> {

  int _selectedIndex = 0;
  List<Widget> _widgetOptions = <Widget>[
    Home(),
    Time(),
    Tasks(),
    Data(),
  ];

  void _onItemTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: theme.colorScheme.surface,
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              backgroundColor: Color(0x161616),
              activeIcon: Icon(
                BootstrapIcons.house_door_fill,
                color: Colors.white,
              ),
              icon: Icon(
                BootstrapIcons.house_door_fill,
                color: Color(0xFF757575),
              ),
              label: "Home"
          ),
          BottomNavigationBarItem(
              activeIcon: Icon(
                BootstrapIcons.clock_fill,
                color: Colors.white,
              ),
              icon: Icon(
                BootstrapIcons.clock_fill,
                color: Color(0xFF757575),
              ),
              label: "Clock"
          ),
          BottomNavigationBarItem(
              backgroundColor: Color(0x161616),
              activeIcon: Icon(
                BootstrapIcons.file_text_fill,
                color: Colors.white,
              ),
              icon: Icon(
                BootstrapIcons.file_text_fill,
                color: Color(0xFF757575),
              ),
              label: "File Text"
          ),
          BottomNavigationBarItem(
              backgroundColor: Color(0x161616),
              activeIcon: Icon(
                BootstrapIcons.file_arrow_up_fill,
                color: Colors.white,
              ),
              icon: Icon(
                BootstrapIcons.file_arrow_up_fill,
                color: Color(0xFF757575),
              ),
              label: "Data"
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTap,
        backgroundColor: theme.scaffoldBackgroundColor,
        iconSize: 30,
        showUnselectedLabels: false,
        showSelectedLabels: false,
      ),
    );
  }
}

