import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
//import 'package:photobooth_section1/screens/frame_screen.dart';
import 'package:photobooth_section1/screens/photo_result_list.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:path/path.dart' as path;
import 'package:http/http.dart' as http;


class PhotoAiResultBK extends StatefulWidget {
  final String imgUrl;
  final String effectName;
  PhotoAiResultBK({required this.imgUrl, required this.effectName});
  @override
  _PhotoAiResultState createState() => _PhotoAiResultState();
}

class _PhotoAiResultState extends State<PhotoAiResultBK> {
  List payloadArr = [];
  List _items = [];
  List<ImgList> imgListAi = [];
  int cntImg = 0;
  String userImgPath = "";
  final ApiService apiService = ApiService();
  Uint8List resultImageUrl = Uint8List(0);
  List<String> aiImages = [];
  Map<String, dynamic> payload = {};
  late bool _loading;
  late double _progressValue;

  @override
  void initState() {
    super.initState();
    _loading = false;
    _progressValue = 0.0;

    _loading = !_loading;
    _updateProgress();
    // API call
    fetchDataAndSaveImage(widget.effectName);
  }

  Future<void> getImagePath(String fileName) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String _username = prefs.getString('username') ?? "";

    Directory _documentDir = Directory('');
    _documentDir = await getApplicationDocumentsDirectory();

    final String userDir = path.join(_documentDir.path, _username);
    await Directory(userDir).create(recursive: true);

    String fileNameWithPath = '$fileName.jpg';
    final String userPath = path.join(userDir, fileNameWithPath);
    setState(() {
      aiImages.add(userPath);
      userImgPath = userPath;
    });
  }

  Future<void> readJson(String payloadFile) async {
    String data = await DefaultAssetBundle.of(context)
        .loadString("assets/ai/$payloadFile.json");
    final debugJson = jsonDecode(data);
    setState(() {
      payloadArr = debugJson;
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

  Future<void> fetchDataAndSaveImage(String effectName) async {
    try {
      String usrImgUrl = widget.imgUrl;
      File _imageFile = File(usrImgUrl);
      final Uint8List _bytes = await _imageFile.readAsBytes();
      if (_bytes.isNotEmpty) {
        final String imgBase64 = base64.encode(_bytes);
        if (imgBase64.isNotEmpty) {
          //print(imgBase64);

          String jsonString = await rootBundle
              .loadString("assets/ai/${widget.effectName}.json");
          payload = json.decode(jsonString);

          // if (payload.isNotEmpty) {
          // Modify an element in the array (for example, updating the first element)
          payload['alwayson_scripts']['ControlNet']['args'][0]['input_image'] =
              'data:image/jpeg;base64,' + imgBase64;

          //final Map<String, dynamic> payload = payloadArr;

          final Map<String, dynamic> response =
              await apiService.postData(payload);

          if (response.isNotEmpty && response['images'] != null) {
            _items = response['images'];
            List<String> dynamicData = _items.cast<String>();
            final Uint8List imageData =
                base64Decode(dynamicData.firstOrNull ?? "");

            if (imageData.isNotEmpty) {
              await ImageSaver.saveImage('photo_with_ai', imageData);

              setState(() {
                resultImageUrl = imageData;
                cntImg++;
              });

              getImagePath('photo_with_ai');

              imgListAi.add(getImagePath('photo_with_ai') as ImgList);

              print('Image saved successfully');
            }
          }
          // }
        }
      }
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Photo AI",
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
                  width: 640,
                  height: 360,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: MemoryImage(
                        resultImageUrl,
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              )
            //: CircularProgressIndicator(),
            : Container(
                padding: EdgeInsets.all(12.0),
                child: _loading
                    ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Container(
                        height: 15,
                        child: LinearProgressIndicator(
                          minHeight: 20.0,
                          backgroundColor: Colors.limeAccent,
                          valueColor: new AlwaysStoppedAnimation<Color>(Colors.blueAccent),
                          value: _progressValue,
                        ),

                      ),
                    ),
                    Text('${(_progressValue * 100).round()}%',
                        style: TextStyle(fontSize: 18, color:Colors.deepOrange)),
                  ],
                )
                    : Text("", style: TextStyle(fontSize: 25)),
              ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        label: Text('Photos Created'),
        backgroundColor: Colors.blueAccent,
        icon: Icon(Icons.confirmation_num, size: 24.0),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PhotoResultList(
                aiImages: aiImages,
              ),
              settings: RouteSettings(
                arguments: imgListAi,
              ),
            ),
          );
        },
      ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  // this function updates the progress value
  void _updateProgress() {
    const oneSec = const Duration(seconds: 1);
    new Timer.periodic(oneSec, (Timer t) {
      setState(() {
        _progressValue += 0.01;
        // we "finish" downloading here
        if (_progressValue.toStringAsFixed(1) == '1.0') {
          //_loading = false;
          t.cancel();
          return;
        }
      });
    });
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

class ImgList {
  String imgUrl;
  //int id;
  ImgList({required this.imgUrl});
}
