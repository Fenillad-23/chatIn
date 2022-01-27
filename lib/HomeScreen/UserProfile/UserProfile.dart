import 'package:chattin/HomeScreen/User/UserPrefrences.dart';
import 'package:flutter/material.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({Key? key}) : super(key: key);

  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  int index = 0;

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
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            padding: EdgeInsets.all(10.0),
            color: new Color(0xFFECEFF1),
            child: Column(
              children: [
                Container(
                  height: 155,
                  width: MediaQuery.of(context).size.width,
                  child: Row(
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(5.0),
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
                              style:
                                  TextStyle(fontSize: 18, letterSpacing: 0.4),
                            ),
                            Text(
                              "Bio",
                              style:
                                  TextStyle(fontSize: 16, letterSpacing: 0.4),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 30, right: 10, left: 7),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          height: 57,
                          width: 140,
                          // color: Colors.deepOrange,
                          child: OutlinedButton.icon(
                              onPressed: () {},
                              style: OutlinedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(28.5),
                                  ),
                                  side: BorderSide(
                                    width: 2.0,
                                    color: Colors.blue,
                                    style: BorderStyle.solid,
                                  )),
                              icon: Container(
                                  padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                                  child: Icon(Icons.chat_bubble_outline,
                                      size: 28, color: Colors.black87)),
                              label: Text("")),
                        ),
                        Container(
                          height: 57,
                          width: 200,
                          //color: Colors.deepPurple,
                          child: ElevatedButton(
                            onPressed: () {
                              setState(() {
                                if (index == 0) {
                                  index = 1;
                                } else if (index == 1) {
                                  index = 0;
                                }
                              });
                            },
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(28.5),
                              ),
                              side: BorderSide(
                                width: 2.0,
                                color: Colors.blue,
                              ),
                              primary: index == 1
                                  ? new Color(0xFFECEFF1)
                                  : Colors.blue,
                            ),
                            child: Text(
                              index == 1 ? 'Following' : 'Follow',
                              style: TextStyle(
                                  fontSize: 18,
                                  color:
                                      index == 1 ? Colors.black : Colors.white),
                            ),
                          ),
                        )
                      ]),
                ),
                Container(
                  height: 120,
                  width: MediaQuery.of(context).size.width,
                  child: Card(
                    elevation: 8,
                    shape: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    shadowColor: Colors.blue,
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
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
                                  style: TextStyle(
                                      fontSize: 15, letterSpacing: 0.4),
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
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 30),
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: MediaQuery.of(context).size.height,
                        child: GridView(
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                          ),
                          //  scrollDirection: Axis.horizontal,
                          physics: BouncingScrollPhysics(),
                          shrinkWrap: true,
                          children: [
                            Image.network('https://picsum.photos/250?image=1'),
                            Image.network('https://picsum.photos/250?image=2'),
                            Image.network('https://picsum.photos/250?image=3'),
                            Image.network('https://picsum.photos/250?image=1'),
                            Image.network('https://picsum.photos/250?image=2'),
                            Image.network('https://picsum.photos/250?image=3'),
                          ],
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
