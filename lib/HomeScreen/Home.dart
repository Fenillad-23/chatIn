import 'package:chattin/HomeScreen/Demo.dart';
import 'package:flutter/material.dart';
import 'DashBoard.dart';
import 'UserProfile/UserProfile.dart';
import 'UserProfileMain/UserProfileMain.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int currentTab = 0;
  final List<Widget> screens = [
    Dashboard(),
    UserProfile(),
    Dashboard(),
    Demo(),
    UserProfileMain()
  ];

  final PageStorageBucket bucket = PageStorageBucket();
  Widget currentScreen = Dashboard();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageStorage(
        child: currentScreen,
        bucket: bucket,
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {},
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 10,
        child: Container(
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MaterialButton(
                    //minWidth: 90,
                    onPressed: (){
                    setState(() {
                      currentScreen = Dashboard();
                      currentTab = 0;
                    });
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.home,
                        color: currentTab == 0 ? Colors.blue : Colors.grey,
                      ),
                    ],
                  ),
                  ),
                  MaterialButton(
                    //minWidth: 30,
                    onPressed: (){
                    setState(() {
                      currentScreen = UserProfile();
                      currentTab = 1;
                    });
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.search,
                        color: currentTab == 1 ? Colors.blue : Colors.grey,
                      ),
                    ],
                  ),
                  )
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MaterialButton(
                    //minWidth: 30,
                    onPressed: (){
                    setState(() {
                      currentScreen = Dashboard();
                      currentTab = 2;
                    });
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.notifications,
                        color: currentTab == 2 ? Colors.blue : Colors.grey,
                      ),
                    ],
                  ),
                  ),
                  MaterialButton(
                    //minWidth: 90,
                    onPressed: (){
                    setState(() {
                      currentScreen = Demo();
                      currentTab = 3;
                    });
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.perm_identity,
                        color: currentTab == 3 ? Colors.blue : Colors.grey,
                      ),
                    ],
                  ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
