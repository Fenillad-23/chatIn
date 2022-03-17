import 'package:chattin/HomeScreen/UserProfileMain/UserProfileMain.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../Network/network_dio.dart';
import '../UserProfile/UserProfile.dart';

class followingList extends StatefulWidget {
  String? Name;
  followingList({Key? key, this.Name}) : super(key: key);

  @override
  State<followingList> createState() => _followingListState();
}

class _followingListState extends State<followingList> {
  int? i;
  List loadUserList = [];
  List dataList = [];
  List data = [];
  NetworkRepository nw = NetworkRepository();
  String? username;

  @override
  void initState() {
    super.initState();
    getDetails();
  }

  getdata() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    username = sharedPreferences.getString('username');
    dynamic getUserId = await nw.httpGet('User/find');
    loadUserList = getUserId;
    for (int i = 0; i < dataList.length; i++) {
      String s = dataList[i].toString();
      loadUserList.forEach((userDetail) {
        if (userDetail['username'].toString().contains(s)) {
          data.add(userDetail);
        }
      });
    }
    print("---------$data");
    setState(() {});
  }

  getDetails() async {
    dynamic response = await nw.httpPost(
        "post/getUserAccountDetails", {'postedBy': widget.Name.toString()});
    if (response['statusCode'] != null &&
        (response['statusCode'] == 200 || response['statusCode'] == "200")) {
      // print('\x1b[93m --- $response');
      dataList = response['result'][0]['following'];
      setState(() {});
      getdata();
    } else {
      print(response['message']);
    }
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
        elevation: 0,
        title: Text(
          'Following',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
        color: new Color(0xFFECEFF1),
        child: ListView.builder(
          itemCount: data.length,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return Padding(
              padding: EdgeInsets.only(left: 0, right: 0),
              child: ListTile(
                onTap: () {
                  if (data[index]['username'] == username) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => UserProfileMain()),
                    );
                  } else {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => UserProfile(
                          userName: data[index]['username'],
                        ),
                      ),
                    );
                  }
                },
                title: Column(
                  children: [
                    Container(
                      height: 70,
                      child: Row(
                        children: [
                          Column(
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width / 5,
                                // height: 70,
                                child: CircleAvatar(
                                  radius: 30,
                                  child: ClipOval(
                                    child: Image.network(
                                        data[index]['profilepicture'],
                                        width: 60,
                                        height: 60,
                                        fit: BoxFit.cover),
                                  ),
                                ),
                              )
                            ],
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 10),
                            child: Column(
                              children: [
                                Container(
                                  padding: EdgeInsets.only(top: 10),
                                  height: 70,
                                  width:
                                      MediaQuery.of(context).size.width / 2.8,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(data[index]['username'],
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.w500)),
                                      Container(
                                        padding:
                                            EdgeInsets.fromLTRB(2, 5, 0, 0),
                                        child: Text(
                                          data[index]['name'],
                                          style: TextStyle(
                                              color:
                                                  Colors.black.withOpacity(0.6),
                                              fontSize: 12),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Divider(),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
