import 'package:chattin/HomeScreen/DashBoard.dart';
import 'package:chattin/HomeScreen/UserProfile/UserProfile.dart';
import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

class BottomNavigation extends StatelessWidget {
  const BottomNavigation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // return Scaffold(
    //   bottomNavigationBar: CurvedNavigationBar(
    //     index: 0,
    //     height: 65.0,
    //     items: <Widget>[
    //       Icon(Icons.home, size: 30, color: Colors.blueAccent),
    //       Icon(Icons.search, size: 30, color: Colors.blueAccent),
    //       Icon(Icons.add, size: 30, color: Colors.blueAccent),
    //       Icon(Icons.email_outlined, size: 30, color: Colors.blueAccent),
    //       Icon(Icons.perm_identity, size: 30, color: Colors.blueAccent),
    //     ],
    //     backgroundColor: Color(0xFFe9eaec),
    //     color: Colors.white,
    //     // backgroundColor: Colors.blueAccent,
    //     animationCurve: Curves.easeInOut,
    //     animationDuration: Duration(milliseconds: 500),
    //     onTap: (index) {
    //       // print(index);
    //       switch (index) {
    //         case 0:
    //           Navigator.push(context,
    //               MaterialPageRoute(builder: (context) => Dashboard()));
    //           break;
    //         case 1:
    //           Navigator.push(context,
    //               MaterialPageRoute(builder: (context) => UserProfile()));
    //           break;
    //         case 2:
    //           Navigator.push(context,
    //               MaterialPageRoute(builder: (context) => Dashboard()));
    //           break;
    //         case 3:
    //           Navigator.push(context,
    //               MaterialPageRoute(builder: (context) => Dashboard()));
    //           break;
    //         case 4:
    //           Navigator.push(context,
    //               MaterialPageRoute(builder: (context) => Dashboard()));
    //           break;
    //       }
    //     },
    //   ),
    // );
    final Color inActiveIconColor = Color(0xFFB6B6B6);
    return Container(
      padding: EdgeInsets.symmetric(vertical: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            offset: Offset(0, -15),
            blurRadius: 20,
            color: Color(0xFFDADADA).withOpacity(0.15),
          ),
        ],
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(40),
          topRight: Radius.circular(40),
        ),
      ),
      child: SafeArea(
        top: false,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SizedBox(
              height: 90,
            ),
          ],
        ),
      ),
    );
  }
}
