import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:photobooth_section1/screens/screen7.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:path/path.dart' as path;
import 'package:http/http.dart' as http;

import '../palatter.dart';
import '../widgets/background-image.dart';

class Screen6 extends StatefulWidget {
  final String imgUrl;
  final String effectName;
  Screen6({required this.imgUrl, required this.effectName});
  @override
  _Screen6State createState() => _Screen6State();
}

class _Screen6State extends State<Screen6> {
  List payloadArr = [];
  List _items = [];
  List<ImgList> imgListAi = [];
  int cntImg = 0;
  String userImgPath = "";
  final ApiService apiService = ApiService();
  Uint8List resultImageUrl = Uint8List(0);
  List<String> aiImages = [];
  Map<String, dynamic> payload = {};
  bool doneAi = false;

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

  Future<void> getImagePath(int fileName) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String _username = prefs.getString('username') ?? "";

    Directory current = Directory.current;

    // Parent folder
    final String internalFolder = path.join(current.path, 'myphotos');
    await Directory(internalFolder).create(recursive: true);

    // User Dir
    final String userDir = path.join(internalFolder, _username);
    await Directory(userDir).create(recursive: true);

    // Result folder
    final String resultUserDir = path.join(userDir, 'Result');
    await Directory(resultUserDir).create(recursive: true);

    String fileNameWithPath = '$fileName.jpg';
    final String userPath = path.join(resultUserDir, fileNameWithPath);
    setState(() {
      aiImages.add(userPath);
      userImgPath = userPath;
      doneAi = true;
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
      SharedPreferences prefs = await SharedPreferences.getInstance();
      int aiEffectIDSess = prefs.getInt('aiEffectIDSess') ?? 1;
      String usrImgUrl = widget.imgUrl;
      File imageFile = File(usrImgUrl);
      final Uint8List bytes = await imageFile.readAsBytes();
      if (bytes.isNotEmpty) {
        final String imgBase64 = base64.encode(bytes);
        if (imgBase64.isNotEmpty) {
          String jsonString = await rootBundle
              .loadString("assets/ai/${widget.effectName}.json");
          payload = json.decode(jsonString);

          payload['alwayson_scripts']['ControlNet']['args'][0]['input_image'] =
              'data:image/jpeg;base64,' + imgBase64;

          print('call api');
          print(payload);

          final Map<String, dynamic> response =
              await apiService.postData(payload);

          if (response.isNotEmpty && response['images'] != null) {
            _items = response['images'];
            List<String> dynamicData = _items.cast<String>();
            final Uint8List imageData =
                base64Decode(dynamicData.firstOrNull ?? "");

            if (imageData.isNotEmpty) {
              await ImageSaver.saveImage(aiEffectIDSess, imageData);

              setState(() {
                resultImageUrl = imageData;
                cntImg++;
              });

              print('done');

              getImagePath(aiEffectIDSess);

              imgListAi.add(getImagePath(aiEffectIDSess) as ImgList);
            }
          }
        }
      }
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        BackGroundImage(),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: SingleChildScrollView(
            child: SafeArea(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 20,
                ),
                Container(
                  margin:
                      const EdgeInsets.only(left: 20.0, right: 0.0, top: 0.0),
                  height: 150,
                  child: Center(
                    child: RichText(
                      text: TextSpan(
                        text: '인공지능 ',
                        style: kHeading,
                        children: <TextSpan>[
                          TextSpan(text: '은 어떻게 ', style: kHeading1),
                          TextSpan(
                              text: '은 어떻게 나를 바꾸어 줄까요? ', style: kHeading1),
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                  width: 900,
                  height: 380,
                  child: Column(
                    children: [
                      Image.asset(
                        'assets/images/welcome.png',
                        width: 900,
                        height: 380,
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(12.0),
                  width: 500,
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: _loading
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Container(
                                height: 20,
                                width: 256,
                                child: LinearProgressIndicator(
                                  minHeight: 20.0,
                                  backgroundColor: Colors.limeAccent,
                                  valueColor: new AlwaysStoppedAnimation<Color>(
                                      Colors.blueAccent),
                                  value: _progressValue,
                                ),
                              ),
                            ),
                            //Text('${(_progressValue * 100).round()}%',
                            Text('외계인을 납치해 오는중...',
                                style: TextStyle(
                                    fontSize: 18, color: Colors.blueAccent)),
                          ],
                        )
                      : Text("", style: TextStyle(fontSize: 25)),
                ),
              ],
            )),
          ),
        ),
      ],
    );
  }

  // this function updates the progress value
  void _updateProgress() {
    const oneSec = const Duration(seconds: 1);
    new Timer.periodic(oneSec, (Timer t) {
      setState(() {
        _progressValue += 0.01;
        // we "finish" downloading here
        if (_progressValue.toStringAsFixed(1) == '3.0' || doneAi) {
          //_loading = false;
          t.cancel();
          print('Load 100% goto other screen');
          Navigator.pop(context);
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => Screen7(
                      imgUrl: aiImages.isNotEmpty ? aiImages[0] : widget.imgUrl,
                    )),
          );
          return;
        }
      });
    });
  }
}

class ImageSaver {
  static Future<void> saveImage(int fileName, Uint8List imageData) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String _username = prefs.getString('username') ?? "";

    Directory current = Directory.current;

    // Parent folder
    final String internalFolder = path.join(current.path, 'myphotos');
    await Directory(internalFolder).create(recursive: true);

    // User Dir
    final String userDir = path.join(internalFolder, _username);
    await Directory(userDir).create(recursive: true);

    // Result folder
    final String resultUserDir = path.join(userDir, 'Result');
    await Directory(resultUserDir).create(recursive: true);

    String fileNameWithPath = '$fileName.jpg';
    final String userPath = path.join(resultUserDir, fileNameWithPath);
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
