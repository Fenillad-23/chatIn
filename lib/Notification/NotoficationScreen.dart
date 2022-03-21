import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Notificationscreen extends StatefulWidget {
  const Notificationscreen({Key? key}) : super(key: key);

  @override
  State<Notificationscreen> createState() => _NotificationState();
}

class _NotificationState extends State<Notificationscreen> {
  List NototficationList = [];
  bool? darkthemeState;

  @override
  void initState() {
    super.initState();
    setThemeState();
    setState(() {});
  }

  @override
  void setThemeState() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    darkthemeState = sharedPreferences.getBool("lightTheme");
    setState(() {});
    print(sharedPreferences.getBool("lightTheme"));
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Text("Notification",
              style: TextStyle(
                  color: darkthemeState == true ? Colors.white : Colors.black)),
          leading: IconButton(
              onPressed: () {},
              icon: Icon(Icons.arrow_back,
                  color: darkthemeState == true ? Colors.white : Colors.black)),
          actions: [
            IconButton(
                onPressed: () {},
                icon: Icon(Icons.more_vert,
                    color:
                        darkthemeState == true ? Colors.white : Colors.black)),
          ],
        ),
        body: NototficationList.length < 1
            ? Center(
                child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20.0),
                    child: Lottie.asset("assets/json/empty-notification.json",
                        height: 160),
                  ),
                  Text(
                    "Notification is empty",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                  SizedBox(height: 30),
                  Text(
                    "There are no notifications in this account",
                    style: TextStyle(fontSize: 18),
                  ),
                ],
              ))
            : Column(
                children: [
                  Center(
                      child: Text("something", style: TextStyle(fontSize: 18))),
                ],
              ));
  }
}
