import 'dart:io';

import 'package:flutter/material.dart';
import 'package:photobooth_section1/models/image_model.dart';
import 'package:photobooth_section1/screens/screen5.dart';
import 'package:flutter/painting.dart';

class Screen4 extends StatefulWidget {
  List<ImageModel> images = [];

  Screen4({required this.images});

  @override
  State<Screen4> createState() => _Screen4State();
}

class _Screen4State extends State<Screen4> {
  int chooseImgId = 999;
  String chooseImgUrl = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  _chooseImg(int id) async {
    setState(() {
      chooseImgId = id;
      chooseImgUrl = widget.images[id].imgUrl;
    });
  }

  void _goToEffect() {
    if (chooseImgUrl == '') {
      _showMyDialog();
      return;
    }
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => Screen5(
                  image: chooseImgUrl,
                )));
  }

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Icon(
            Icons.warning_amber_rounded,
            size: 30,
          ),
          content: const SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(
                  '이미지를 선택해주세요.',
                  style: TextStyle(
                    fontSize: 25,
                    fontFamily: 'GulyFont',
                    color: Colors.redAccent,
                  ),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text(
                '좋아요',
                style: TextStyle(
                  fontSize: 20,
                  fontFamily: 'GulyFont',
                  color: Colors.black,
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Widget build(BuildContext context) {
    return widget.images.length > 0
        ? MaterialApp(
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
                            text: '합성할 사진',
                            style: TextStyle(
                                fontSize: 60,
                                fontWeight: FontWeight.bold,
                                color: Colors.orangeAccent,
                                fontFamily: 'GulyFont'),
                            children: <TextSpan>[
                              TextSpan(
                                text: ' 을 선택해 주세요!',
                                style: TextStyle(
                                  fontSize: 60,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black87,
                                  fontFamily: 'GulyFont',
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 20),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Column(
                              children: [
                                Container(
                                  child: InkWell(
                                    onTap: () {
                                      _chooseImg(0);
                                    },
                                    child: Container(
                                      margin: EdgeInsets.only(left: 350),
                                      width: 355,
                                      height: 252,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.rectangle,
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                        border: chooseImgId == 0
                                            ? Border.all(
                                                color: Colors.green, width: 8)
                                            : Border.all(
                                                color: Colors.white, width: 4),
                                        image: DecorationImage(
                                            fit: BoxFit.cover,
                                            image: FileImage(
                                                File(widget.images[0].imgUrl))),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                Container(
                                  child: InkWell(
                                    onTap: () {
                                      _chooseImg(1);
                                    },
                                    child: Container(
                                      margin: EdgeInsets.only(left: 10),
                                      width: 355,
                                      height: 252,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.rectangle,
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                        border: chooseImgId == 1
                                            ? Border.all(
                                                color: Colors.green, width: 8)
                                            : Border.all(
                                                color: Colors.white, width: 4),
                                        image: DecorationImage(
                                            fit: BoxFit.cover,
                                            image: FileImage(
                                                File(widget.images[1].imgUrl))),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                Container(
                                  width: 355,
                                )
                              ],
                            )
                          ],
                        ),
                        // Rounded Image
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Column(
                              children: [
                                Container(
                                  child: InkWell(
                                    onTap: () {
                                      _chooseImg(2);
                                    },
                                    child: Container(
                                      margin:
                                          EdgeInsets.only(left: 180, top: 10),
                                      width: 355,
                                      height: 252,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.rectangle,
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                        border: (chooseImgId == 2)
                                            ? Border.all(
                                                color: Colors.green, width: 8)
                                            : Border.all(
                                                color: Colors.white, width: 4),
                                        image: DecorationImage(
                                            fit: BoxFit.cover,
                                            image: FileImage(
                                                File(widget.images[2].imgUrl))),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                Container(
                                  child: InkWell(
                                    onTap: () {
                                      _chooseImg(3);
                                    },
                                    child: Container(
                                      margin:
                                          EdgeInsets.only(left: 10, top: 10),
                                      width: 355,
                                      height: 252,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.rectangle,
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                        border: (chooseImgId == 3)
                                            ? Border.all(
                                                color: Colors.green, width: 8)
                                            : Border.all(
                                                color: Colors.white, width: 4),
                                        image: DecorationImage(
                                            fit: BoxFit.cover,
                                            image: FileImage(
                                                File(widget.images[3].imgUrl))),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                Container(
                                  margin: EdgeInsets.only(left: 20, top: 170),
                                  alignment: Alignment.bottomCenter,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      // Add
                                      _goToEffect();
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20, vertical: 20),
                                      child: Text('시작',
                                          style: TextStyle(
                                              fontSize: 50,
                                              color: Colors.black,
                                              fontFamily: 'GulyFont')),
                                    ),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.lightGreen,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20),
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
          )
        : Container();
  }
}
