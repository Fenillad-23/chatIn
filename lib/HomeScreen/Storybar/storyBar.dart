import 'package:flutter/material.dart';
import 'package:stories_for_flutter/stories_for_flutter.dart';

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
            style: TextStyle(fontSize: 30, fontFamily: 'sans-serif')),
      ),
      body: StoryList(),
    );
  }
}
