import 'package:chattin/HomeScreen/UserProfile/UserProfile.dart';
import 'package:chattin/Network/network_dio.dart';
import 'package:flutter/material.dart';

class SearchUser extends StatefulWidget {
  const SearchUser({Key? key}) : super(key: key);

  @override
  _SearchUserState createState() => _SearchUserState();
}

class _SearchUserState extends State<SearchUser> {
  NetworkRepository nw = new NetworkRepository();
  late TextEditingController _textController = new TextEditingController();
  String image =
      "https://images.unsplash.com/photo-1488426862026-3ee34a7d66df?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=MnwyMDg4MDd8MHwxfHNlYXJjaHwyM3x8cGVvcGxlfGVufDB8fHx8MTY0Mzg2MTUwOA&ixlib=rb-1.2.1&q=80&w=1080";
  String fname = "fenil lad";
  List loadUserList = [];

  // searchdata() async {
  //   dynamic response = await nw.httpPost(
  //     'User/search',
  //     {
  //       'username': _textController.text.toString(),
  //     },
  //   );
  //   Map search_data = {
  //     'username': _textController.text.toString(),
  //   };
  //   print('\x1b[95m ----$search_data');
  //   if (response != null &&
  //       (response['statusCode'] == 200 || response['statusCode'] == '200')) {
  //     print("\x1b[95m ----$response");
  //     loadUserList = response;
  //     print(loadUserList);
  //   } else {
  //     ScaffoldMessenger.of(context).showSnackBar(SnackBar(
  //       content: Text(response['message'].toString()),
  //       action: SnackBarAction(
  //         label: '',
  //         textColor: Colors.white,
  //         onPressed: () {},
  //       ),
  //       behavior: SnackBarBehavior.floating,
  //       shape: RoundedRectangleBorder(
  //         borderRadius: BorderRadius.circular(24),
  //       ),
  //       backgroundColor: Colors.blue,
  //     ));
  //   }
  // }

  getdata() async {
    dynamic getUserId = await nw.httpGet('User/find');
    loadUserList = getUserId;
    print(loadUserList);
    setState(() {});
    // return loadUserList;
  }

  @override
  void initState() {
    super.initState();
    getdata();
  }

  List _searchResult = [];
  onSearchTextChanged(String text) async {
    _searchResult.clear();
    if (text.isEmpty) {
      setState(() {});
      return;
    }

    loadUserList.forEach((userDetail) {
      if (userDetail['username'].toLowerCase().contains(text.toLowerCase())) {
        _searchResult.add(userDetail);
      }
      setState(() {});
    });

    // setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // The search area here
        title: Container(
          width: double.infinity,
          height: 40,
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(5)),
          child: Center(
            child: TextFormField(
              controller: _textController,
              onChanged: (text) {
                onSearchTextChanged(_textController.text);
              },
              decoration: InputDecoration(
                  prefixIcon:
                      IconButton(icon: Icon(Icons.search), onPressed: () {}),
                  suffixIcon: IconButton(
                    icon: Icon(Icons.clear),
                    onPressed: () {
                      this.setState(() {
                        _textController.clear(); //Clear value
                      });
                    },
                  ),
                  hintText: 'Search User',
                  border: InputBorder.none),
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 20, left: 05),
        // child: listView(datalist: _searchResult),
        child: _searchResult.length != 0
            ? listView(datalist: _searchResult)
            : listView(datalist: loadUserList),
      ),
    );
  }

  Widget listView({List? datalist}) {
    return ListView.builder(
        itemCount: datalist!.length,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.only(left: 10, right: 10),
            child: ListTile(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => UserProfile(
                      userName: datalist[index]['username'],
                    ),
                  ),
                );
              },
              title: Column(
                children: [
                  Container(
                    height: 70,
                    child: Row(children: [
                      Column(children: [
                        Container(
                          //color: Colors.blue,
                          width: MediaQuery.of(context).size.width / 5,
                          // height: 70,
                          child: CircleAvatar(
                            radius: 30,
                            child: ClipOval(
                              child: Image.network(image,
                                  width: 60, height: 60, fit: BoxFit.cover),
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
                            height: 70,
                            width: MediaQuery.of(context).size.width / 2,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(datalist[index]['username'],
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w500)),
                                Container(
                                    padding: EdgeInsets.fromLTRB(2, 5, 0, 0),
                                    child: Text(fname,
                                        style: TextStyle(
                                            color:
                                                Colors.black.withOpacity(0.6),
                                            fontSize: 12))),
                              ],
                            ),
                          )
                        ]),
                      )
                    ]),
                  ),
                  Divider(),
                ],
              ),
            ),
          );
        });
  }
}
