import 'package:flutter/material.dart';
import 'package:chattin/Splash_Screen/splash.dart';

void main() {
  runApp(const Chattin());
}

class Chattin extends StatefulWidget {
  const Chattin({Key? key}) : super(key: key);

  @override
  _ChattinState createState() => _ChattinState();
}

class _ChattinState extends State<Chattin> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ChatIn',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SplashScreen(),
    );
  }
}
