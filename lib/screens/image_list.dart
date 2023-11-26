import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:photobooth_section1/models/image_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:path/path.dart' as path;

class ImageListScreen extends StatefulWidget {
  final List<ImageModel> images;

  ImageListScreen({Key? key, required this.images}) : super(key: key);

  @override
  State<ImageListScreen> createState() => _ImageListScreenState();
}

class _ImageListScreenState extends State<ImageListScreen> {
  List _items = [];

  Future<void> readJson() async {
    String data = await DefaultAssetBundle.of(context)
        .loadString("assets/api/response.json");
    final jsonResult = jsonDecode(data);
    setState(() {
      _items = jsonResult["images"];
    });
  }

  Future<void> fetchDataAndSaveImage() async {
    readJson();
    List<String> dynamicData = _items.cast<String>();
    final Uint8List imageData = base64Decode(dynamicData.firstOrNull ?? "");
    await ImageSaver.saveImage('photo_with_ai', imageData);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Image List'),
      ),
      body: ListView.builder(
        itemCount: widget.images.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(widget.images[index].title),
            onTap: () {
              // Navigate to a detailed view or perform other actions
              // with the selected image if needed
              print('Selected Image: ${widget.images[index].imgUrl}');
              fetchDataAndSaveImage();
            },
          );
        },
      ),
    );
  }
}

class ImageSaver {
  static Future<void> saveImage(String fileName, Uint8List imageData) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String _username = prefs.getString('username') ?? "";

    Directory _documentDir = Directory('');
    _documentDir = await getApplicationDocumentsDirectory();

    final String userDir = path.join(_documentDir.path, _username);
    await Directory(userDir).create(recursive: true);

    String fileNameWithPath = '$fileName.png';
    final String userPath = path.join(userDir, fileNameWithPath);
    File(userPath).writeAsBytesSync(imageData);
  }
}
