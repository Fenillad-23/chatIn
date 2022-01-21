import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({Key? key}) : super(key: key);

  @override
  _BottomNavigationState createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Color(0xFFe9eaec),
        color: Colors.white,
        items: <Widget>[
          Icon(
            Icons.home,
            size: 30,
            color: Colors.blueAccent,
          ),
          Icon(Icons.add, size: 30, color: Colors.blueAccent),
          Icon(Icons.person_sharp, size: 30, color: Colors.blueAccent),
        ],
        onTap: (index) {
          switch (index) {
          }
        },
      ),
    );
  }
}
