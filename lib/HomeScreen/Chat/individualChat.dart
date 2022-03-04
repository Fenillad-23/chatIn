import 'package:flutter/material.dart';

class individualChat extends StatefulWidget {
  late String? username;
  late String? profile;
  individualChat({Key? key, this.username, this.profile}) : super(key: key);

  @override
  State<individualChat> createState() => _individualChatState();
}

class _individualChatState extends State<individualChat> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Row(
            children: [
              CircleAvatar(
                radius: 20,
                child: Image.network(widget.profile.toString(),
                    height: 32, width: 32),
              ),
              Text(widget.username.toString()),
            ],
          ),
          actions: [],
        ),
        body: SafeArea(
          child: Column(
            children: [Text("hello")],
          ),
        ));
  }
}
