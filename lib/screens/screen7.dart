import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class Screen7 extends StatefulWidget {
  String imgUrl;
  Screen7({required this.imgUrl});

  @override
  State<Screen7> createState() => _Screen7State();
}

class _Screen7State extends State<Screen7> {
  final String imgUrlTest = 'https://placekitten.com/418/326';

  @override
  void initState() {
    super.initState();
  }

  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Stack(
          fit: StackFit.expand,
          children: [
            // Background Image
            Image(
              image: AssetImage('assets/template/theme.png'),
              fit: BoxFit.cover,
            ),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RichText(
                    text: TextSpan(
                      text: '바뀐 나의 모습을',
                      style: TextStyle(
                          fontSize: 60,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontFamily: 'GulyFont'),
                      children: <TextSpan>[
                        TextSpan(
                          text: ' 전송할 수 있어요!',
                          style: TextStyle(
                              fontSize: 60,
                              fontWeight: FontWeight.bold,
                              color: Colors.orangeAccent,
                              fontFamily: 'GulyFont'),
                        ),
                      ],
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
                            margin: EdgeInsets.only(left: 80),
                            height: 426,
                            width: 418,
                            child: ImageCard(
                              imageCardUrl: widget.imgUrl,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Container(
                            margin: EdgeInsets.only(left: 50, top: 120),
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
                            margin: EdgeInsets.only(left: 50, top: 2),
                            height: 263,
                            width: 272,
                            child: ClipRRect(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
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
      margin: EdgeInsets.all(16.0),
      child: Column(
        children: [
          Container(
            color: Colors.lightGreen,
            padding: EdgeInsets.all(8.0),
            child: Center(
              child: Text(
                '합성 결과',
                style: TextStyle(
                  color: const Color.fromARGB(255, 255, 205, 202),
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Container(
            width: 418,
            height: 354.0,
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
