import 'dart:convert';
import 'dart:io';
import 'package:chattin/Network/network_dio.dart';
import 'package:chattin/validation/validation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

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

  void selectedImage() async {
    final List<XFile>? selectedImage = await _picker.pickMultiImage();
    if (selectedImage!.isNotEmpty) {
      images!.addAll(selectedImage);
    }
    print("'\x1b[97m response :image length " + images!.length.toString());
    setState(() {});
  }

  Future upload(selectedImageList) async {
    var uri = Uri.parse("http://192.168.29.170:3000/post/createpost");
    var request = http.MultipartRequest(
      "POST",
      Uri.parse("$uri"),
    );
    for (var i = 0; i < selectedImageList.length; i++) {
      request.files.add(await http.MultipartFile.fromPath(
          "image", selectedImageList[i].path));
      request.fields['username'] = 'fenil.23';
    }
    var response = await request.send();
    var responseData = await response.stream.toBytes();
    var responseString = String.fromCharCodes(responseData);
    var msg = await json.decode(responseString);
    if (response.statusCode == 200) {
      return msg;
    } else {
      return '';
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
                "Add Caption",
                style: TextStyle(fontSize: 20, color: Colors.black),
              ),
              onPressed: () {
                showModalBottomSheet(
                    context: context,
                    builder: (context) {
                      return SingleChildScrollView(
                        child: Padding(
                          padding: EdgeInsets.only(
                              bottom:
                                  MediaQuery.of(context).viewInsets.bottom),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Container(
                                height: 280,
                                width: MediaQuery.of(context).size.width,
                                color: Colors.white,
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
                                                    fontWeight:
                                                        FontWeight.w500)),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 30,
                                        ),
                                        TextFormField(
                                          decoration: InputDecoration(
                                            prefixIcon: Icon(
                                                Icons.account_circle_sharp),
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
                                          validator: (value) =>
                                              Validators.captionValidator(
                                                  value!.trim(), "caption"),
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
                        ),
                      );
                    });
              },
            ),
          ),
        ],
      ),
      // body: SafeArea(
      //   child: Column(
      //     children: [
      //       TextButton(
      //         onPressed: selectedImage,
      //         child: Text("select"),
      //       ),
      //       Expanded(
      //         child: Padding(
      //           padding: const EdgeInsets.all(18.0),
      //           child: GridView.builder(
      //               itemCount: images!.length,
      //               gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
      //                 crossAxisCount: 2,
      //                 crossAxisSpacing: 25,
      //                 mainAxisSpacing: 25,
      //               ),
      //               shrinkWrap: true,
      //               itemBuilder: (BuildContext context, int index) => GridTile(
      //                     child: ClipRRect(
      //                       borderRadius: BorderRadius.circular(18.0),
      //                       child: Image.file(
      //                         File(images![index].path),
      //                         fit: BoxFit.cover,
      //                       ),
      //                     ),
      //                   )),
      //         ),
      //       ),
      //       Padding(
      //         padding: const EdgeInsets.only(bottom: 28.0),
      //         child: TextButton(
      //           onPressed: () {
      //             upload(images);
      //           },
      //           child: Text("upload"),
      //         ),
      //       )
      //     ],
      //   ),
      // ),
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
