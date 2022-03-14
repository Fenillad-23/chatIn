import 'package:chattin/Splash_Screen/splashstart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'HomeScreen/UserProfileMain/Setting.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(RestartWidget(child: const Chattin()));
}

class Chattin extends StatefulWidget {
  const Chattin({Key? key}) : super(key: key);

  @override
  _ChattinState createState() => _ChattinState();
}

class _ChattinState extends State<Chattin> {
  String? fontFamily;

  void initState() {
    super.initState();
    // print(fonts);
    getFontFamily();
  }

  getFontFamily() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    fontFamily = sharedPreferences.getString('fontFamily');
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ChatIn',
      theme: ThemeData(
        fontFamily: fontFamily,
        primarySwatch: Colors.blue,
      ),
      home: splashStart(),
    );
  }
}
