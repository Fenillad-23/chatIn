import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../Splash_Screen/onBoarding.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';

class Setting extends StatefulWidget {
  Setting({Key? key}) : super(key: key);

  @override
  _SettingState createState() => _SettingState();
}

class LocalAuthApi {
  static final _auth = LocalAuthentication();
  static Future<bool> hasBiometrics() async {
    try {
      return await _auth.canCheckBiometrics;
    } on PlatformException catch (e) {
      return false;
    }
  }
}

class _SettingState extends State<Setting> {
  bool Notification = false;
  bool? Fingerprint;
  String dropdownvalue = 'Default';
  late bool lightTheme;
  // List of items in our dropdown menu
  var items = [
    'Default',
    'Slabo',
    'DancingScript',
  ];

  void initState() {
    super.initState();
    verify();
    setDefaults();
    setThemeState();
    setState(() {});
  }

  bool? darkthemeState;
  void setThemeState() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    darkthemeState = sharedPreferences.getBool("lightTheme")!;
    setState(() {});
    // print(sharedPreferences.getBool("lightTheme"));
  }

  setDefaults() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    if (sharedPreferences.getBool('lightTheme') == true) {
      lightTheme = true;
    } else {
      lightTheme = false;
    }
    setState(() {});
  }

  setFontStyle() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString('fontFamily', dropdownvalue);
    print(dropdownvalue);
  }

  verify() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    if (sharedPreferences.getBool('fingerprint') == true) {
      Fingerprint = true;
    } else {
      Fingerprint = false;
    }
    setState(() {});
  }

  EnableFingerPrint() async {
    LocalAuthApi.hasBiometrics();
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setBool("fingerprint", Fingerprint!);
    setState(() {});
  }

  changeTheme(bool val) async {
    lightTheme = val;
    print(val);
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setBool("lightTheme", lightTheme);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Settings",
          style:
              TextStyle(color: darkthemeState! ? Colors.white : Colors.black),
        ),
        backgroundColor: darkthemeState! ? Colors.black54 : Colors.transparent,
        elevation: 0,
        leading: new IconButton(
          icon: new Icon(Icons.arrow_back,
              color: darkthemeState! ? Colors.white : Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(25.0),
          color: darkthemeState! ? Colors.black54 : new Color(0xFFECEFF1),
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              Container(
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text("Account",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w500))
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Card(
                      elevation: 8,
                      shape: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      // shadowColor: Colors.grey[800],
                      child: Material(
                        color: Colors.white.withOpacity(0.0),
                        child: InkWell(
                          onTap: () {},
                          child: Ink(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(23, 15, 0, 15),
                                  child: Text("Liked Post",
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500)),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(right: 15),
                                  child: Icon(Icons.arrow_forward_ios_rounded,
                                      size: 20, color: Colors.black),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Card(
                      elevation: 8,
                      shape: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      // shadowColor: Colors.grey[800],
                      child: Material(
                        color: Colors.white.withOpacity(0.0),
                        child: InkWell(
                          onTap: () {},
                          child: Ink(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(23, 15, 0, 15),
                                  child: Text("Actions",
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500)),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(right: 15),
                                  child: Icon(Icons.arrow_forward_ios_rounded,
                                      size: 20, color: Colors.black),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Text("Preferences",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w500))
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Card(
                      elevation: 8,
                      shape: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      // shadowColor: Colors.grey[800],
                      child: Material(
                        color: Colors.white.withOpacity(0.0),
                        child: InkWell(
                          onTap: () {},
                          child: Ink(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(23, 15, 0, 15),
                                  child: Text("Fonts",
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500)),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(right: 20),
                                  child: DropdownButton(
                                    value: dropdownvalue,
                                    icon: const Icon(Icons.keyboard_arrow_down),
                                    items: items.map((String items) {
                                      return DropdownMenuItem(
                                        value: items,
                                        child: Text(
                                          items,
                                          style: TextStyle(fontFamily: items),
                                        ),
                                      );
                                    }).toList(),
                                    onChanged: (String? newValue) {
                                      setState(() {
                                        dropdownvalue = newValue!;
                                        setFontStyle();
                                        // Restart.restartApp();
                                        RestartWidget.restartApp(context);
                                      });
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Card(
                      elevation: 8,
                      shape: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      // shadowColor: Colors.grey[800],
                      child: Material(
                        color: Colors.white.withOpacity(0.0),
                        child: InkWell(
                          onTap: () {},
                          child: Ink(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(23, 15, 0, 15),
                                  child: Text("Dark Mode",
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500)),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(right: 13),
                                  child: FlutterSwitch(
                                    value: lightTheme,
                                    height: 25,
                                    width: 50,
                                    onToggle: (val) {
                                      setState(() {
                                        lightTheme = !lightTheme;
                                        changeTheme(lightTheme);
                                        RestartWidget.restartApp(context);
                                      });
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Card(
                      elevation: 8,
                      shape: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      // shadowColor: Colors.grey[800],
                      child: Material(
                        color: Colors.white.withOpacity(0.0),
                        child: InkWell(
                          onTap: () {},
                          child: Ink(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(23, 15, 0, 15),
                                  child: Text("Notifications",
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500)),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(right: 13),
                                  child: FlutterSwitch(
                                    value: Notification,
                                    height: 25,
                                    width: 50,
                                    onToggle: (val) {
                                      setState(() {
                                        Notification = val;
                                      });
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Text("Security",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w500))
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Card(
                      elevation: 8,
                      shape: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      // shadowColor: Colors.grey[800],
                      child: Material(
                        color: Colors.white.withOpacity(0.0),
                        child: InkWell(
                          onTap: () {},
                          child: Ink(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(23, 15, 0, 15),
                                  child: Text("Fingerprint",
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500)),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(right: 13),
                                  child: FlutterSwitch(
                                    value: Fingerprint!,
                                    height: 25,
                                    width: 50,
                                    onToggle: (val) {
                                      setState(() {
                                        Fingerprint = val;
                                        EnableFingerPrint();
                                        print(Fingerprint);
                                      });
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Text("Log Out",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w500))
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Card(
                      elevation: 8,
                      shape: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      // shadowColor: Colors.grey[800],
                      child: Material(
                        color: Colors.white.withOpacity(0.0),
                        child: InkWell(
                          onTap: () {
                            LogOut();
                          },
                          child: Ink(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(23, 15, 0, 15),
                                  child: Text("Log Out",
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500)),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  LogOut() async {
    print("logout");
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.clear();
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => onBoarding()),
        (route) => false);
  }
}

class RestartWidget extends StatefulWidget {
  RestartWidget({required this.child});

  final Widget child;

  static void restartApp(BuildContext context) {
    context.findAncestorStateOfType<_RestartWidgetState>()?.restartApp();
  }

  @override
  _RestartWidgetState createState() => _RestartWidgetState();
}

class _RestartWidgetState extends State<RestartWidget> {
  Key key = UniqueKey();

  void restartApp() {
    setState(() {
      key = UniqueKey();
    });
  }

  @override
  Widget build(BuildContext context) {
    return KeyedSubtree(
      key: key,
      child: widget.child,
    );
  }
}
