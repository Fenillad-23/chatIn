import 'package:carousel_slider/carousel_slider.dart';
import 'package:chattin/HomeScreen/UserProfile/UserProfile.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PostList extends StatefulWidget {
  List userData = [];
  List image = [];
  PostList({Key? key, required this.userData, required this.image})
      : super(key: key);

  @override
  State<PostList> createState() => _PostListState();
}

class _PostListState extends State<PostList> {
  bool? darkthemeState;
  void initState() {
    super.initState();
    get();
  }

  get() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    darkthemeState = sharedPreferences.getBool("lightTheme");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Post",
          style: TextStyle(
              color: darkthemeState == true ? Colors.white : Colors.black),
        ),
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
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 13.0),
          child: Container(
            child: ListView(
              children: [
                Column(
                  children: [
                    Container(
                        padding: EdgeInsets.all(10.0),
                        child: Column(
                          children: List.generate(
                            widget.image.length,
                            (i) {
                              return Container(
                                // color: Colors.blue,
                                padding: EdgeInsets.only(bottom: 20),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    children: [
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              CircleAvatar(
                                                  radius: 20.0,
                                                  child: ClipOval(
                                                    child: Image.network(
                                                      // dataList[index]['profilePic'].toString(),
                                                      widget.userData[0]
                                                              ['profilepicture']
                                                          .toString(),
                                                      height: 40,
                                                      width: 40,
                                                      fit: BoxFit.cover,
                                                    ),
                                                  )),
                                              Padding(
                                                padding:
                                                    EdgeInsets.only(left: 10),
                                                child: GestureDetector(
                                                  onTap: () {
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                          builder: (context) =>
                                                              UserProfile(
                                                            userName: widget
                                                                .userData[0]
                                                                    ['username']
                                                                .toString(),
                                                          ),
                                                        ));
                                                  },
                                                  child: Text(
                                                    widget.userData[0]
                                                            ['username']
                                                        .toString(),
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
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
                                              itemBuilder: (context) => [
                                                    PopupMenuItem(
                                                      child:
                                                          Text("Unfollow User"),
                                                      value: 1,
                                                    ),
                                                    PopupMenuItem(
                                                      child:
                                                          Text("Report user"),
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
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width -
                                                58,
                                            child: Text(
                                              widget.image[i]['caption']
                                                  .toString(),
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
                                      widget.image[i]['image'].length == 1
                                          ? Container(
                                              height: 300,
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(10.0),
                                                child: Image.network(
                                                  widget.image[i]['image'][0]
                                                      .toString(),
                                                  // "https://images.unsplash.com/photo-1640622304233-7335e936f11b?ixlib=rb-1.2.1&ixid=MnwxMjA3fDF8MHxlZGl0b3JpYWwtZmVlZHwxMXx8fGVufDB8fHx8&auto=format&fit=crop&w=500&q=60",
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            )
                                          : Container(
                                              margin: EdgeInsets.all(15),
                                              child: CarouselSlider.builder(
                                                itemCount: widget
                                                    .image[i]['image'].length,
                                                options: CarouselOptions(
                                                  enlargeCenterPage: true,
                                                  height: 300,
                                                  autoPlay: false,
                                                  autoPlayInterval:
                                                      Duration(seconds: 3),
                                                  reverse: false,
                                                  aspectRatio: 5.0,
                                                ),
                                                itemBuilder: (context, n, id) {
                                                  //for onTap to redirect to another screen
                                                  return GestureDetector(
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(15),
                                                          border: Border.all(
                                                            color: Colors.white,
                                                          )),
                                                      //ClipRRect for image border radius
                                                      child: ClipRRect(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(15),
                                                        child: Image.network(
                                                          widget.image[i]
                                                              ['image'][n],
                                                          width: 500,
                                                          fit: BoxFit.cover,
                                                        ),
                                                      ),
                                                    ),
                                                    onTap: () {
                                                      var url = widget.image[i];
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
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
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
                                              Icon(FontAwesomeIcons.comment),
                                              SizedBox(
                                                width: 25,
                                              ),
                                              new Icon(
                                                  FontAwesomeIcons.paperPlane),
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
                                                  ? Colors.white
                                                      .withOpacity(0.6)
                                                  : Colors.black
                                                      .withOpacity(0.6),
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
                        ))
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
