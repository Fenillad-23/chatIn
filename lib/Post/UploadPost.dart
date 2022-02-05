import 'dart:convert';
import 'dart:io';
import 'package:chattin/Network/network_dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

class UploadImage extends StatefulWidget {
  const UploadImage({Key? key}) : super(key: key);

  @override
  _UploadImageState createState() => _UploadImageState();
}

class _UploadImageState extends State<UploadImage> {
  final ImagePicker _picker = ImagePicker();
  List<XFile>? images = [];
  NetworkRepository nw = NetworkRepository();
  void selectedImage() async {
    final List<XFile>? selectedImage = await _picker.pickMultiImage();
    if (selectedImage!.isNotEmpty) {
      images!.addAll(selectedImage);
    }
    print("'\x1b[97m response :image length " + images!.length.toString());
    setState(() {});
  }

  Future upload(selectedImage) async {
    var uri = Uri.parse("http://192.168.29.232:3000/shoes/add");
    var request = http.MultipartRequest(
      "POST",
      Uri.parse("$uri"),
    );
    for (var i = 0; i < selectedImage.length; i++) {
      request.files.add(
          await http.MultipartFile.fromPath("image", selectedImage[i].path));
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
      appBar: AppBar(title: Text("upload")),
      body: SafeArea(
        child: Column(
          children: [
            TextButton(
              onPressed: selectedImage,
              child: Text("select"),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: GridView.builder(
                    itemCount: images!.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 25,
                      mainAxisSpacing: 25,
                    ),
                    shrinkWrap: true,
                    itemBuilder: (BuildContext context, int index) => GridTile(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(18.0),
                            child: Image.file(
                              File(images![index].path),
                              fit: BoxFit.cover,
                            ),
                          ),
                        )),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 28.0),
              child: TextButton(
                onPressed: () {
                  upload(images);
                },
                child: Text("upload"),
              ),
            )
          ],
        ),
      ),
    );
  }
}
