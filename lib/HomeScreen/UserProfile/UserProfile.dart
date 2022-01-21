import 'package:chattin/HomeScreen/User/UserPrefrences.dart';
import 'package:flutter/material.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({Key? key}) : super(key: key);

  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  final user = UserPreferences.myuser;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
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
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: Image.asset(
                  'assets/images/user.jpeg',
                  width: 100,
                  height: 100,
                  fit: BoxFit.contain,
                ),
              ),
            ),
            const SizedBox(height: 24),
            Column(
              children: [
                Text(
                  "fenil.23",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                ),
                const SizedBox(height: 4),
                Text(
                  "fenil lad",
                  style: TextStyle(color: Colors.grey),
                ),
                Container(
                  height: 130,
                  width: MediaQuery.of(context).size.width,
                  child: Card(
                    elevation: 8,
                    shape: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Colors.white)),
                    shadowColor: Colors.blue,
                    margin: EdgeInsets.all(20),
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
                                style:
                                    TextStyle(fontSize: 15, letterSpacing: 0.4),
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
                                style: TextStyle(fontSize: 15),
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
                                style:
                                    TextStyle(fontSize: 15, letterSpacing: 0.4),
                              ),
                              SizedBox(
                                height: 6,
                              ),
                              Text(
                                'Following',
                                style:
                                    TextStyle(fontSize: 15, letterSpacing: 0.4),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
