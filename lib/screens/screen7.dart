import 'dart:convert';
import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:photobooth_section1/screens/screen1.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:path/path.dart' as path;
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Screen7 extends StatefulWidget {
  // AI Image
  String imgUrl;
  Screen7({required this.imgUrl});

  @override
  State<Screen7> createState() => _Screen7State();
}

class _Screen7State extends State<Screen7> {
  // TODO: Upload to API and get the image link here
  late String imgUrlTest = '';
  final ApiService apiService = new ApiService();

  @override
  void initState() {
    super.initState();
    AudioPlayer().play(AssetSource('audio/screen7.mp3'));
    _printDataAndSaveImage(widget.imgUrl);
    _uploadImage();
  }

  Future<void> _uploadImage() async {
    try {
      var request = http.MultipartRequest(
          'POST', Uri.parse('http://128.199.205.168/api/upload/'));

      request.files.add(
        await http.MultipartFile.fromPath('file', widget.imgUrl),
      );

      final response = await request.send();

      if (response.statusCode == 200) {
        final jsonData = await http.Response.fromStream(response);
        final result = jsonDecode(jsonData.body) as Map<String, dynamic>;
        if (result.isNotEmpty) {
          setState(() {
            imgUrlTest = 'http://128.199.205.168/${result['image']}';
          });
        }
      } else {
        // Handle errors
        print('Failed to upload image. Status code: ${response.statusCode}');
      }
    } catch (error) {
      print('Error uploaded');
    }
  }

  Future<void> _printDataAndSaveImage(String resultUrl) async {
    // Define the API endpoint and headers
    final apiUrl = Uri.parse('http://127.0.0.1:8000/api/generate-image/');
    final headers = {'Content-Type': 'application/json; charset=utf-8'};

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String _username = prefs.getString('username') ?? "";

    Directory current = Directory.current;

    // Parent folder
    final String internalFolder = path.join(current.path, 'myphotos');
    await Directory(internalFolder).create(recursive: true);

    // User folder
    final String userDir = path.join(internalFolder, _username);
    await Directory(userDir).create(recursive: true);

    // Target folder
    final String targetUserDir = path.join(userDir, 'Target');
    await Directory(targetUserDir).create(recursive: true);
    // Asset folder
    final String assetDir = path.join(current.path, 'assets');
    await Directory(assetDir).create(recursive: true);
    final String assertImageDir = path.join(assetDir, 'images');
    await Directory(assertImageDir).create(recursive: true);

    // Prepare the request body
    final requestBody = {
      "image_selected": resultUrl,
      "bkgrnd_image": "C:/photoboothprint/3a.jpg",
      "logo_image": "C:/photoboothprint/h1.png",
      "hearth_image_1": "C:/photoboothprint/h1.png",
      "hearth_image_2": "C:/photoboothprint/h1.png",
      "banned_image": "C:/photoboothprint/Banned-Transparent.png",
      "small_icon": "C:/photoboothprint/Asset1.png",
      "kiss_icon": "C:/photoboothprint/kiss.png",
      "generated_print_image_path": "C:/photoboothprint/print_image.jpg",
    };

    // Create the HTTP request
    final request = http.Request('POST', apiUrl)
      ..headers.addAll(headers)
      ..body = json.encode(requestBody);

    try {
      // Send the request and get the response
      final response = await request.send();

      // Check the response status
      if (response.statusCode == 200) {
        final jsonData = await http.Response.fromStream(response);
        var decodedBody = utf8.decode(jsonData.bodyBytes);
        print("Handle print project");
        print(decodedBody);
      } else {
        print(response.reasonPhrase);
      }
    } catch (error) {
      print('Error: $error');
    }
  }

  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Stack(
          fit: StackFit.expand,
          children: [
            //Background Image
            Image(
              image: AssetImage('assets/images/bg_ver.png'),
              fit: BoxFit.cover,
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/template/text-screen7.png',
                )
              ],
            ),

            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 300),
                  // Rounded Image
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          Container(
                            width: 500.0,
                            height: 460.0,
                            decoration: BoxDecoration(
                              //color: Colors.teal,
                              // border: Border.all(
                              //   color: Colors.black,
                              // ),
                              borderRadius: BorderRadius.circular(10.0),
                              image: DecorationImage(
                                image: AssetImage(
                                    'assets/template/screen5_layer.png'), // Add your background image path
                                fit: BoxFit.cover,
                              ),
                            ),
                            child: Center(
                              child: Container(
                                margin: const EdgeInsets.only(
                                  top: 70.0,
                                ),
                                width: 490.0,
                                height: 520.0,
                                decoration: BoxDecoration(
                                  // border: Border.all(
                                  //   color: Colors.white,
                                  //   width: 0,
                                  // ),
                                  borderRadius: BorderRadius.circular(10.0),
                                  image: DecorationImage(
                                    image: new FileImage(
                                      File(widget.imgUrl),
                                    ), // Add your foreground image path
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Container(
                        margin: EdgeInsets.only(
                          left: 30,
                          top: 20,
                          bottom: 20,
                        ),
                        alignment: Alignment.bottomCenter,
                        child: ElevatedButton(
                          onPressed: () {
                            // Trigger start countdown
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 5),
                            child: Text('QR 전송',
                                style: TextStyle(
                                    fontSize: 35,
                                    color: Colors.white,
                                    fontFamily: 'GulyFont')),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        width: 290.0,
                        height: 380.0,
                        margin: EdgeInsets.only(
                          left: 30,
                          top: 20,
                          bottom: 20,
                        ),
                        decoration: BoxDecoration(
                          // color: Colors.white,
                          border: Border.all(
                            color: Colors.white,
                            width: 10,
                          ),
                          borderRadius: BorderRadius.circular(10.0),
                          image: DecorationImage(
                            image: AssetImage(
                                'assets/template/screen7_qr_company.png'), // Add your background image path
                            fit: BoxFit.fitHeight,
                          ),
                        ),
                        child: Center(
                          child: Container(
                            margin: EdgeInsets.only(
                              // left: 20,
                              // right: 20,
                              top: 30,
                              // bottom: 20,
                            ),
                            child: ClipRRect(
                              // borderRadius:
                              //     BorderRadius.all(Radius.circular(10)),
                              child: AspectRatio(
                                aspectRatio: 0.6,
                                child: imgUrlTest.isNotEmpty
                                    ? QrImageView(
                                        data: imgUrlTest,
                                        version: QrVersions.auto,
                                        size: 200
                                        // backgroundColor: Colors.white,
                                        )
                                    : Container(),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
        floatingActionButton: FloatingActionButton.extended(
          backgroundColor: Colors.green,
          foregroundColor: Colors.black,
          onPressed: () {
            Navigator.pop(context);
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Screen1()),
            );
          },
          icon: Icon(Icons.arrow_back_sharp),
          label: Text('재시작'),
        ),
      ),
    );
  }
}

class ImageCard extends StatelessWidget {
  final String imageCardUrl;

  const ImageCard({Key? key, required this.imageCardUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4.0,
      margin: EdgeInsets.all(2.0),
      child: Column(
        children: [
          // Container(
          //   color: Colors.lightGreen,
          //   padding: EdgeInsets.all(8.0),
          //   child: Center(
          //     child: Text(
          //       '합성 결과',
          //       style: TextStyle(
          //         color: const Color.fromARGB(255, 255, 205, 202),
          //         fontSize: 18.0,
          //         fontWeight: FontWeight.bold,
          //       ),
          //     ),
          //   ),
          // ),
          Container(
            width: 320,
            height: 240,
            child: Image.file(
              File(imageCardUrl),
              fit: BoxFit.cover,
            ),
          )
        ],
      ),
    );
  }
}

class ApiService {
  static const String apiUrl = 'http://127.0.0.1:8000/api/generate-image';
  //"C:\\Users\\26-MongTaaaMedia\\Desktop\\PhotoApp\\image-frame\\test1.png"
  Future<Map<String, dynamic>> printData(Map<String, dynamic> resultUrl) async {
    final response = await http.post(Uri.parse(apiUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          "image_selected": resultUrl,
          "bkgrnd_image":
              "C:\\Users\\26-MongTaaaMedia\\Desktop\\PhotoApp\\image-frame\\3a.jpg",
          "logo_image":
              "C:\\Users\\26-MongTaaaMedia\\Desktop\\PhotoApp\\image-frame\\h1.png",
          "hearth_image_1":
              "C:\\Users\\26-MongTaaaMedia\\Desktop\\PhotoApp\\image-frame\\h1.png",
          "hearth_image_2":
              "C:\\Users\\26-MongTaaaMedia\\Desktop\\PhotoApp\\image-frame\\h1.png",
          "banned_image":
              "C:\\Users\\26-MongTaaaMedia\\Desktop\\PhotoApp\\image-frame\\Banned-Transparent.png",
          "small_icon":
              "C:\\Users\\26-MongTaaaMedia\\Desktop\\PhotoApp\\image-frame\\Asset1.png",
          "kiss_icon":
              "C:\\Users\\26-MongTaaaMedia\\Desktop\\PhotoApp\\image-frame\\kiss.png",
          "generated_print_image_path":
              "C:\\flutter-printer\\tkinter_doc_printer\\print_image.jpg"
        }));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed');
    }
  }
}
