import 'dart:io';

import 'package:chattin/Network/network_dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

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
              child: GridView.builder(
                itemCount: images!.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3),
                itemBuilder: (BuildContext context, int index) {
                  return Image.file(File(images![index].path));
                },
              ),
            ),
            TextButton(
              onPressed: () {
                uploadimage(images);
              },
              child: Text("upload"),
            )
          ],
        ),
      ),
    );
  }

  Future uploadimage(images) async {
    //   var uri = Uri.parse("http://192.168.29.232:3000/shoes/add");
    //   var request = http.MultipartRequest(
    //     "POST",
    //     Uri.parse("$uri"),
    //   );
    //   request.files
    //       .add(await http.MultipartFile.fromPath("image", images.toString()));
    //   var response = await request.send();

    //   var responseData = await response.stream.toBytes();
    //   var responseString = String.fromCharCodes(responseData);
    //   var parsedJson = await json.decode(responseString);

    //   if (response.statusCode == 200) {
    //     return parsedJson;
    //   } else {
    //     return 'something went wrong';
    //   }
    // }
  }
}
