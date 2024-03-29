import 'package:chattin/HomeScreen/Storybar/StoryBarWidget.dart';
import 'package:chattin/HomeScreen/UserProfile/UserProfile.dart';
import 'package:chattin/Network/network_dio.dart';
import 'package:chattin/Post/commentSection.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Chat/Chat_Ui_Main.dart';
import 'package:carousel_slider/carousel_slider.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  NetworkRepository nw = NetworkRepository();
  List dataList = [];
  bool loaded = false;
  bool? darkthemeState;
  int _optionValue = 0;
  String? name, unfollowUserName;
  @override
  void initState() {
    super.initState();
    LoadPosts();
    setThemeState();
    setCrediatials();
    setState(() {});
  }

  setCrediatials() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    name = sharedPreferences.getString('username');
    setState(() {});
    print('username\n');
    print(name);
  }

  void setThemeState() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    darkthemeState = sharedPreferences.getBool("lightTheme");
    setState(() {});
    // print(sharedPreferences.getBool("lightTheme"));
  }

  LoadPosts() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    setState(() {});
    dynamic response = await nw.httpPost(
        "user/homepage", {'username': sharedPreferences.getString("username")});
    if (response['statusCode'] != null ||
        response['statusCode'] == 200 && response['statusCode'] == '200') {
      setState(() {});
      dataList = response['posts'];
      loaded = true;
      setState(() {});
    }
  }

  unfollow(name, unfollowUserName) async {
    dynamic unfollowResponse = await nw.httpPost('user/unfollow',
        {'username': name, 'followUsername': unfollowUserName});
    print('unfollow user response: \n');
    print(unfollowResponse);
    setState(() {});
    LoadPosts();
  }

  postWidget(BuildContext context) {
    return Column(
      children: List.generate(
        dataList.length,
        (index) {
          return Column(
            children: List.generate(
              dataList[index].length,
              (i) {
                return Container(
                  // color: Colors.blue,
                  padding: EdgeInsets.only(bottom: 20),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
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
                                        dataList[index][i]['profilePic']
                                            .toString(),
                                        // "https://images.unsplash.com/photo-1640622304233-7335e936f11b?ixlib=rb-1.2.1&ixid=MnwxMjA3fDF8MHxlZGl0b3JpYWwtZmVlZHwxMXx8fGVufDB8fHx8&auto=format&fit=crop&w=500&q=60",
                                        height: 40,
                                        width: 40,
                                        fit: BoxFit.cover,
                                      ),
                                    )),
                                Padding(
                                  padding: EdgeInsets.only(left: 10),
                                  child: GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => UserProfile(
                                              userName: dataList[index][i]
                                                      ['postedBy']
                                                  .toString(),
                                            ),
                                          ));
                                    },
                                    child: Text(
                                      dataList[index][i]['postedBy'].toString(),
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            // Container(
                            //     height: 40,
                            //     child: Padding(
                            //       padding: EdgeInsets.only(top: 5),
                            //       child: Icon(
                            //         Icons.more_vert,
                            //         size: 30,
                            //       ),
                            //     )),
                            PopupMenuButton(
                                onSelected: (value) {
                                  setState(() {
                                    _optionValue = value as int;
                                  });
                                  // print(_optionValue);
                                  if (_optionValue == 1) {
                                    setState(() {
                                      unfollowUserName =
                                          dataList[index][i]['postedBy'];
                                    });
                                    unfollow(name, unfollowUserName);
                                  } else if (_optionValue == 2) {}
                                },
                                itemBuilder: (context) => [
                                      PopupMenuItem(
                                        child: Text("Unfollow User"),
                                        value: 1,
                                      ),
                                      PopupMenuItem(
                                        child: Text("Report user"),
                                        value: 2,
                                      )
                                    ]),
                          ],
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Divider(
                          thickness: 1,
                        ),
                        SizedBox(
                          height: 7,
                        ),
                        Row(
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width - 58,
                              child: Text(
                                dataList[index][i]['caption'].toString(),
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
                        dataList[index][i]['image'].length == 1
                            ? Container(
                                height: 300,
                                width: MediaQuery.of(context).size.width,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10.0),
                                  child: Image.network(
                                    dataList[index][i]['image'][0].toString(),
                                    // "https://images.unsplash.com/photo-1640622304233-7335e936f11b?ixlib=rb-1.2.1&ixid=MnwxMjA3fDF8MHxlZGl0b3JpYWwtZmVlZHwxMXx8fGVufDB8fHx8&auto=format&fit=crop&w=500&q=60",
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              )
                            : Container(
                                margin: EdgeInsets.all(15),
                                child: CarouselSlider.builder(
                                  itemCount: dataList[index][i]['image'].length,
                                  options: CarouselOptions(
                                    enlargeCenterPage: true,
                                    height: 300,
                                    autoPlay: false,
                                    autoPlayInterval: Duration(seconds: 3),
                                    reverse: false,
                                    aspectRatio: 5.0,
                                  ),
                                  itemBuilder: (context, n, id) {
                                    //for onTap to redirect to another screen
                                    return GestureDetector(
                                      child: Container(
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                            border: Border.all(
                                              color: Colors.white,
                                            )),
                                        //ClipRRect for image border radius
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          child: Image.network(
                                            dataList[index][i]['image'][n],
                                            width: 500,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                      onTap: () {
                                        var url = imageList[i];
                                        print(url.toString());
                                      },
                                    );
                                  },
                                ),
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
                                    // child: dataList[index]['isLike'] == true
                                    //     ? Icon(
                                    //         Icons.favorite,
                                    //         color: Colors.red,
                                    //         size: 32,
                                    //       )
                                    //     : Icon(
                                    //         Icons.favorite_outline,
                                    //         size: 32,
                                    //       ),
                                    child: Icon(
                                      Icons.favorite_outline,
                                      size: 32,
                                    ),
                                    onTap: () {
                                      // dataList[index]['isLike'] =
                                      //     !dataList[index]['isLike'];
                                      // setState(() {});
                                    }),
                                SizedBox(
                                  width: 25,
                                ),
                                IconButton(
                                    icon: Icon(FontAwesomeIcons.comment),
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => commentBox(
                                                // name: dataList[index][i]
                                                //     ['postedBy'],
                                                // profilePic: dataList[index][i]
                                                //     ['profile']
                                                )),
                                      );
                                    }),
                                SizedBox(
                                  width: 25,
                                ),
                                new Icon(FontAwesomeIcons.paperPlane),
                                // const Text("45",style: TextStyle(fontSize: 15),),
                              ],
                            ),
                            InkWell(
                              onTap: () {
                                // dataList[index]['isSaved'] =
                                //     !dataList[index]['isSaved'];
                                // setState(() {});
                              },
                              child: Icon(
                                Icons.bookmark,
                                // dataList[index]['isSaved'] == true
                                //     ? Icons.bookmark
                                //     : Icons.bookmark_outline,
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
                              '0', //dataList[index]['likesCount'],
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
                              '1 hour ago',
                              // dataList[index]['duration'],
                              style: TextStyle(
                                color: darkthemeState == true
                                    ? Colors.white.withOpacity(0.6)
                                    : Colors.black.withOpacity(0.6),
                                fontSize: 12,
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Text('Home',
              style: TextStyle(
                  color: darkthemeState == true ? Colors.white : Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 22)),
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: IconButton(
                  icon: Icon(FontAwesomeIcons.commentDots,
                      color:
                          darkthemeState == true ? Colors.white : Colors.black),
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
                      child: loaded == false
                          ? CircularProgressIndicator()
                          : postWidget(context),
                    )
                  ],
                )
              ],
            ),
          ),
        )));
  }
}
