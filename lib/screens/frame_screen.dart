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
  bool processing = false;
  bool isProcessing = false;
  Uint8List resultImageUrl = Uint8List(0);
  String userImgPath = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    applyFrame();
  }

  Future<void> applyFrame() async {
    setState(() {
      processing = true;
    });

    File _imageFile = File(widget.imgUrl);
    final Uint8List _bytes = await _imageFile.readAsBytes();
    // Load the main image
    image = img.decodeImage(Uint8List.fromList(_bytes));

    print('image add frame');
    print(widget.imgUrl);

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
    await saveImage(image, 'result_image.jpg');

    setState(() {
      processing = false;
    });
  }

  Future<void> saveImage(img.Image? image, String fileName) async {
    // Get the application documents directory
    final directory = await getApplicationDocumentsDirectory();

    // Create the file path
    final filePath = '${directory.path}/$fileName';

    // Save the image to the file
    File(filePath).writeAsBytesSync(Uint8List.fromList(img.encodeJpg(image!)));
  }

  Future<void> loadImage() async {
    final Directory appDir = await getApplicationDocumentsDirectory();
    final String appDirPath = appDir.path;
    File imageFile = File('$appDirPath/result_image.jpg');

    // Check if the image file exists
    if (await imageFile.exists()) {
      // Read the image file as bytes
      Uint8List bytes = await imageFile.readAsBytes();
      resultImageUrl = bytes;
    } else {
      // If the file doesn't exist, return an empty Uint8List or handle accordingly
      resultImageUrl = Uint8List(0);
    }
    setState(() {
      resultImageUrl = resultImageUrl;
    });
  }

  @override
  Widget build(BuildContext context) {
    loadImage();
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 20),
            isProcessing
                ? CircularProgressIndicator()
                : resultImageUrl.isNotEmpty
                    ? Card(
                        elevation: 5,
                        child: Container(
                          width: 300,
                          height: 300,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: MemoryImage(resultImageUrl),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      )
                    : Container(),
          ],
        ),
      ),
    );
  }
}
