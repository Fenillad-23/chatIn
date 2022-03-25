import 'package:chattin/HomeScreen/Storybar/UploadStory.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:chattin/Network/network_dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StoryBarWidget extends StatefulWidget {
  const StoryBarWidget({Key? key}) : super(key: key);

  @override
  _StoryBarWidgetState createState() => _StoryBarWidgetState();
}

class _StoryBarWidgetState extends State<StoryBarWidget> {
  @override
  void initState() {
    super.initState();
    sendName();
  }

  List loadStories = [];

  void sendName() async {
    NetworkRepository nw = NetworkRepository();
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.getString('username');
    dynamic response = await nw.httpPost("story/storyhomePage",
        {"username": sharedPreferences.getString('username')});
    if (response['statusCode'] != null && response['statusCode'] == 200 ||
        response['statusCode'] == "200") {
      print(
          "story data-----------------------------${response["userstories"][0]}");
      loadStories.addAll(response['userstories']);
      print("..........." + loadStories[0]['image']);
      setState(() {});
      // print(loadStories[0]['userstories']['image'][0]);
    }
  }

  // List loadDetails = [
  // 'https://cdn.pixabay.com/photo/2019/03/15/09/49/girl-4056684_960_720.jpg',
  // 'https://cdn.pixabay.com/photo/2020/12/15/16/25/clock-5834193__340.jpg',
  // 'https://cdn.pixabay.com/photo/2020/09/18/19/31/laptop-5582775_960_720.jpg',
  // 'https://media.istockphoto.com/photos/woman-kayaking-in-fjord-in-norway-picture-id1059380230?b=1&k=6&m=1059380230&s=170667a&w=0&h=kA_A_XrhZJjw2bo5jIJ7089-VktFK0h0I4OWDqaac0c=',
  // 'https://cdn.pixabay.com/photo/2019/11/05/00/53/cellular-4602489_960_720.jpg',
  // 'https://cdn.pixabay.com/photo/2017/02/12/10/29/christmas-2059698_960_720.jpg',
  // 'https://cdn.pixabay.com/photo/2020/01/29/17/09/snowboard-4803050_960_720.jpg',
  // 'https://cdn.pixabay.com/photo/2020/02/06/20/01/university-library-4825366_960_720.jpg',
  // 'https://cdn.pixabay.com/photo/2020/11/22/17/28/cat-5767334_960_720.jpg',
  // 'https://cdn.pixabay.com/photo/2020/12/13/16/22/snow-5828736_960_720.jpg',
  // 'https://cdn.pixabay.com/photo/2020/12/09/09/27/women-5816861_960_720.jpg',
  // ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Padding(
        padding: const EdgeInsets.only(left: 10.0),
        child: Row(
          children: <Widget>[
            Column(
              children: <Widget>[
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                      //shape: BoxShape.circle,
                      borderRadius: BorderRadius.circular(22.0),
                      color: Color.fromARGB(255, 174, 175, 179)),
                  child: Center(
                    child: IconButton(
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => upload()));
                      },
                      icon: Icon(
                        Icons.add,
                        size: 33,
                      ),
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
            Row(
                children: List.generate(loadStories.length, (index) {
              return Column(
                children: <Widget>[
                  Container(
                    width: 60,
                    height: 60,
                    child: Stack(
                      children: <Widget>[
                        // Container(
                        //   decoration: BoxDecoration(
                        //       //shape: BoxShape.circle,
                        //       borderRadius: BorderRadius.circular(22.0),
                        //       border: Border.all(
                        //           color: Colors.blueAccent, width: 3)),
                        //   child: Padding(
                        //     padding: const EdgeInsets.all(0.0),
                        //     child: Container(
                        //       width: 75,
                        //       height: 75,
                        //       decoration: BoxDecoration(
                        //           //shape: BoxShape.circle,
                        //           borderRadius: BorderRadius.circular(18.5),
                        //           image: DecorationImage(
                        //               image: NetworkImage(loadStories[0]),
                        //               fit: BoxFit.cover)),
                        // ),
                        // ),
                        // )

                        // storyList[index]['isOnline']
                        //     ? Positioned(
                        //         top: 38,
                        //         left: 42,
                        //         child: Container(
                        //           width: 20,
                        //           height: 20,
                        //           decoration: BoxDecoration(
                        //               color: Color(0xFF66BB6A),
                        //               shape: BoxShape.circle,
                        //               border: Border.all(
                        //                   color: Color(0xFFFFFFFF), width: 3)),
                        //         ),
                        //       )
                        //     : Container()
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    width: 75,
                    child: Align(
                        child: Text(
                      "",
                      overflow: TextOverflow.ellipsis,
                    )),
                  )
                ],
              );
            }))
          ],
        ),
      ),
    );
  }
}
