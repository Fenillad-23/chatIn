import 'package:chattin/HomeScreen/UserProfile/UserProfile.dart';
import 'package:chattin/Network/network_dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_qr_bar_scanner/qr_bar_scanner_camera.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ScanQRCode extends StatefulWidget {
  const ScanQRCode({Key? key}) : super(key: key);

  @override
  State<ScanQRCode> createState() => _ScanQRCodeState();
}

class _ScanQRCodeState extends State<ScanQRCode> {
  String? _qrInfo = 'Scan a QR/Bar code';
  bool camState = false;
  bool? darkthemeState;
  String? username;
  NetworkRepository nw = NetworkRepository();
  List UserList = [];
  List Data = [];
  String? profile, uprofile, name, uname;

  qrCallback(String? code) {
    setState(() {
      camState = false;
      _qrInfo = code;
      getdata();
    });
  }

  @override
  void initState() {
    super.initState();
    setThemeState();
    setState(() {
      camState = true;
    });
  }

  @override
  void setThemeState() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    darkthemeState = sharedPreferences.getBool("lightTheme");
    username = sharedPreferences.getString("username");
    setState(() {});
  }

  getdata() async {
    dynamic getUserId = await nw.httpGet('User/find');

    UserList = getUserId;

    for (int j = 0; j < UserList.length; j++) {
      if (_qrInfo == UserList[j]['username']) {
        name = UserList[j]['username'];
        profile = UserList[j]['profilepicture'];
      } else if (username == UserList[j]['username']) {
        uname = UserList[j]['username'];
        uprofile = UserList[j]['profilepicture'];
      } else {}
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "QR Code",
          style: TextStyle(
              color: darkthemeState == true ? Colors.white : Colors.black),
        ),
        backgroundColor:
            darkthemeState == true ? Colors.black54 : Colors.transparent,
        elevation: 0,
        leading: new IconButton(
          icon: new Icon(Icons.arrow_back,
              color: darkthemeState == true ? Colors.white : Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      // backgroundColor: Color.fromARGB(255, 221, 219, 219),
      body: camState
          ? Center(
              child: Container(
                color: Colors.blue,
                height: MediaQuery.of(context).size.height / 2.5,
                width: MediaQuery.of(context).size.width / 1.3,
                child: QRBarScannerCamera(
                  onError: (context, error) => Text(
                    error.toString(),
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.red),
                  ),
                  qrCodeCallback: (code) {
                    qrCallback(code);
                  },
                ),
              ),
            )
          : Center(
              child: Container(
                height: MediaQuery.of(context).size.height / 2.5,
                width: MediaQuery.of(context).size.width / 1.3,
                child: Card(
                  elevation: 8,
                  shape: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  shadowColor: Color.fromRGBO(255, 255, 255, 1),
                  child: Center(
                    child: Container(
                      // color: Colors.blsue,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(32.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  children: [
                                    ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(100),
                                        child: uprofile.toString() == "null"
                                            ? Image.asset(
                                                'assets/images/user.jpeg',
                                                width: 90,
                                                height: 90,
                                                fit: BoxFit.cover)
                                            : Image.network('$uprofile',
                                                width: 90,
                                                height: 90,
                                                fit: BoxFit.cover)),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      uname == null ? ' ' : uname.toString(),
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(100),
                                        child: profile.toString() == "null"
                                            ? Image.asset(
                                                'assets/images/user.jpeg',
                                                width: 90,
                                                height: 90,
                                                fit: BoxFit.cover)
                                            : Image.network('$profile',
                                                width: 90,
                                                height: 90,
                                                fit: BoxFit.cover)),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      name == null
                                          ? 'User not found'
                                          : name.toString(),
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Spacer(),
                          Container(
                            height: 50,
                            width: MediaQuery.of(context).size.width / 2,
                            child: name == null
                                ? Text(' ')
                                : ElevatedButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => UserProfile(
                                            userName: name,
                                          ),
                                        ),
                                      );
                                    },
                                    style: ElevatedButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(28.5),
                                      ),
                                    ),
                                    child: Text(
                                      "View Profile",
                                      style: TextStyle(fontSize: 18),
                                    ),
                                  ),
                          ),
                          SizedBox(
                            height: 40,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
    );
  }
}
