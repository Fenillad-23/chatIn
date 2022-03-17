import 'package:chattin/HomeScreen/Storybar/StoryBarWidget.dart';
import 'package:chattin/HomeScreen/UserProfileMain/UserProfileMain.dart';
import 'package:chattin/Network/network_dio.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Chat/Chat_Ui_Main.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  NetworkRepository nw = NetworkRepository();
  @override
  void initState() {
    super.initState();
    LoadPosts();
  }

  LoadPosts() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    dynamic response = await nw.httpPost(
        "user/homepage", {'username': sharedPreferences.getString("username")});
    print("Loading posts...${response['posts']}");
    if (response['statusCode'] != null ||
        response['statusCode'] == 200 && response['statusCode'] == '200') {
      dataList.add(response['posts'][0]);
      setState(() {});
      print("...................");
      // ListView == >  0,1,2,
      print(dataList[0][0].length);
    }
  }

  List dataList = [
    // {
    //   'imgUrl':
    //       'https://images.unsplash.com/photo-1578166375397-5711fb282325?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170&q=80',
    //   'description':
    //       'My last day for this year holiday! So excited to share my memories with you guys! 😁😍',
    //   'userName': 'Fenil',
    //   'profilePic':
    //       'https://images.unsplash.com/photo-1578166375397-5711fb282325?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170&q=80',
    //   'likesCount': '150',
    //   'duration': '1 hour ago',
    //   'isLike': false,
    //   'isSaved': false,
    // },
    // {
    //   'imgUrl':
    //       'https://images.unsplash.com/photo-1578166375397-5711fb282325?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170&q=80',
    //   'description':
    //       'My last day for this year holiday! So excited to share my memories with you guys! 😁😍',
    //   'userName': 'Vaidehi',
    //   'profilePic':
    //       'https://images.unsplash.com/photo-1578166375397-5711fb282325?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170&q=80',
    //   'likesCount': '150',
    //   'duration': '1 hour ago',
    //   'isLike': false,
    //   'isSaved': false,
    // },
    // {
    //   'imgUrl':
    //       'https://images.unsplash.com/photo-1578166375397-5711fb282325?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170&q=80',
    //   'description':
    //       'My last day for this year holiday! So excited to share my memories with you guys! 😁😍',
    //   'userName': 'Fenil',
    //   'profilePic':
    //       'https://images.unsplash.com/photo-1578166375397-5711fb282325?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170&q=80',
    //   'likesCount': '150',
    //   'duration': '1 hour ago',
    //   'isLike': false,
    //   'isSaved': false,
    // },
    // {
    //   'imgUrl':
    //       'https://images.unsplash.com/photo-1578166375397-5711fb282325?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170&q=80',
    //   'description':
    //       'My last day for this year holiday! So excited to share my memories with you guys! 😁😍',
    //   'userName': 'Fenil',
    //   'profilePic':
    //       'https://images.unsplash.com/photo-1578166375397-5711fb282325?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170&q=80',
    //   'likesCount': '150',
    //   'duration': '1 hour ago',
    //   'isLike': false,
    //   'isSaved': false,
    // },
    // {
    //   'imgUrl':
    //       'https://images.unsplash.com/photo-1578166375397-5711fb282325?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170&q=80',
    //   'description':
    //       'My last day for this year holiday! So excited to share my memories with you guys! 😁😍',
    //   'userName': 'Fenil',
    //   'profilePic':
    //       'https://images.unsplash.com/photo-1578166375397-5711fb282325?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170&q=80',
    //   'likesCount': '150',
    //   'duration': '1 hour ago',
    //   'isLike': false,
    //   'isSaved': false,
    // },
    // {
    //   'imgUrl':
    //       'https://images.unsplash.com/photo-1578166375397-5711fb282325?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170&q=80',
    //   'description':
    //       'My last day for this year holiday! So excited to share my memories with you guys! 😁😍',
    //   'userName': 'Fenil',
    //   'profilePic':
    //       'https://images.unsplash.com/photo-1578166375397-5711fb282325?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170&q=80',
    //   'likesCount': '150',
    //   'duration': '1 hour ago',
    //   'isLike': false,
    //   'isSaved': false,
    // },
    // {
    //   'imgUrl':
    //       'https://images.unsplash.com/photo-1578166375397-5711fb282325?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170&q=80',
    //   'description':
    //       'My last day for this year holiday! So excited to share my memories with you guys! 😁😍',
    //   'userName': 'Fenil',
    //   'profilePic':
    //       'https://images.unsplash.com/photo-1578166375397-5711fb282325?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170&q=80',
    //   'likesCount': '150',
    //   'duration': '1 hour ago',
    //   'isLike': false,
    //   'isSaved': false,
    // },
    // {
    //   'imgUrl':
    //       'https://images.unsplash.com/photo-1578166375397-5711fb282325?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170&q=80',
    //   'description':
    //       'My last day for this year holiday! So excited to share my memories with you guys! 😁😍',
    //   'userName': 'Fenil',
    //   'profilePic':
    //       'https://images.unsplash.com/photo-1578166375397-5711fb282325?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170&q=80',
    //   'likesCount': '150',
    //   'duration': '1 hour ago',
    //   'isLike': false,
    //   'isSaved': false,
    // },
  ];

  postWidget(BuildContext context) {
    return Column(
        children: List.generate(dataList[0]["post"].length, (index) {
      return Container(
        //color: Colors.blue,
        padding: EdgeInsets.only(bottom: 20),
        child: Card(
          elevation: 8,
          shape: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Colors.white),
          ),
          shadowColor: Color.fromRGBO(255, 255, 255, 1),
          child: Container(
            padding: EdgeInsets.all(15.0),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                            radius: 20.0,
                            child: ClipOval(
                              child: Image.network(
                                dataList[index],
                                height: 40,
                                width: 40,
                                fit: BoxFit.cover,
                              ),
                            )),
                        Padding(
                          padding: EdgeInsets.only(left: 10),
                          child: Text(
                            dataList[index]['postedBy'],
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18),
                          ),
                        ),
                      ],
                    ),
                    Container(
                        height: 40,
                        child: Padding(
                          padding: EdgeInsets.only(top: 5),
                          child: Icon(
                            Icons.more_vert,
                            size: 30,
                          ),
                        )),
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                Divider(),
                SizedBox(
                  height: 7,
                ),
                Row(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width - 58,
                      child: Text(
                        dataList[index]['description'],
                        style: TextStyle(
                            // color: Colors.black.withOpacity(0.6),
                            fontSize: 12),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 12,
                ),
                Row(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width - 58,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10.0),
                        child: Image.network(
                          dataList[index]['posts']['image'][0],
                          fit: BoxFit.fill,
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        GestureDetector(
                            child: dataList[index]['isLike'] == true
                                ? Icon(
                                    Icons.favorite,
                                    color: Colors.red,
                                    size: 32,
                                  )
                                : Icon(
                                    Icons.favorite_outline,
                                    size: 32,
                                  ),
                            onTap: () {
                              dataList[index]['isLike'] =
                                  !dataList[index]['isLike'];
                              setState(() {});
                            }),
                        SizedBox(
                          width: 25,
                        ),
                        Icon(FontAwesomeIcons.comment),
                        SizedBox(
                          width: 25,
                        ),
                        new Icon(FontAwesomeIcons.paperPlane),
                        // const Text("45",style: TextStyle(fontSize: 15),),
                      ],
                    ),
                    InkWell(
                      onTap: () {
                        dataList[index]['isSaved'] =
                            !dataList[index]['isSaved'];
                        setState(() {});
                      },
                      child: Icon(
                        dataList[index]['isSaved'] == true
                            ? Icons.bookmark
                            : Icons.bookmark_outline,
                        size: 32,
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Text(
                      dataList[index]['likesCount'],
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 3,
                ),
                Row(
                  children: [
                    Text(
                      dataList[index]['duration'],
                      style: TextStyle(
                        color: Colors.black.withOpacity(0.6),
                        fontSize: 12,
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.transparent,
        // appBar: AppBar(
        //     backgroundColor: Colors.transparent,
        //     title: Padding(
        //       padding: const EdgeInsets.all(8.0),
        //       child: Text("ChatIn", style: TextStyle(color: Colors.black)),
        //     )),
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Text('Home',
              style: TextStyle(
                  // color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 22)),
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: IconButton(
                  icon: Icon(FontAwesomeIcons.commentDots, color: Colors.black),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => chat_main_list(),
                      ),
                    );
                  }),
            )
          ],
        ),
        body: SafeArea(
            child: Padding(
          padding: const EdgeInsets.only(top: 13.0),
          child: Container(
            child: ListView(
              children: [
                StoryBarWidget(),
                SizedBox(
                  height: 10,
                ),
                Column(
                  children: [
                    Container(
                      padding: EdgeInsets.all(10.0),
                      child: postWidget(context),
                    )
                  ],
                )
              ],
            ),
          ),
        )));
  }
}
