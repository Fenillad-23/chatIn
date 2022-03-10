import 'dart:ui';

import 'package:chattin/HomeScreen/UserProfileMain/Setting.dart';
import 'package:chattin/Network/network_dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'EditProfile.dart';

class UserProfileMain extends StatefulWidget {
  const UserProfileMain({Key? key}) : super(key: key);

  @override
  _UserProfileMainState createState() => _UserProfileMainState();
}

class _UserProfileMainState extends State<UserProfileMain> {
  bool _showPreview = false;
  String? _image;
  int index = 0;
  String userName = ' ';
  String name = 'user';
  int following = 0, followers = 0, postCount = 0;
  @override
  void initState() {
    super.initState();
    getDetails();
  }

  List data = [];
  getDetails() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    NetworkRepository nw = NetworkRepository();
    print(sharedPreferences.getString('username'));
    userName = sharedPreferences.getString('username')!;
    dynamic response =
        await nw.httpPost("post/getUserAccountDetails", {'postedBy': userName});
    if (response['statusCode'] != null && response['statusCode'] == 200 ||
        response['statusCode'] == "200") {
      // print('\x1b[93m --- $response');
      dataList = response['data'];
      print("----------------------------------");
      following = response['followingCount'][0]['count'];
      followers = response['followersCount'][0]['count'];
      postCount = dataList.length;
      //print(response['data'][2]['uploaddate']);
      //name = 'DS';
      //userName = response['postedBy'].toString();
      name = response['name'].toString();
      print("name----------------------------$name");
      setState(() {});
    } else {
      // print("name----------------------------$userName");
      print(response['message']);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'Profile',
          style: TextStyle(color: Colors.black),
        ),
        actions: <Widget>[
          Padding(
            padding: EdgeInsets.only(right: 5),
            child: IconButton(
              icon: Icon(
                Icons.settings_outlined,
                color: Colors.black,
              ),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Setting()));
              },
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
                height: MediaQuery.of(context).size.height,
                padding: EdgeInsets.fromLTRB(20, 30, 20, 0),
                color: new Color(0xFFECEFF1),
                child: Column(children: [
                  Container(
                    //color: Colors.blue,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          height: 110,
                          width: MediaQuery.of(context).size.width / 3,
                          //color:Colors.green,
                          padding: EdgeInsets.only(right: 20),
                          child: Column(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100),
                                  border: Border.all(
                                    color: Colors.blue,
                                    width: 2,
                                  ),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(100),
                                  child: Image.network(
                                      "https://images.unsplash.com/photo-1562174949-4591859cae0a?ixlib=rb-1.2.1&q=80&fm=jpg&crop=entropy&cs=tinysrgb&w=1080&fit=max",
                                      width: 90,
                                      height: 90,
                                      fit: BoxFit.cover),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(0, 0, 20, 20),
                          child: Container(
                            width: MediaQuery.of(context).size.width / 2,
                            height: 60,
                            //color: Colors.yellow,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                userName == 'null'
                                    ? Text(" ")
                                    : Text('$userName',
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w500)),
                                Container(
                                    padding: EdgeInsets.fromLTRB(2, 5, 0, 0),
                                    child: name == 'null'
                                        ? Text(" ")
                                        : Text('$name',
                                            style: TextStyle(
                                                color: Colors.black
                                                    .withOpacity(0.6),
                                                fontSize: 12))),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Card(
                      elevation: 8,
                      shape: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      // shadowColor: Colors.grey[800],
                      child: Container(
                        height: 35,
                        width: MediaQuery.of(context).size.width,
                        child: OutlinedButton(
                          child: Text('Edit profile'),
                          style: OutlinedButton.styleFrom(
                            primary: Colors.black,
                          ),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => editProfile()));
                          },
                        ),
                      )),
                  SizedBox(
                    height: 7,
                  ),
                  Container(
                    height: 100,
                    width: MediaQuery.of(context).size.width,
                    child: Card(
                      elevation: 8,
                      shape: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      shadowColor: Colors.grey[800],
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            SizedBox(
                              width: 0,
                            ),
                            TextButton(
                              onPressed: () {
                                // Respond to button press
                              },
                              child: Padding(
                                padding:
                                    EdgeInsets.only(right: 10.0, left: 10.0),
                                child: Column(
                                  children: [
                                    postCount == 'null'
                                        ? Text("0",
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 20,
                                                fontWeight: FontWeight.w500))
                                        : Text("$postCount",
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 20,
                                                fontWeight: FontWeight.w500)),
                                    SizedBox(
                                      height: 6,
                                    ),
                                    Text("Post",
                                        style: TextStyle(
                                            color:
                                                Colors.black.withOpacity(0.6),
                                            fontSize: 12))
                                  ],
                                ),
                              ),
                            ),
                            TextButton(
                              onPressed: () {},
                              child: Padding(
                                padding:
                                    EdgeInsets.only(right: 10.0, left: 10.0),
                                child: Column(
                                  children: [
                                    followers == 'null'
                                        ? Text("0",
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 20,
                                                fontWeight: FontWeight.w500))
                                        : Text("$followers",
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 20,
                                                fontWeight: FontWeight.w500)),
                                    SizedBox(
                                      height: 6,
                                    ),
                                    Text("Followers",
                                        style: TextStyle(
                                            color:
                                                Colors.black.withOpacity(0.6),
                                            fontSize: 12))
                                  ],
                                ),
                              ),
                            ),
                            TextButton(
                              onPressed: () {},
                              child: Padding(
                                padding:
                                    EdgeInsets.only(right: 10.0, left: 10.0),
                                child: Column(
                                  children: [
                                    following == 'null'
                                        ? Text("0",
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 20,
                                                fontWeight: FontWeight.w500))
                                        : Text("$following",
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 20,
                                                fontWeight: FontWeight.w500)),
                                    SizedBox(
                                      height: 6,
                                    ),
                                    Text("Following",
                                        style: TextStyle(
                                            color:
                                                Colors.black.withOpacity(0.6),
                                            fontSize: 12))
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Expanded(
                    child: GridView.builder(
                      itemCount: dataList.length,
                      physics: BouncingScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 16,
                          mainAxisSpacing: 16),
                      itemBuilder: (BuildContext context, int index) {
                        return GestureDetector(
                          onLongPress: () {
                            setState(() {
                              _showPreview = true;
                              _image = dataList[index]['image'][0].toString();
                            });
                          },
                          onLongPressEnd: (details) {
                            setState(() {
                              _showPreview = false;
                            });
                          },
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(15.0),
                            child: Image.network(
                                dataList[index]['image'][0].toString(),
                                width: 300,
                                height: 150,
                                fit: BoxFit.cover),
                          ),
                        );
                      },
                    ),
                  ),
                ])),
            if (_showPreview) ...[
              BackdropFilter(
                filter: ImageFilter.blur(
                  sigmaX: 5.0,
                  sigmaY: 5.0,
                ),
                child: Container(
                  color: Colors.white.withOpacity(0.6),
                ),
              ),
              Container(
                child: Center(
                  child: Padding(
                    padding: EdgeInsets.only(top: 0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15.0),
                      child: Image.network(_image!,
                          width: 300, height: 500, fit: BoxFit.cover),
                    ),
                    // child: ClipRRect(
                    //   borderRadius: BorderRadius.circular(10.0),
                    //   child: Image.network(
                    //     _image!,
                    //     height: 300,
                    //     width: 300,
                    //   ),
                    // ),
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

List dataList = [];
