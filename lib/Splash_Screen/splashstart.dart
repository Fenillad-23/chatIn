import 'dart:async';

import 'package:chattin/Splash_Screen/splash.dart';
import 'package:flutter/material.dart';

class splashStart extends StatefulWidget {
  const splashStart({ Key? key }) : super(key: key);

  @override
  _splashStartState createState() => _splashStartState();
}

class _splashStartState extends State<splashStart> {

  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => SplashScreen(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.blue,
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 150,
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(100),
              child: Image.asset(
                'assets/images/logo_white.png',
                width: 120,
                height: 120,
                fit: BoxFit.contain,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Spacer(),
            CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      strokeWidth: 4,
                    ),
            SizedBox(
              height: 120,
            ),
          ],
        ),
      ),
    );
  }
}