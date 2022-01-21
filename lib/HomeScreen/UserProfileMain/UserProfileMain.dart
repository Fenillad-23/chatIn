import 'package:chattin/HomeScreen/BottomNavigationBar/BottomNav.dart';
import 'package:flutter/material.dart';

class UserProfileMain extends StatefulWidget {
  const UserProfileMain({ Key? key }) : super(key: key);

  @override
  _UserProfileMainState createState() => _UserProfileMainState();
}

class _UserProfileMainState extends State<UserProfileMain> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       body: Container(),
       bottomNavigationBar: BottomNavigation(),
    );
  }
}