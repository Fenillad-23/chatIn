import 'dart:async';

import 'package:flutter/material.dart';

// ignore: must_be_immutable
class individualChat extends StatefulWidget {
  late String? username;
  late String? profile;
  individualChat({Key? key, this.username, this.profile}) : super(key: key);

  @override
  State<individualChat> createState() => _individualChatState();
}

class _individualChatState extends State<individualChat> {
  // late bool userType;
  TextEditingController sendMessage = TextEditingController();
  ScrollController? scrollController;
  List messages = [
    {"messageContent": "Hello, bankim", "messageType": "receiver"},
    {"messageContent": "what's up", "messageType": "receiver"},
    {"messageContent": "nothing special", "messageType": "sender"},
    {"messageContent": "ehhhh, doing OK.", "messageType": "receiver"},
    {"messageContent": "Is there any thing wrong?", "messageType": "sender"},
  ];
  send() async {
    messages.add({
      "messageContent": sendMessage.text.toString(),
      "messageType": "sender"
    });
    sendMessage.clear();
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          title: Padding(
            padding: const EdgeInsets.only(top: 10.0, bottom: 8.0),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 15,
                  child: ClipOval(
                    child: Image.network(
                      widget.profile.toString(),
                      height: 30,
                      width: 30,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Text(
                    widget.username.toString(),
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.phone, color: Colors.black, size: 20),
              onPressed: () {},
            ),
            IconButton(
                onPressed: () {},
                icon: Icon(Icons.videocam_outlined,
                    color: Colors.black, size: 25)),
            IconButton(
                onPressed: () {},
                icon:
                    Icon(Icons.more_vert_sharp, color: Colors.black, size: 22))
          ],
        ),
        body: Stack(
          children: <Widget>[
            ListView.builder(
              // reverse: true,
              controller: scrollController,
              shrinkWrap: true,
              itemCount: messages.length,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return Container(
                  padding:
                      EdgeInsets.only(left: 16, right: 16, top: 10, bottom: 10),
                  child: Align(
                      alignment: (messages[index]['messageType'] == "receiver"
                          ? Alignment.topLeft
                          : Alignment.topRight),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(8),
                              topRight: Radius.circular(8),
                              bottomLeft: Radius.circular(8),
                              bottomRight: Radius.circular(8)),
                          color: (messages[index]["messageType"] == "receiver"
                              ? Colors.white
                              : Colors.blue[200]),
                        ),
                        padding: EdgeInsets.all(16),
                        child: Text(
                          messages[index]['messageContent'],
                          style: TextStyle(
                              fontSize: 15,
                              color:
                                  messages[index]['messageType'] == "receiver"
                                      ? Colors.black
                                      : Colors.white),
                        ),
                      )),
                );
              },
            ),
            Align(
              alignment: Alignment.bottomLeft,
              child: Container(
                padding: EdgeInsets.only(bottom: 10, top: 10),
                height: 65,
                width: MediaQuery.of(context).size.width,
                color: Colors.transparent,
                child: Row(
                  children: <Widget>[
                    SizedBox(
                      width: 15,
                    ),
                    Expanded(
                      child: TextFormField(
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.emoji_emotions_outlined),
                          fillColor: Colors.white,
                          filled: true,
                          suffixIcon: IconButton(
                            icon: Icon(
                              Icons.send,
                              color: Colors.blue,
                            ),
                            onPressed: () {
                              send();
                            },
                            color: Colors.black54,
                          ),
                          hintText: "Type a message",
                          hintStyle: TextStyle(color: Colors.black54),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25),
                            borderSide:
                                BorderSide(width: 0, style: BorderStyle.none),
                          ),
                        ),
                        controller: sendMessage,
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ));
  }
}
