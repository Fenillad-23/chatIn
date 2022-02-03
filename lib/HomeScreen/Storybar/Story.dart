import 'package:flutter/material.dart';

class StoryList extends StatefulWidget {
  const StoryList({Key? key}) : super(key: key);

  @override
  _StoryListState createState() => _StoryListState();
}

class StoryApiData {
  late String uname;
  late String imageUrl;
  late bool hasStory;

  StoryApiData(this.uname, this.imageUrl, this.hasStory);
}

class _StoryListState extends State<StoryList> {
  // ignore: must_call_super
  void initState() {
    //getdata();
  }

  // getdata() async {
  //   NetworkRepository nw = NetworkRepository();
  //   dynamic getUserData = await nw.httpGet('User/find');
  //   List<StoryApiData> storyList = [];
  //   for (var s in getUserData) {
  //     // StoryApiData data = StoryApiData(
  //     //     uname: s['uname'], imageUrl: s['image'], hasStory: s['hasStory']);
  //     // storyList.add(s);
  //   }
  //   return storyList;
  // }

  // StoryApiData obj = new StoryApiData("fenil","",true,false);
  _stories() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(right: 20),
            child: Column(
              children: <Widget>[
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle, color: Color(0xFFe9eaec)),
                  child: Center(
                    child: Icon(
                      Icons.add,
                      size: 33,
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                SizedBox(
                  width: 75,
                  child: Align(
                      child: Text(
                    'Your Story',
                    overflow: TextOverflow.ellipsis,
                  )),
                )
              ],
            ),
          ),
          Row(
              children: List.generate(storyList.length, (index) {
            return Padding(
              padding: const EdgeInsets.only(right: 20),
              child: Column(
                children: <Widget>[
                  Container(
                    width: 60,
                    height: 60,
                    child: Stack(
                        // children: <Widget>[
                        //   storyList[index]['hasStory']
                        //       ? Container(
                        //           decoration: BoxDecoration(
                        //               shape: BoxShape.circle,
                        //               border: Border.all(
                        //                   color: Colors.blueAccent, width: 3)),
                        //           child: Padding(
                        //             padding: const EdgeInsets.all(3.0),
                        //             child: Container(
                        //               width: 75,
                        //               height: 75,
                        //               decoration: BoxDecoration(
                        //                   shape: BoxShape.circle,
                        //                   image: DecorationImage(
                        //                       image: NetworkImage(
                        //                          " https://images.unsplash.com/photo-1547721064-da6cfb341d50"
                        //                           //storyList[index]['imageUrl']
                        //                           ),
                        //                       fit: BoxFit.cover)),
                        //             ),
                        //           ),
                        //         )
                        //       : Container(
                        //           width: 70,
                        //           height: 70,
                        //           decoration: BoxDecoration(
                        //               shape: BoxShape.circle,
                        //               image: DecorationImage(
                        //                   image: NetworkImage(
                        //                       " https://images.unsplash.com/photo-1547721064-da6cfb341d50"
                        //                       // storyList[index]['imageUrl']
                        //                       ),
                        //                   fit: BoxFit.cover)),
                        //         ),
                        // ],
                        ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    width: 75,
                    child: Align(
                        child: Text(
                      '',
                      //storyList[index]['uname'],
                      overflow: TextOverflow.ellipsis,
                    )),
                  )
                ],
              ),
            );
          }))
        ],
      ),
    );
  }

  List<StoryApiData> storyList = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.only(left: 20, right: 20, top: 15),
          child: ListView(
            children: [
              _stories(),
            ],
          ),
        ),
      ),
    );
  }
}
