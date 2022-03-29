import 'dart:convert';
import 'dart:io';
import 'package:chattin/HomeScreen/Home.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class upload extends StatefulWidget {
  const upload({Key? key}) : super(key: key);

  @override
  State<upload> createState() => _uploadState();
}

class _uploadState extends State<upload> {
  @override
  void initState() {
    super.initState();
    selectImage();
    setState(() {});
  }

  final ImagePicker _picker = ImagePicker();
  int currentIndex = 0;
  List<XFile>? images = [];
  void selectImage() async {
    final List<XFile>? selectedImage = await _picker.pickMultiImage();
    // if (selectedImage!.length > 1) {
    print("length${selectedImage!.length}");
    // }
    images!.addAll(selectedImage);
    setState(() {});
    print(images!.length);
  }

  Future upload(images) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var uri = Uri.parse(
        "http://chatin-env.eba-muyjrq8b.ap-south-1.elasticbeanstalk.com/story/createstory");
    var request = http.MultipartRequest(
      "POST",
      Uri.parse("$uri"),
    );
    for (var i = 0; i < images.length; i++) {
      request.files
          .add(await http.MultipartFile.fromPath("image", images[i].path));
      request.fields['postedBy'] =
          sharedPreferences.getString("username").toString();
    }
    var response = await request.send();
    print('Response: $response');
    var responseData = await response.stream.toBytes();
    var responseString = String.fromCharCodes(responseData);
    var msg = await json.decode(responseString);
    if (response.statusCode == 200) {
      print(responseString);
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => Home()));
    } else {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              itemCount: images!.length,
              onPageChanged: (int index) {
                setState(() {
                  currentIndex = index;
                });
              },
              itemBuilder: (_, i) {
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height,
                        child: Image.file(
                          File(images![i].path),
                          fit: BoxFit.cover,
                          //height: MediaQuery.of(context).size.height/2,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            height: 50,
            // color: Colors.white,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(15.0),
                  topLeft: Radius.circular(15.0)),
              color: Colors.white,
            ),
            child: TextButton(
              child: Text(
                "Upload Story",
                style: TextStyle(fontSize: 20, color: Colors.black),
              ),
              onPressed: () {
                upload(images);
              },
            ),
          ),
        ],
      ),
    );
  }
}
