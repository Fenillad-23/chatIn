import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:chattin/HomeScreen/Home.dart';
import 'package:chattin/Network/network_dio.dart';
import 'package:chattin/validation/validation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UploadImage extends StatefulWidget {
  const UploadImage({Key? key}) : super(key: key);

  @override
  _UploadImageState createState() => _UploadImageState();
}

class _UploadImageState extends State<UploadImage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController captionController = TextEditingController();
  int currentIndex = 0;
  late PageController _controller;
  final ImagePicker _picker = ImagePicker();
  List<XFile>? images = [];
  NetworkRepository nw = NetworkRepository();

  @override
  void initState() {
    selectedImage();
    super.initState();
    setState(() {});
  }

  redirect_to() async {
    Timer(Duration(seconds: 2), () {
      Navigator.pushAndRemoveUntil(context,
          MaterialPageRoute(builder: (context) => Home()), (route) => false);
    });
  }

  void selectedImage() async {
    final List<XFile>? selectedImage = await _picker.pickMultiImage();
    // List<XFile?> _videoFile = ImagePicker.pickVideo(source: ImageSource.gallery);
    if (selectedImage!.isNotEmpty) {
      if (selectedImage.length > 10) {
        showModalBottomSheet(
            backgroundColor: Colors.transparent,
            context: context,
            isScrollControlled: true,
            builder: (context) {
              return Padding(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Container(
                      height: 300,
                      width: MediaQuery.of(context).size.width,
                      decoration: new BoxDecoration(
                        color: Colors.white,
                        borderRadius: new BorderRadius.only(
                            topLeft: Radius.circular(25.0),
                            topRight: Radius.circular(25.0)),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              Lottie.asset("assets/json/false.json",
                                  height: 100),
                              SizedBox(height: 10),
                              Text("Upload failed",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500)),
                              SizedBox(height: 20),
                              Text(
                                  "You can't upload more than 10 images at a time",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.black.withOpacity(0.8),
                                      fontSize: 12)),
                              SizedBox(height: 20),
                              Container(
                                height: 50,
                                width: MediaQuery.of(context).size.width,
                                child: ElevatedButton(
                                  onPressed: () {
                                    Navigator.pushAndRemoveUntil(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                UploadImage()),
                                        (route) => false);
                                  },
                                  style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(28.5),
                                    ),
                                  ),
                                  child: Text(
                                    "Try Again",
                                    style: TextStyle(fontSize: 20),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              );
            });
      } else {
        images!.addAll(selectedImage);
      }
    }
    print("'\x1b[97m response :image length " + images!.length.toString());
    setState(() {});
  }

  Future upload(selectedImageList) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var uri = Uri.parse(
        "http://chatin-env.eba-muyjrq8b.ap-south-1.elasticbeanstalk.com/post/createpost");
    var request = http.MultipartRequest(
      "POST",
      Uri.parse("$uri"),
    );
    for (var i = 0; i < selectedImageList.length; i++) {
      request.files.add(await http.MultipartFile.fromPath(
          "image", selectedImageList[i].path));
      request.fields['username'] =
          sharedPreferences.getString("username").toString();
      request.fields['caption'] = captionController.text;
    }
    var response = await request.send();
    print('Response: $response');
    var responseData = await response.stream.toBytes();
    var responseString = String.fromCharCodes(responseData);
    var msg = await json.decode(responseString);
    if (response.statusCode == 200) {
      redirect_to();
      showModalBottomSheet(
          backgroundColor: Colors.transparent,
          context: context,
          isScrollControlled: true,
          builder: (context) {
            return Padding(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Container(
                    height: 280,
                    width: MediaQuery.of(context).size.width,
                    decoration: new BoxDecoration(
                      color: Colors.white,
                      borderRadius: new BorderRadius.only(
                          topLeft: Radius.circular(25.0),
                          topRight: Radius.circular(25.0)),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        children: [
                          Lottie.asset("assets/json/true.json", height: 150),
                          Text("Yay!! Post Uploaded",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w500)),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            );
          });
    } else {
      showModalBottomSheet(
          backgroundColor: Colors.transparent,
          context: context,
          isScrollControlled: true,
          builder: (context) {
            return Padding(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Container(
                    height: 300,
                    width: MediaQuery.of(context).size.width,
                    decoration: new BoxDecoration(
                      color: Colors.white,
                      borderRadius: new BorderRadius.only(
                          topLeft: Radius.circular(25.0),
                          topRight: Radius.circular(25.0)),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            Lottie.asset("assets/json/false.json", height: 100),
                            SizedBox(height: 10),
                            Text("Upload failed",
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.w500)),
                            SizedBox(height: 20),
                            Text(
                                "Your memories cannot be uploaded, check your internet connection and try again.",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.black.withOpacity(0.8),
                                    fontSize: 12)),
                            SizedBox(height: 20),
                            Container(
                              height: 50,
                              width: MediaQuery.of(context).size.width,
                              child: ElevatedButton(
                                onPressed: () {
                                  Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => UploadImage()),
                                      (route) => false);
                                },
                                style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(28.5),
                                  ),
                                ),
                                child: Text(
                                  "Try Again",
                                  style: TextStyle(fontSize: 20),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            );
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Upload Post",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        leading: new IconButton(
          icon: new Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
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
                      Stack(
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height - 134,
                            child: Image.file(
                              File(images![i].path),
                              fit: BoxFit.cover,
                              //height: MediaQuery.of(context).size.height/2,
                            ),
                          ),
                          Container(
                            height: MediaQuery.of(context).size.height - 150,
                            width: MediaQuery.of(context).size.width,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: List.generate(images!.length,
                                      (index) => buildDot(index, context)),
                                ),
                              ],
                            ),
                          )
                        ],
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
                "Upload Post",
                style: TextStyle(fontSize: 20, color: Colors.black),
              ),
              onPressed: () {
                showModalBottomSheet(
                    backgroundColor: Colors.transparent,
                    context: context,
                    isScrollControlled: true,
                    builder: (context) {
                      return Padding(
                        padding: EdgeInsets.only(
                            bottom: MediaQuery.of(context).viewInsets.bottom),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Container(
                              height: 280,
                              width: MediaQuery.of(context).size.width,
                              decoration: new BoxDecoration(
                                color: Colors.white,
                                borderRadius: new BorderRadius.only(
                                    topLeft: Radius.circular(25.0),
                                    topRight: Radius.circular(25.0)),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Form(
                                  key: _formKey,
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          Text("Add Caption",
                                              textAlign: TextAlign.left,
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.w500)),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 30,
                                      ),
                                      TextFormField(
                                        decoration: InputDecoration(
                                          prefixIcon:
                                              Icon(Icons.description_outlined),
                                          alignLabelWithHint: true,
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(9),
                                          ),
                                          labelText: 'Write a Caption',
                                          hintText:
                                              'Enter your caption here ...',
                                        ),
                                        controller: captionController,
                                      ),
                                      SizedBox(
                                        height: 50,
                                      ),
                                      Container(
                                        height: 50,
                                        width:
                                            MediaQuery.of(context).size.width,
                                        child: ElevatedButton(
                                          onPressed: () {
                                            if (_formKey.currentState!
                                                .validate()) {
                                              upload(images);
                                            }
                                          },
                                          style: ElevatedButton.styleFrom(
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(28.5),
                                            ),
                                          ),
                                          child: Text(
                                            "Upload",
                                            style: TextStyle(fontSize: 20),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      );
                    });
              },
            ),
          ),
        ],
      ),
    );
  }

  Container buildDot(int index, BuildContext context) {
    return Container(
      height: 10,
      width: currentIndex == index ? 25 : 10,
      margin: EdgeInsets.only(right: 5),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20), color: Colors.white),
    );
  }
}
