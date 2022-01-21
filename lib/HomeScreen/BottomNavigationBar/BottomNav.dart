import 'package:chattin/HomeScreen/DashBoard.dart';
import 'package:chattin/HomeScreen/UserProfile/UserProfile.dart';
import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({Key? key}) : super(key: key);

  @override
  _BottomNavigationState createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  // int _page = 0;
  // GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     bottomNavigationBar: CurvedNavigationBar(
  //       height: 60.0,
  //       backgroundColor: Color(0xFFe9eaec),
  //       color: Colors.white,
  //       items: <Widget>[
  //         Icon(Icons.home, size: 30, color: Colors.blueAccent),
  //         Icon(Icons.home, size: 30, color: Colors.blueAccent),
  //         Icon(Icons.add, size: 30, color: Colors.blueAccent),
  //         Icon(Icons.person_sharp, size: 30, color: Colors.blueAccent),
  //       ],
  //       buttonBackgroundColor: Colors.white,
  //       animationCurve: Curves.easeInOut,
  //       animationDuration: Duration(milliseconds: 600),
  //       onTap: (index) {
  //         switch (index) {
  //         }
  //       },
  //       letIndexChange: (index) => true,
  //     ),
  //   );
  // }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        index: 0,
        height: 65.0,
        items: <Widget>[
          Icon(Icons.home, size: 30, color: Colors.blueAccent),
          Icon(Icons.search, size: 30, color: Colors.blueAccent),
          Icon(Icons.add, size: 30, color: Colors.blueAccent),
          Icon(Icons.email_outlined, size: 30, color: Colors.blueAccent),
          Icon(Icons.perm_identity, size: 30, color: Colors.blueAccent),
        ],
        backgroundColor: Color(0xFFe9eaec),
        color: Colors.white,
        // backgroundColor: Colors.blueAccent,
        animationCurve: Curves.easeInOut,
        animationDuration: Duration(milliseconds: 500),
        onTap: (index) {
          // print(index);
          switch (index) {
            case 0:
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => Dashboard()));
              break;
            case 1:
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => UserProfile()));
              break;
            case 2:
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => Dashboard()));
              break;
            case 3:
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => Dashboard()));
              break;
            case 4:
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => Dashboard()));
              break;
          }
        },
      ),
    );
  }
}
