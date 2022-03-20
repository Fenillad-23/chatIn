// ignore_for_file: deprecated_member_use

import 'package:chattin/Splash_Screen/splash.dart';
import 'package:chattin/Splash_Screen/splashstart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'HomeScreen/UserProfileMain/Setting.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(RestartWidget(child: Chattin()));
}

class Chattin extends StatefulWidget {
  Chattin({Key? key}) : super(key: key);

  @override
  _ChattinState createState() => _ChattinState();
}

class _ChattinState extends State<Chattin> {
  String? fontFamily;
  late bool theme;
  late bool loaded = false;
  void initState() {
    super.initState();
    // print(fonts);
    getFontFamily();
    getTheme();
  }

  getFontFamily() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    fontFamily = sharedPreferences.getString('fontFamily');
    print(fontFamily);
    setState(() {});
  }

  getTheme() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    theme = sharedPreferences.getBool('lightTheme')!;
    loaded = true;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    ThemeData _light = ThemeData(
      brightness: Brightness.light,
      primarySwatch: Colors.blue,
      iconTheme: IconThemeData(color: Colors.black),
      //,
      fontFamily: fontFamily,
    );
    ThemeData _Dark = ThemeData(
      brightness: Brightness.dark,
      primarySwatch: Colors.blue,
      iconTheme: IconThemeData(color: Colors.white),
      fontFamily: fontFamily,
      accentColor: Colors.white,
    );
    return loaded == false
        ? MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'ChatIn',
            theme: ThemeData(
              fontFamily: fontFamily,
              primarySwatch: Colors.blue,
              iconTheme: IconThemeData(
                color: Colors.black,
              ),
            ),
            home: SplashScreen(),
          )
        : MaterialApp(
            theme: theme ? _Dark : _light,
            debugShowCheckedModeBanner: false,
            title: 'ChatIn',
            home: SplashScreen(),
          );
  }
}
