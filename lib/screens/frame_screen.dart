import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image/image.dart' as img;
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;
import 'dart:io';

import 'package:shared_preferences/shared_preferences.dart';

class FrameScreen extends StatefulWidget {
  final String imgUrl;
  FrameScreen({required this.imgUrl});

  @override
  State<FrameScreen> createState() => _FrameScreenState();
}

class _FrameScreenState extends State<FrameScreen> {
  late img.Image? image;
  late img.Image? frame;
  Uint8List resultImageUrl = Uint8List(0);
  String userImgPath = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    applyFrame();
  }

  Future<void> applyFrame() async {
    File _imageFile = File(widget.imgUrl);
    final Uint8List _bytes = await _imageFile.readAsBytes();
    // Load the main image
    image = img.decodeImage(Uint8List.fromList(_bytes));

    // Load the frame
    frame = img.decodeImage(Uint8List.fromList(
        (await rootBundle.load('assets/images/frame_image.png'))
            .buffer
            .asUint8List()));

    // Apply the frame
    if (image != null && frame != null) {
      img.drawImage(image!, frame!,
          dstX: (image!.width - frame!.width) ~/ 2,
          dstY: (image!.height - frame!.height) ~/ 2);
    }

    // Save the result to a folder
    await saveImage(image, 'result_image');

    loadImage();
  }

  Future<void> saveImage(img.Image? image, String fileName) async {
    // Get the application documents directory
    final _documentDir = await getApplicationDocumentsDirectory();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String _username = prefs.getString('username') ?? "";

    // Create the file path
    final String userDir = path.join(_documentDir.path, _username);
    String fileNameWithPath = '$fileName.jpg';
    final String userPath = path.join(userDir, fileNameWithPath);

    // Save the image to the file
    File(userPath).writeAsBytesSync(Uint8List.fromList(img.encodeJpg(image!)));
  }

  Future<void> loadImage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String _username = prefs.getString('username') ?? "";

    Directory _documentDir = Directory('');
    _documentDir = await getApplicationDocumentsDirectory();

    final String userDir = path.join(_documentDir.path, _username);
    await Directory(userDir).create(recursive: true);

    String fileNameWithPath = 'result_image.jpg';
    final String userPath = path.join(userDir, fileNameWithPath);
    File imageFile = File(userPath);

    Uint8List bytes = await imageFile.readAsBytes();
    setState(() {
      resultImageUrl = bytes;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Add Frame",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.amberAccent,
        centerTitle: true,
      ),
      body: Center(
        child: resultImageUrl.isNotEmpty
            ? Card(
                elevation: 5,
                child: Container(
                  width: 512,
                  height: 512,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: MemoryImage(resultImageUrl),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              )
            : CircularProgressIndicator(),
      ),
    );
  }
}
