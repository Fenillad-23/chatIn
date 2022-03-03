import 'package:flutter/material.dart';

class individualChat extends StatefulWidget {
  late String? username;
  individualChat({Key? key, this.username}) : super(key: key);

  @override
  State<individualChat> createState() => _individualChatState();
}

class _individualChatState extends State<individualChat> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.username.toString()),
        ),
        body: SafeArea(
          child: Column(
            children: [Text("hello")],
          ),
        ));
  }
}
