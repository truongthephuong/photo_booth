import 'dart:io';

import 'package:flutter/material.dart';
import 'package:photobooth_section1/screens/screen1.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:path/path.dart' as path;
import 'package:http/http.dart' as http;
import 'dart:convert';

class Screen7 extends StatefulWidget {
  // AI Image
  String imgUrl;
  Screen7({required this.imgUrl});

  @override
  State<Screen7> createState() => _Screen7State();
}

class _Screen7State extends State<Screen7> {
  // TODO: Upload to API and get the image link here
  final String imgUrlTest = 'https://placekitten.com/418/326';

  @override
  void initState() {
    super.initState();
    // _freshPhotoDir();
    _uploadImage();
  }

  Future<void> _uploadImage() async {
    try {
      var request = http.MultipartRequest(
          'POST', Uri.parse('http://128.199.205.168/api/upload/'));

      request.files.add(
        await http.MultipartFile.fromPath('file', widget.imgUrl),
      );

      var response = await request.send();

      if (response.statusCode == 200) {
        print(await response.stream.bytesToString());
      } else {
        // Handle errors
        print('Failed to upload image. Status code: ${response.statusCode}');
      }
    } catch (error) {
      print('Error uploaded');
    }
  }

  _freshPhotoDir() {
    Directory current = Directory.current;

    // Parent folder
    final String internalFolder = path.join(current.path, 'myphotos');
    final Directory dir = Directory(internalFolder);
    dir.deleteSync(recursive: true);
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
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin:
                        const EdgeInsets.only(left: 10.0, right: 0.0, top: 0.0),
                    child: RichText(
                      text: TextSpan(
                        text: '바뀐 나의 모습을',
                        style: TextStyle(
                            fontSize: 45,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            fontFamily: 'GulyFont'),
                        children: <TextSpan>[
                          TextSpan(
                            text: ' 전송할 수 있어요!',
                            style: TextStyle(
                                fontSize: 45,
                                fontWeight: FontWeight.bold,
                                color: Colors.orangeAccent,
                                fontFamily: 'GulyFont'),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  // Rounded Image
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          Container(
                            margin: EdgeInsets.only(left: 10),
                            color: Colors.blueAccent,
                            height: 250,
                            width: 320,
                            child: ImageCard(
                              imageCardUrl: widget.imgUrl,
                            ),
                          ),
                          /*
                          ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Screen1()));
                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 30, vertical: 10),
                              child: Text('시작',
                                  style: TextStyle(
                                      fontSize: 50,
                                      color: Colors.red,
                                      fontFamily: 'GulyFont')),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                          ),
                           */
                        ],
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Container(
                        margin: EdgeInsets.only(left: 30, top: 10),
                        alignment: Alignment.bottomCenter,
                        child: ElevatedButton(
                          onPressed: () {
                            // Trigger start countdown
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 5, vertical: 5),
                            child: Text('QR 전송',
                                style: TextStyle(
                                    fontSize: 20,
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
                        margin: EdgeInsets.only(left: 30, top: 5),
                        height: 263,
                        width: 272,
                        child: ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          child: AspectRatio(
                            aspectRatio: 1,
                            child: QrImageView(
                              data: imgUrlTest,
                              version: QrVersions.auto,
                              size: 50,
                              backgroundColor: Colors.white,
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
