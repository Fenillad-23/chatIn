import 'dart:convert';
import 'dart:io';
import 'package:chattin/HomeScreen/UserProfileMain/EditProfile/resetPassword.dart';
import 'package:chattin/HomeScreen/UserProfileMain/UserProfileMain.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../../Network/network_dio.dart';

class editProfile extends StatefulWidget {
  String? username;
  editProfile({Key? key, this.username}) : super(key: key);

  @override
  _editProfileState createState() => _editProfileState();
}

class _editProfileState extends State<editProfile> {
  final ImagePicker _picker = ImagePicker();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  NetworkRepository nw = NetworkRepository();
  TextEditingController bioController = TextEditingController();
  TextEditingController fullNameController = TextEditingController();

  List<XFile>? images = [];
  XFile? image;
  String? get_email, get_contact, username, fullName, profile, bio;
  bool _load = false;
  @override
  void initState() {
    super.initState();
    setState(() {});
    get();
  }

  editInformation() async {
    var uri = Uri.parse(
        "http://chatin-env.eba-muyjrq8b.ap-south-1.elasticbeanstalk.com/user/editprofile");
    var request = http.MultipartRequest(
      "PATCH",
      Uri.parse("$uri"),
    );
    if (_load == true) {
      request.files
          .add(await http.MultipartFile.fromPath("image", image!.path));
      request.fields['bio'] = bioController.text.toString().trim() == ''
          ? bio.toString()
          : bioController.text.toString().trim();
      request.fields['name'] = fullNameController.text.toString().trim() == ''
          ? fullName.toString()
          : fullNameController.text.toString().trim();
      request.fields['username'] = username.toString();
      print("1");
    } else if (_load == false) {
      request.fields['bio'] = bioController.text.toString().trim() == ''
          ? bio.toString()
          : bioController.text.toString().trim();
      request.fields['name'] = fullNameController.text.toString().trim() == ''
          ? fullName.toString()
          : fullNameController.text.toString().trim();
      request.fields['username'] = username.toString();
      print("2");
    }

    print(request.fields['bio']);
    print(request.fields['name']);
    // print("-----------${image!.path}");
    var response = await request.send();
    print('Response: $response');
    var responseData = await response.stream.toBytes();
    var responseString = String.fromCharCodes(responseData);
    var msg = await json.decode(responseString);
    if (response.statusCode == 200) {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => UserProfileMain()),
          (route) => false);
      print("Done");
      // get();
    } else {
      print(response.statusCode);
    }
  }

  bool? darkthemeState;
  get() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    username = sharedPreferences.getString("username");
    darkthemeState = sharedPreferences.getBool("lightTheme");
    dynamic response =
        await nw.httpPost("post/getUserAccountDetails", {'postedBy': username});
    if (response['statusCode'] != null &&
        (response['statusCode'] == 200 || response['statusCode'] == "200")) {
      fullName = response['result'][0]['name'] != null
          ? response['result'][0]['name']
          : "Enter full Name";
      get_email = response['result'][0]['email'];
      get_contact = response['result'][0]['contactNo'];
      profile = response['result'][0]['profilepicture'].length != 0
          ? response['result'][0]['profilepicture']
          : '';
      bio = response['result'][0]['bio'] != null
          ? response['result'][0]['bio']
          : "Enter bio";
      setState(() {});
    } else {
      print(response['message']);
    }
    setState(() {});
  }

  selectImage() async {
    image = await _picker.pickImage(source: ImageSource.gallery);
    _load = true;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height / 4,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    borderRadius: new BorderRadius.only(
                        bottomLeft: Radius.circular(130.0),
                        bottomRight: Radius.circular(130.0)),
                    color: Colors.blue,
                  ),
                ),
                Column(
                  children: [
                    SizedBox(
                      height: 30,
                    ),
                    Row(children: [
                      new IconButton(
                        icon: new Icon(Icons.arrow_back, color: Colors.white),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ]),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(username.toString(),
                            style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.w400,
                                color: Colors.white))
                      ],
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _load != false
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(100),
                                child: Image.file(File(image!.path),
                                    width: 90, height: 90, fit: BoxFit.cover),
                              )
                            : ClipRRect(
                                borderRadius: BorderRadius.circular(100),
                                child: profile.toString() != 'null'
                                    ? Image.network(profile!,
                                        width: 90,
                                        height: 90,
                                        fit: BoxFit.cover)
                                    : ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(100),
                                        child: Image.asset(
                                            'assets/images/user.jpeg',
                                            width: 90,
                                            height: 90,
                                            fit: BoxFit.cover),
                                      ),
                              ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                    onPressed: () {
                      selectImage();
                    },
                    child: Text("Change Your Profile",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w400)))
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(25.0),
              child: Column(
                children: [
                  TextFormField(
                    controller: fullNameController,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.person),
                      alignLabelWithHint: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(9),
                      ),
                      // labelText: 'Full Name',
                      hintText: fullName,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: bioController,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.create),
                      alignLabelWithHint: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(9),
                      ),
                      // labelText: 'Bio',
                      hintText: bio,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    readOnly: true,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.email),
                      alignLabelWithHint: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(9),
                      ),
                      hintText: get_email,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    readOnly: true,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.phone),
                      alignLabelWithHint: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(9),
                      ),
                      hintText: get_contact,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        border: Border.all(color: Colors.grey, width: 1)),
                    child: Material(
                      color: Colors.white.withOpacity(0.0),
                      child: GestureDetector(
                        onTap: () {
                          print("ok");
                        },
                        child: InkWell(
                          onTap: () {
                            print("OK");
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        resetPassword(email: get_email)));
                          },
                          child: Ink(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(23, 15, 0, 15),
                                  child: Text("Change Password",
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400)),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(right: 15),
                                  child: Icon(Icons.arrow_forward_ios_rounded,
                                      size: 20,
                                      color: darkthemeState == true
                                          ? Colors.white
                                          : Colors.black),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  Container(
                    height: 50,
                    width: MediaQuery.of(context).size.width,
                    child: ElevatedButton(
                      onPressed: () {
                        editInformation();
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(28.5),
                        ),
                      ),
                      child: Text(
                        "Save",
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
