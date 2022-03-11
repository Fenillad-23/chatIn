import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'individualChat.dart';

class chat_main_list extends StatefulWidget {
  const chat_main_list({Key? key}) : super(key: key);

  @override
  _chat_main_listState createState() => _chat_main_listState();
}

class _chat_main_listState extends State<chat_main_list> {
  void initState() {
    super.initState();
    setState(() {});
  }

  List chatUsers = [
    {
      'username': "Fenil",
      'message': "hey, How are you?",
      'image':
          "https://images.unsplash.com/photo-1562174949-4591859cae0a?ixlib=rb-1.2.1&q=80&fm=jpg&crop=entropy&cs=tinysrgb&w=1080&fit=max",
      'time': "Now"
    },
    {
      'username': "Vaidehi",
      'message': "tommorow is our practical exam be ready",
      'image':
          "https://cdn.pixabay.com/photo/2020/12/15/16/25/clock-5834193__340.jpg",
      "time": "Yesterday"
    },
    {
      'username': "mahesh",
      'message': "Hey where are you?",
      'image':
          "https://cdn.pixabay.com/photo/2020/09/18/19/31/laptop-5582775_960_720.jpg",
      'time': "31 Mar"
    },
    {
      'username': "suresh",
      'message': "Busy! Call me in 20 mins",
      'image':
          "https://cdn.pixabay.com/photo/2020/12/09/09/27/women-5816861_960_720.jpg",
      'time': "28 Mar"
    },
    {
      'username': "ramesh",
      'message': "Thankyou, It's awesome",
      'image':
          "https://cdn.pixabay.com/photo/2019/11/05/00/53/cellular-4602489_960_720.jpg",
      'time': "23 Mar"
    },
    {
      'username': "hey",
      'message': "will update you in evening",
      'image':
          "https://cdn.pixabay.com/photo/2017/02/12/10/29/christmas-2059698_960_720.jpg",
      'time': "17 Mar"
    },
    {
      'username': "Andrey Jones",
      'message':
          "Can you please share the file? helolomfwoefwefkjeasmrjmfjrekfmejmrejrfmejkmerkmf",
      'image':
          "https://cdn.pixabay.com/photo/2020/01/29/17/09/snowboard-4803050_960_720.jpg",
      'time': "24 Feb"
    },
    {
      'username': "John Wick",
      'message': "How are you?",
      'image':
          "https://cdn.pixabay.com/photo/2020/02/06/20/01/university-library-4825366_960_720.jpg",
      'time': "18 Feb"
    },
    {
      'username': "rob starc",
      'message': "Can you please share the file?",
      'image':
          "https://cdn.pixabay.com/photo/2020/01/29/17/09/snowboard-4803050_960_720.jpg",
      'time': "24 Feb"
    },
    {
      'username': "John Wick",
      'message': "How are you?",
      'image':
          "https://cdn.pixabay.com/photo/2020/02/06/20/01/university-library-4825366_960_720.jpg",
      'time': "18 Feb"
    },
    {
      'username': "eddard stark",
      'message': "Can you please share the file?",
      'image':
          "https://cdn.pixabay.com/photo/2020/01/29/17/09/snowboard-4803050_960_720.jpg",
      'time': "24 Feb"
    },
    {
      'username': "John snow",
      'message': "How are you?",
      'image':
          "https://cdn.pixabay.com/photo/2020/02/06/20/01/university-library-4825366_960_720.jpg",
      'time': "18 Feb"
    },
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Padding(
          padding: const EdgeInsets.only(left: 15.0, top: 20.0),
          child: Text("Chats",
              style: TextStyle(
                  fontSize: 27,
                  color: Colors.black,
                  fontWeight: FontWeight.bold)),
        ),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 15.0, top: 18.0),
            child: IconButton(
                onPressed: () {},
                icon: Icon(Icons.more_vert, color: Colors.black)),
          )
        ],
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Container(
          color: new Color(0xFFECEFF1),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: chatUsers.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 10, right: 10),
                          child: ListTile(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => individualChat(
                                      username: chatUsers[index]['username'],
                                      profile: chatUsers[index]['image']),
                                ),
                              );
                            },
                            title: Column(
                              children: [
                                Container(
                                  height: 90,
                                  child: Row(children: [
                                    Column(children: [
                                      Container(
                                        //color: Colors.blue,
                                        width:
                                            MediaQuery.of(context).size.width /
                                                5,
                                        // height: 70,
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(top: 15.0),
                                          child: CircleAvatar(
                                            radius: 30,
                                            child: ClipOval(
                                              child: Image.network(
                                                  chatUsers[index]['image'],
                                                  width: 60,
                                                  height: 60,
                                                  fit: BoxFit.cover),
                                            ),
                                          ),
                                        ),
                                      )
                                    ]),
                                    Padding(
                                      padding: EdgeInsets.only(left: 10),
                                      child: Column(children: [
                                        Container(
                                          //color: Colors.yellow,
                                          padding: EdgeInsets.only(top: 20),
                                          height: 90,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              2,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(chatUsers[index]['username'],
                                                  style: TextStyle(
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.w500)),
                                              Padding(
                                                padding:
                                                    EdgeInsets.only(top: 5.0),
                                                child: Text(
                                                  chatUsers[index]['message'],
                                                  style: TextStyle(
                                                      color: Colors.black
                                                          .withOpacity(0.6),
                                                      fontSize: 12),
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  maxLines: 1,
                                                ),
                                              ),
                                            ],
                                          ),
                                        )
                                      ]),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 20, bottom: 22.0),
                                      child: CircleAvatar(
                                          radius: 10, child: Text("1")),
                                    )
                                  ]),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    );
                  })
            ],
          ),
        ),
      ),
    );
  }
}
