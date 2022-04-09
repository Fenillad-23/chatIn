import 'dart:ui';

import 'package:chattin/HomeScreen/UserProfile/Post.dart';
import 'package:chattin/HomeScreen/UserProfileMain/FollowingList.dart';
import 'package:chattin/Network/network_dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../UserProfileMain/FollowerList.dart';

class UserProfile extends StatefulWidget {
  String? userName;
  List ImageUrl = [];
  UserProfile({Key? key, this.userName}) : super(key: key);

  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  bool _showPreview = false;
  String? _image;
  int? index;
  int? followersCount, followingCount, postCount;
  bool? followed;
  String? name, fullName, profilepic;
  bool? isDataLoading = false;
  List names = [];

  bool? darkthemeState;
  void initState() {
    super.initState();
    sendUserName();
  }

  NetworkRepository nw = NetworkRepository();
  sendUserName() async {
    isDataLoading = true;
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    name = sharedPreferences.getString("username")!;
    darkthemeState = sharedPreferences.getBool("lightTheme");
    // print(name);

    dynamic response = await nw.httpPost("user/getData", {
      'newUsername': widget.userName.toString(),
    });
    imageList.clear();
    if (response != null &&
        (response['statusCode'] == 200 || response['statusCode'] == "200")) {
      // print("response----------$response");
      followersCount = response['followersCount'][0]['count'];
      followingCount = response['followingCount'][0]['count'];
      profilepic = response['result'][0]['profilepicture'];
      fullName = response['result'][0]['name'] != null
          ? response['result'][0]['name']
          : " ";
      postCount =
          response['postresult'] != null && response['postresult'].length != 0
              ? response['postresult'].length
              : 0;
      imageList =
          response['postresult'] != null && response['postresult'].length != 0
              ? response['postresult']
              : [];
      userDetails = response['result'] != null && response['result'].length != 0
          ? response['result']
          : [];
      print("-----------${imageList[3]['image']}");
      // print("----------------");
      names = response['result'][0]['followers'];
      // print(names);
      if (names.contains(name)) {
        print("already following");
        index = 0;
      } else {
        print("not following");
        index = 1;
      }
      // print("post----------$postCount");
      // print("followcount $followersCount");
      // print("followingCount----------$followingCount");
      isDataLoading = false;
      setState(() {});
    }
    setState(() {});
  }

  followUser() async {
    dynamic response = await nw.httpPost("user/follow", {
      'username': name,
      'followUsername': widget.userName.toString(),
    });
    sendUserName();
    setState(() {});
  }

  unfollow() async {
    dynamic response = await nw.httpPost("user/unfollow", {
      'username': name,
      'followUsername': widget.userName.toString(),
    });
    sendUserName();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.userName.toString(),
          style: TextStyle(
              color: darkthemeState == true ? Colors.white : Colors.black),
        ),
        actions: <Widget>[
          Padding(
            padding: EdgeInsets.only(right: 5),
            child: IconButton(
              icon: Icon(Icons.more_vert,
                  color: darkthemeState == true ? Colors.white : Colors.black),
              onPressed: () {},
            ),
          )
        ],
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: new IconButton(
          icon: new Icon(Icons.arrow_back,
              color: darkthemeState == true ? Colors.white : Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        padding: EdgeInsets.fromLTRB(20, 30, 20, 0),
        //color: new Color(0xFFECEFF1),
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
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
                                child: isDataLoading == true
                                    ? ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(100),
                                        child: Image.asset(
                                            'assets/images/user.jpeg',
                                            width: 90,
                                            height: 90,
                                            fit: BoxFit.cover),
                                      )
                                    : ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(100),
                                        child: Image.network(profilepic!,
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
                                Text(widget.userName.toString(),
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w500)),
                                Container(
                                    padding: EdgeInsets.fromLTRB(2, 5, 0, 0),
                                    child: Text(
                                        fullName.toString() != 'null'
                                            ? fullName.toString()
                                            : " ",
                                        style: TextStyle(
                                            color: darkthemeState == true
                                                ? Colors.white.withOpacity(0.6)
                                                : Colors.black.withOpacity(0.6),
                                            fontSize: 12))),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 15, right: 0, left: 7),
                    child: Row(
                        //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            height: 57,
                            width: MediaQuery.of(context).size.width / 3.5,
                            //color: Colors.deepOrange,
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
                                        size: 28,
                                        color: darkthemeState == true
                                            ? Colors.white
                                            : Colors.black87)),
                                label: Text("")),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 23),
                            child: Container(
                              height: 57,
                              width: MediaQuery.of(context).size.width / 2,
                              //color: Colors.deepPurple,
                              child: ElevatedButton(
                                onPressed: () {
                                  setState(() {
                                    if (index == 0) {
                                      unfollow();
                                      setState(() {});
                                    } else if (index == 1) {
                                      followUser();
                                      setState(() {});
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
                                      ? Colors.blue
                                      : new Color(0xFFECEFF1),
                                ),
                                child: Text(
                                  index == 1 ? 'Follow' : 'Unfollow',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w400,
                                      color: index == 1
                                          ? Colors.white
                                          : Colors.black),
                                ),
                              ),
                            ),
                          )
                        ]),
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
                                    postCount == null
                                        ? Text("0",
                                            style: TextStyle(
                                                color: darkthemeState == true
                                                    ? Colors.white
                                                    : Colors.black,
                                                fontSize: 20,
                                                fontWeight: FontWeight.w500))
                                        : Text(postCount.toString(),
                                            style: TextStyle(
                                                color: darkthemeState == true
                                                    ? Colors.white
                                                    : Colors.black,
                                                fontSize: 20,
                                                fontWeight: FontWeight.w500)),
                                    SizedBox(
                                      height: 6,
                                    ),
                                    Text("Post",
                                        style: TextStyle(
                                            color: darkthemeState == true
                                                ? Colors.white.withOpacity(0.6)
                                                : Colors.black.withOpacity(0.6),
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
                                    builder: (context) => followerList(
                                        Name: widget.userName.toString()),
                                  ),
                                );
                              },
                              child: Padding(
                                padding:
                                    EdgeInsets.only(right: 10.0, left: 10.0),
                                child: Column(
                                  children: [
                                    followersCount == null
                                        ? Text("0",
                                            style: TextStyle(
                                                color: darkthemeState == true
                                                    ? Colors.white
                                                    : Colors.black,
                                                fontSize: 20,
                                                fontWeight: FontWeight.w500))
                                        : Text(followersCount.toString(),
                                            style: TextStyle(
                                                color: darkthemeState == true
                                                    ? Colors.white
                                                    : Colors.black,
                                                fontSize: 20,
                                                fontWeight: FontWeight.w500)),
                                    SizedBox(
                                      height: 6,
                                    ),
                                    Text("Followers",
                                        style: TextStyle(
                                            color: darkthemeState == true
                                                ? Colors.white.withOpacity(0.6)
                                                : Colors.black.withOpacity(0.6),
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
                                    builder: (context) => followingList(
                                        Name: widget.userName.toString()),
                                  ),
                                );
                              },
                              child: Padding(
                                padding:
                                    EdgeInsets.only(right: 10.0, left: 10.0),
                                child: Column(
                                  children: [
                                    followingCount == null
                                        ? Text("0",
                                            style: TextStyle(
                                                color: darkthemeState == true
                                                    ? Colors.white
                                                    : Colors.black,
                                                fontSize: 20,
                                                fontWeight: FontWeight.w500))
                                        : Text(followingCount.toString(),
                                            style: TextStyle(
                                                color: darkthemeState == true
                                                    ? Colors.white
                                                    : Colors.black,
                                                fontSize: 20,
                                                fontWeight: FontWeight.w500)),
                                    SizedBox(
                                      height: 6,
                                    ),
                                    Text("Following",
                                        style: TextStyle(
                                            color: darkthemeState == true
                                                ? Colors.white.withOpacity(0.6)
                                                : Colors.black.withOpacity(0.6),
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
                  isDataLoading == true
                      ? Center(
                          child: Column(
                            children: [
                              CircularProgressIndicator(
                                valueColor:
                                    AlwaysStoppedAnimation<Color>(Colors.blue),
                                strokeWidth: 4,
                              )
                            ],
                          ),
                        )
                      : GridView.builder(
                          itemCount: imageList.length,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  crossAxisSpacing: 16,
                                  mainAxisSpacing: 16),
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: (BuildContext context, int index) {
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => PostList(
                                              userData: userDetails,
                                              image: imageList,
                                            )));
                              },
                              onLongPress: () {
                                setState(() {
                                  _showPreview = true;
                                  _image =
                                      imageList[index]['image'][0].toString();
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
                                  imageList[index]['image'][0].toString(),
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

List imageList = [];
List userDetails = [];
// Widget __contentGridView() {
//   return LayoutBuilder(
//     builder: (context, constraints) {
//       return GridView.builder(
//         itemCount: imageList.length,
//         gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//           crossAxisCount: constraints.maxWidth > 700 ? 4 : 2,
//           crossAxisSpacing: 16,
//           mainAxisSpacing: 16,
//         ),
//         physics: BouncingScrollPhysics(),
//         shrinkWrap: true,
//         itemBuilder: (context, index) => GridTile(
//           child: GestureDetector(
//             onLongPress: (){},
//             child: ClipRRect(
//               borderRadius: BorderRadius.circular(15.0),
//               child: Image.network(imageList[index],
//                   width: 300, height: 150, fit: BoxFit.cover),
//             ),
//           ),
//           // child: Image.network(imageList[index]),
//         ),
//       );
//     },
//   );
// }
