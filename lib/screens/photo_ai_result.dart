import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:path/path.dart' as path;
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../data_sources/api_services.dart';

class PhotoAiResult extends StatefulWidget {
  final String imgUrl;
  PhotoAiResult({required this.imgUrl});
  @override
  _PhotoAiResultState createState() => _PhotoAiResultState();
}

class _PhotoAiResultState extends State<PhotoAiResult> {
  List _items = [];
  String userImgPath = "";
  final ApiService apiService = ApiService();

  @override
  void initState() {
    super.initState();
  }

  Future<String> getImagePath(String fileName) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String _username = prefs.getString('username') ?? "";

    Directory _documentDir = Directory('');
    _documentDir = await getApplicationDocumentsDirectory();

    final String userDir = path.join(_documentDir.path, _username);
    await Directory(userDir).create(recursive: true);

    String fileNameWithPath = '$fileName.jpg';
    final String userPath = path.join(userDir, fileNameWithPath);
    setState(() {
      userImgPath = userPath;
    });
    return userPath;
  }

  Future<void> readJson() async {
    String data = await DefaultAssetBundle.of(context)
        .loadString("assets/api/response.json");
    final jsonResult = jsonDecode(data);
    setState(() {
      _items = jsonResult["images"];
    });
  }

  Future<Uint8List> _getImageBytes(String imageUrl) async {
    final response = await http.get(Uri.parse(imageUrl));

    if (response.statusCode == 200) {
      return response.bodyBytes;
    } else {
      throw Exception(
          'Failed to load image. Status code: ${response.statusCode}');
    }
  }

  Future<void> fetchDataAndSaveImage() async {
    try {
      String usrImgUrl = widget.imgUrl;
      File _imageFile = File(usrImgUrl);
      final Uint8List _bytes = await _imageFile.readAsBytes();
      final String imgBase64 = base64.encode(_bytes);

      final Map<String, dynamic> payload = {
        'prompt':
            "(((best quality, high quality, highres))), 1boy, handsome, beautiful, young, celebrity, angular face",
        'negativePrompt':
            "nsfw, poorly_drawn, blurry, cropped, worst quality, normal quality, low quality, jpeg artifacts, bad_hands, missing fingers, extra digit, bad_anatomy, bad_proportions, bad_feet, watermark, username, artist name, signature, error, text, lower, fewer digits, extra digit, (worst quality, low quality:1.4), monochrome, blurry, missing fingers, extra digit, fewer digits, extra body parts, bad anatomy, censored, collage, logo, border, child, loli, shota, ((deformation))",
        'samplerName': "Euler",
        'batchSize': 2,
        'steps': 20,
        'cfgScale': 7,
        'width': 512,
        'height': 512,
        'overrideSettingsRestoreAfterwards': true,
        'samplerIndex': "Euler",
        'scriptArgs': [],
        'sendImages': true,
        'saveImages': true,
        'alwaysonScripts': {
          'controlNet': {
            'args': [
              {
                'controlMode': "Balanced",
                'enabled': true,
                'guidanceEnd': 1,
                'guidanceStart': 0,
                'inputImage': 'data:image/png;base64,' + imgBase64,
                'inputMode': "simple",
                'isUi': true,
                'loopback': false,
                'lowVram': false,
                'model': "control_v11p_sd15_lineart [43d4be0d]",
                'module': "lineart_standard (from white bg & black line)",
                'outputDir': "",
                'pixelPerfect': true,
                'processorRes': 512,
                'resizeMode': "Crop and Resize",
                'thresholdA': -1,
                'thresholdB': -1,
                'weight': 0.8,
              }
            ]
          },
        },
      };

      //final Map<String, dynamic> response = await apiService.postData(payload);
      final Map<String, dynamic> response = await ApiServices().postData(payload);
      _items = response['images'];
      List<String> dynamicData = _items.cast<String>();
      final Uint8List imageData = base64Decode(dynamicData.firstOrNull ?? "");

      await ImageSaver.saveImage('photo_with_ai', imageData);

      print('Image saved successfully');
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Photo Result From AI"),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 10),
            Expanded(
              child: Container(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("aaa"),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          fetchDataAndSaveImage();
        },
        child: new Icon(Icons.check),
        backgroundColor: Colors.greenAccent,
        elevation: 0.0,
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

    String fileNameWithPath = '$fileName.jpg';
    final String userPath = path.join(userDir, fileNameWithPath);
    File(userPath).writeAsBytesSync(imageData);
  }
}

class ApiService {
  static const String apiUrl = 'http://127.0.0.1:7860/sdapi/v1/txt2img';

  Future<Map<String, dynamic>> postData(Map<String, dynamic> payload) async {
    final response = await http.post(Uri.parse(apiUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(payload));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed');
    }
  }
}
