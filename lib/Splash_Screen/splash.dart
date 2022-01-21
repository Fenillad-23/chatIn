import 'dart:async';
<<<<<<< HEAD

import 'package:chattin/HomeScreen/DashBoard.dart';
import 'package:chattin/HomeScreen/UserProfile/UserProfile.dart';
import 'package:chattin/Registration/otp_success.dart';
=======
import 'package:chattin/HomeScreen/Home.dart';
>>>>>>> 57019e2b2be745c333ccbcdde0478441d333aa2c
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Login/login.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
      navigator();
    });
  }

  navigator() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    if (sharedPreferences.getBool('isRememberMe') == true) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
<<<<<<< HEAD
          builder: (context) => UserProfile(),
=======
          builder: (context) => Home(),
>>>>>>> 57019e2b2be745c333ccbcdde0478441d333aa2c
        ),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => UserProfile(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 120,
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(100),
              child: Image.asset(
                'assets/images/logo_blue.png',
                width: 150,
                height: 150,
                fit: BoxFit.contain,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            const Text(
              "ChatIn",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold),
            ),
            Spacer(),
            Lottie.asset(
              'assets/json/loader.json',
              width: 250,
            ),
            Image.asset(
              'assets/images/Semicolon_logo.jpg',
              width: 150,
            ),
            SizedBox(
              height: 50,
            ),
          ],
        ),
      ),
    );
  }
}
