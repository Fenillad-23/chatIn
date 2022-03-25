import 'dart:convert';
import 'dart:io';

import 'package:chattin/HomeScreen/Home.dart';
import 'package:chattin/Network/network_dio.dart';
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
        ListView.builder(
          itemCount: images!.length,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return Container(
              // width: 50,
              height: 500,
              child: Image.file(
                File(images![index].path),
                fit: BoxFit.cover,
                //height: MediaQuery.of(context).size.height/2,
              ),
            );
          },
        ),
        SizedBox(height: 20),
        Container(
          height: 50,
          width: 150,
          child: OutlinedButton(
            child: Text("Add To Story",
                style: TextStyle(fontSize: 18, color: Colors.black)),
            onPressed: () {
              upload(images);
            },
            style: OutlinedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(28.5),
                ),
                side: BorderSide(
                  width: 2.0,
                  color: Colors.blue,
                  style: BorderStyle.solid,
                )),
          ),
        )
      ],
    ));
  }
}
