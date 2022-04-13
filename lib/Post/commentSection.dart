import 'package:flutter/material.dart';
import 'package:comment_box/comment/comment.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class commentBox extends StatefulWidget {
  String? name, profilePic;
  commentBox({Key? key}) : super(key: key);

  @override
  State<commentBox> createState() => _commentBoxState();
}

class _commentBoxState extends State<commentBox> {
  bool? darkthemeState;

  @override
  void initState() {
    super.initState();
    setThemeState();
  }

  void setThemeState() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    darkthemeState = sharedPreferences.getBool("lightTheme");
    setState(() {});
    // print(sharedPreferences.getBool("lightTheme"));
  }

  List comments = [
    {
      "username": "fenil2310",
      "profilePic":
          "https://images.unsplash.com/photo-1648800475313-2bb7fbec8701?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHx0b3BpYy1mZWVkfDQ4fGhtZW52UWhVbXhNfHxlbnwwfHx8fA%3D%3D&auto=format&fit=crop&w=500&q=60",
      "comment": "Nice!"
    },
    {
      "username": "darshan2",
      "profilePic":
          "https://images.unsplash.com/photo-1648969415827-f4bdaa8d301a?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHx0b3BpYy1mZWVkfDQ0fGhtZW52UWhVbXhNfHxlbnwwfHx8fA%3D%3D&auto=format&fit=crop&w=500&q=60",
      "comment": "great!"
    },
    {
      "username": "vaidehi",
      "profilePic":
          "https://images.unsplash.com/photo-1648584489677-e5b97136c442?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHx0b3BpYy1mZWVkfDY2fGhtZW52UWhVbXhNfHxlbnwwfHx8fA%3D%3D&auto=format&fit=crop&w=500&q=60",
      "comment": "good😊"
    },
    {
      "username": "fenil2310",
      "profilePic":
          "https://images.unsplash.com/photo-1648584489677-e5b97136c442?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHx0b3BpYy1mZWVkfDY2fGhtZW52UWhVbXhNfHxlbnwwfHx8fA%3D%3D&auto=format&fit=crop&w=500&q=60",
      "comment": "yay!😍"
    },
  ];
  sendComment() async {
    comments.add({
      "username": "fenil2310",
      "profilePic":
          "https://images.unsplash.com/photo-1648584489677-e5b97136c442?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHx0b3BpYy1mZWVkfDY2fGhtZW52UWhVbXhNfHxlbnwwfHx8fA%3D%3D&auto=format&fit=crop&w=500&q=60",
      "comment": comment.text.toString()
    });
    comment.clear();
    setState(() {});
  }

  TextEditingController comment = new TextEditingController();
  ScrollController _scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // backgroundColor: Colors.transparent,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Text('Comments',
              style: TextStyle(
                  color: darkthemeState == true ? Colors.white : Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 22)),
        ),
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Container(
            child: Column(
              children: <Widget>[
                Expanded(
                  child: ListView.builder(
                      controller: _scrollController,
                      physics: BouncingScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: comments.length + 1,
                      itemBuilder: (context, index) {
                        if (index == comments.length) {
                          return Container(
                            height: 70,
                          );
                        }

                        return Container(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    CircleAvatar(
                                      child: ClipOval(
                                        child: Container(
                                            height: 40,
                                            width: 40,
                                            child: Image.network(
                                                comments[index]['profilePic'],
                                                fit: BoxFit.cover)),
                                      ),
                                    ),
                                    SizedBox(width: 8),
                                    Column(
                                      children: [
                                        Text(comments[index]['username'],
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.w700,
                                                fontSize: 14)),
                                        Text(
                                          comments[index]['comment'],
                                          style: TextStyle(fontSize: 14),
                                        ),
                                        SizedBox(height: 8),
                                      ],
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      }),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: TextFormField(
                    controller: comment,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.comment_sharp),
                      fillColor: Colors.white,
                      filled: true,
                      suffixIcon: IconButton(
                        icon: Icon(Icons.send),
                        onPressed: () {
                          _scrollController.animateTo(
                              _scrollController.position.maxScrollExtent,
                              duration: Duration(milliseconds: 300),
                              curve: Curves.bounceOut);
                          sendComment();
                        },
                      ),
                      hintText: "Comment",
                      hintStyle: TextStyle(color: Colors.black),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(35),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
