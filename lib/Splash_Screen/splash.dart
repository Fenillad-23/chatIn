import 'dart:async';
import 'package:chattin/HomeScreen/Home.dart';
import 'package:chattin/Login/login.dart';
import 'package:chattin/Splash_Screen/onBoarding.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class LocalAuthApi {
  static final _auth = LocalAuthentication();

  static Future<bool> authenticate() async {
    final isAvailable = await hasBiometrics();
    if (!isAvailable) return false;
    try {
      // ignore: deprecated_member_use
      return await _auth.authenticateWithBiometrics(
        localizedReason: 'chatIn is locked',
        useErrorDialogs: true,
        stickyAuth: true,
      );
    } on PlatformException catch (e) {
      return false;
    }
  }

  static Future<bool> hasBiometrics() async {
    try {
      return await _auth.canCheckBiometrics;
    } on PlatformException catch (e) {
      return false;
    }
  }
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3), () {
      navigator();
    });
  }

  navigator() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    print(sharedPreferences.getBool('isRememberMe'));
    print(sharedPreferences.getBool('fingerprint'));
    print(sharedPreferences.getString('username'));
    print(sharedPreferences.getString('password'));
    // LocalAuthApi o= LocalAuthApi();

    if (sharedPreferences.getBool('isRememberMe') == true &&
        sharedPreferences.getBool('fingerprint') == true) {
      print(sharedPreferences.getBool('fingerprint'));
      final isAuthenticated = await LocalAuthApi.authenticate();
      if (isAuthenticated) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => Home()),
        );
      }
    } else if (sharedPreferences.getBool('isRememberMe') == true ||
        sharedPreferences.getBool('fingerprint') == false) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Home()),
      );
    } else if (sharedPreferences.getBool('isRememberMe') == false ||
        sharedPreferences.getBool('fingerprint') == true) {
      final isAuthenticated = await LocalAuthApi.authenticate();
      if (isAuthenticated) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => Home()),
        );
      }
    } else if (sharedPreferences.getBool('isRememberMe') == false ||
        sharedPreferences.getBool('fingerprint') == false) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => onBoarding()),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => onBoarding(),
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
                width: 120,
                height: 120,
                fit: BoxFit.contain,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Spacer(),
            Lottie.asset(
              'assets/json/loader.json',
              width: 70,
            ),
            SizedBox(
              height: 30,
            ),
            Image.asset(
              'assets/images/Semicolon_logo.jpg',
              width: 150,
            ),
            SizedBox(
              height: 100,
            ),
          ],
        ),
      ),
    );
  }
}
