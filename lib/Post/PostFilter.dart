import 'dart:async';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:photofilters/photofilters.dart';
import 'package:image/image.dart' as imageLib;

class PostFilter extends StatefulWidget {
  const PostFilter({ Key? key }) : super(key: key);

  @override
  _PostFilterState createState() => _PostFilterState();
}

class _PostFilterState extends State<PostFilter> {
  imageLib.Image? _image;
  String? fileName;
  Filter? _filter;
  List<Filter> filters = presetFitersList;

  Future getImage() async {
    var imageFile = await ImagePicker.pickImage(source: ImageSource.gallery);
    fileName = basename(imageFile.path);
    var image = imageLib.decodeImage(imageFile?.readAsBytesSync());
    image = imageLib.copyResize(image, 600);
    setState(() {
      _image = image;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Photo Filter Example'),
      ),
      body: new Container(
        alignment: Alignment(0.0, 0.0),
        child: _image == null
            ? new Text('No image selected.')
            : new PhotoFilterSelector(
                image: _image,
                filters: presetFitersList,
                filename: fileName,
                loader: Center(child: CircularProgressIndicator()),
              ),
      ),
      floatingActionButton: new FloatingActionButton(
        onPressed: getImage,
        tooltip: 'Pick Image',
        child: new Icon(Icons.add_a_photo),
      ),
    );
  }
}