import 'package:chattin/HomeScreen/User/UserPrefrences.dart';
import 'package:flutter/material.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({Key? key}) : super(key: key);

  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("user id"),
        backgroundColor: Colors.transparent,
        leading: new IconButton(
          icon: new Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Center(
        child: ListView(
          children: [
            Container(
              height: 165,
              width: MediaQuery.of(context).size.width,
              child: Card(
                elevation: 8,
                shape: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Colors.white),
                ),
                shadowColor: Colors.blue,
                child: Row(
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: Image.asset(
                              'assets/images/user.jpeg',
                              width: 125,
                              height: 125,
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        children: <Widget>[
                          Text(
                            "full name",
                            style: TextStyle(fontSize: 18, letterSpacing: 0.4),
                          ),
                          Text(
                            "Bio",
                            style: TextStyle(fontSize: 16, letterSpacing: 0.4),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              height: 165,
              width: MediaQuery.of(context).size.width,
              child: Card(
                elevation: 8,
                shape: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.white)),
                shadowColor: Colors.blue,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(top: 20.0),
                      child: Column(
                        children: [
                          Text(
                            "1.5",
                            style: TextStyle(fontSize: 15),
                          ),
                          SizedBox(
                            height: 6,
                          ),
                          Text(
                            'Posts',
                            style: TextStyle(
                                fontSize: 15,
                                letterSpacing: 0.4,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 25),
                    Padding(
                      padding: const EdgeInsets.only(top: 20.0),
                      child: Column(
                        children: [
                          Text(
                            "1.5 k",
                            style: TextStyle(fontSize: 15),
                          ),
                          SizedBox(
                            height: 6,
                          ),
                          Text(
                            'Followers',
                            style: TextStyle(
                                fontSize: 15,
                                letterSpacing: 0.4,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 25,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20.0),
                      child: Column(
                        children: [
                          Text(
                            "1.5 m",
                            style: TextStyle(fontSize: 15, letterSpacing: 0.4),
                          ),
                          SizedBox(
                            height: 6,
                          ),
                          Text(
                            'Following',
                            style: TextStyle(
                                fontSize: 15,
                                letterSpacing: 0.4,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    Row()
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
