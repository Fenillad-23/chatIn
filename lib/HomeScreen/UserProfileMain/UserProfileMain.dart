import 'dart:ui';

import 'package:chattin/HomeScreen/UserProfileMain/FollowingList.dart';
import 'package:chattin/HomeScreen/UserProfileMain/Setting.dart';
import 'package:chattin/Network/network_dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'EditProfile/EditProfile.dart';
import 'FollowerList.dart';

class UserProfileMain extends StatefulWidget {
  const UserProfileMain({Key? key}) : super(key: key);

  @override
  _UserProfileMainState createState() => _UserProfileMainState();
}

class _UserProfileMainState extends State<UserProfileMain> {
  bool _showPreview = false;
  String? _image;
  String? profile;
  int index = 0;
  String userName = ' ';
  String name = '';
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
    if (response['statusCode'] != null &&
        (response['statusCode'] == 200 || response['statusCode'] == "200")) {
      // print('\x1b[93m --- $response');
      dataList = response['data'];
      name =
          response['result'].length != 0 ? response['result'][0]['name'] : '';
      profile = response['result'].length != 0
          ? response['result'][0]['profilepicture']
          : '';
      print("----------------------------------$profile");
      following = response['followingCount'][0]['count'];
      followers = response['followersCount'][0]['count'];
      postCount = dataList.length;
      print("name----------------------------$name");
      setState(() {});
    } else {
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
      body: Container(
        height: MediaQuery.of(context).size.height,
        padding: EdgeInsets.fromLTRB(20, 30, 20, 0),
        // color: new Color(0xFFECEFF1),
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  Row(
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
                                child: profile.toString() != 'null'
                                    ? Image.network(profile!,
                                        width: 90,
                                        height: 90,
                                        fit: BoxFit.cover)
                                    : ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(100),
                                        child: Image.asset(
                                            'assets/images/user.jpeg',
                                            width: 90,
                                            height: 90,
                                            fit: BoxFit.cover),
                                      ),
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
                                  : Text(
                                      '$userName',
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w500),
                                    ),
                              Container(
                                padding: EdgeInsets.fromLTRB(2, 5, 0, 0),
                                child: Text(
                                  name != null ? name : "N/A",
                                  style: TextStyle(
                                      // color: Colors.black.withOpacity(0.6),
                                      fontSize: 12),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
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
                    ),
                  ),
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
                                                // color: Colors.black,
                                                fontSize: 20,
                                                fontWeight: FontWeight.w500))
                                        : Text("$postCount",
                                            style: TextStyle(
                                                // color: Colors.black,
                                                fontSize: 20,
                                                fontWeight: FontWeight.w500)),
                                    SizedBox(
                                      height: 6,
                                    ),
                                    Text("Post",
                                        style: TextStyle(
                                            // color:
                                            // Colors.black.withOpacity(0.6),
                                            fontSize: 12))
                                  ],
                                ),
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        followerList(Name: userName),
                                  ),
                                );
                              },
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
                                                // color: Colors.black,
                                                fontSize: 20,
                                                fontWeight: FontWeight.w500)),
                                    SizedBox(
                                      height: 6,
                                    ),
                                    Text("Followers",
                                        style: TextStyle(
                                            // color:
                                            // Colors.black.withOpacity(0.6),
                                            fontSize: 12))
                                  ],
                                ),
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        followingList(Name: userName),
                                  ),
                                );
                              },
                              child: Padding(
                                padding:
                                    EdgeInsets.only(right: 10.0, left: 10.0),
                                child: Column(
                                  children: [
                                    following == 'null'
                                        ? Text("0",
                                            style: TextStyle(
                                                // color: Colors.black,
                                                fontSize: 20,
                                                fontWeight: FontWeight.w500))
                                        : Text("$following",
                                            style: TextStyle(
                                                // color: Colors.black,
                                                fontSize: 20,
                                                fontWeight: FontWeight.w500)),
                                    SizedBox(
                                      height: 6,
                                    ),
                                    Text("Following",
                                        style: TextStyle(
                                            // color:
                                            // Colors.black.withOpacity(0.6),
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
                  GridView.builder(
                    itemCount: dataList.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 16,
                        mainAxisSpacing: 16),
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
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
                            fit: BoxFit.cover,
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
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
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15.0),
                    child: Image.network(_image!,
                        width: 300, height: 400, fit: BoxFit.cover),
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
