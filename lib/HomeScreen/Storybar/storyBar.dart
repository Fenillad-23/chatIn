import 'package:flutter/material.dart';

import 'Story.dart';

class storyBar extends StatefulWidget {
  const storyBar({Key? key}) : super(key: key);

  @override
  _storyBarState createState() => _storyBarState();
}

class _storyBarState extends State<storyBar> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ChatIn",
            style: TextStyle(fontFamily: 'DancingScript', fontSize: 30)),
      ),
      body: StoryList(),
    );
  }
}
