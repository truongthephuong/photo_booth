import 'dart:io';
import 'dart:math';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:photobooth_section1/models/image_model.dart';
import 'package:photobooth_section1/screens/screen5.dart';
// import 'package:flutter/painting.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:path/path.dart' as path;
import 'package:stroke_text/stroke_text.dart';
import 'package:http/http.dart' as http;

class Screen4 extends StatefulWidget {
  List<ImageModel> images = [];

  Screen4({required this.images});

  @override
  State<Screen4> createState() => _Screen4State();
}

class _Screen4State extends State<Screen4> {
  int chooseImgId = 999;
  String chooseImgUrl = '';
  final _chars =
      'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
  Random _rnd = Random();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  String getRandomString(int length) {
    return String.fromCharCodes(Iterable.generate(
        length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));
  }

  /**
   * If user choose photo -> go into 'myphotos/{userID}/Target'
   */
  _chooseImg(int id) async {
/*
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
    final String tempUserDir = path.join(userDir, 'Target');
    await Directory(tempUserDir).create(recursive: true);

    // Save photo
    String randomStr = getRandomString(5);
    final String userPath = path.join(tempUserDir, 'photo-${randomStr}.jpg');
    var response = await http.get(Uri.parse(widget.images[id].imgUrl));
    if (response.statusCode == 200) {
      File file = File(userPath);
      await file.writeAsBytes(response.bodyBytes);
    }

*/
    setState(() {
      chooseImgId = id;
      chooseImgUrl = widget.images[id].imgUrl;
    });
  }

  void _goToEffect() {
    if (chooseImgUrl == '') {
      _showMyDialog();
      return;
    } else {
      Navigator.pop(context);
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => Screen5(
                    image: chooseImgUrl,
                  )));
    }
  }

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(''),
          content: const SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(
                  '사진 하나를 선택해주세요',
                  style: TextStyle(
                    fontSize: 60,
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
                  fontSize: 30,
                  fontFamily: 'GulyFont',
                  color: Colors.black,
                ),
              ),
              onPressed: () {
                AudioPlayer().play(AssetSource('audio/button.mp3'));
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Widget build(BuildContext context) {
    Image imageSnap1 = Image.network(
      widget.images[0].imgUrl,
      width: 400,
      height: 230.0,
      fit: BoxFit.cover,
    );
    Image imageSnap2 = Image.network(
      widget.images[1].imgUrl,
      width: 400,
      height: 230.0,
      fit: BoxFit.cover,
    );
    Image imageSnap3 = Image.network(
      widget.images[2].imgUrl,
      width: 200.0,
      height: 220.0,
      fit: BoxFit.cover,
    );
    Image imageSnap4 = Image.network(
      widget.images[3].imgUrl,
      width: 200.0,
      height: 220.0,
      fit: BoxFit.cover,
    );

    return MaterialApp(
      home: Scaffold(
        body: Stack(
          fit: StackFit.expand,
          children: [
            // Background Image
            Image(
              image: AssetImage('assets/images/bg_ver.png'),
              fit: BoxFit.cover,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/template/text-screen4.png',
                )
              ],
            ),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 200,
                  ),
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
                                margin: EdgeInsets.only(left: 0),
                                width: 500,
                                height: 330,
                                decoration: BoxDecoration(
                                  shape: BoxShape.rectangle,
                                  borderRadius: BorderRadius.circular(8.0),
                                  border: chooseImgId == 0
                                      ? Border.all(
                                          color: Colors.green, width: 8)
                                      : Border.all(
                                          color: Colors.white, width: 4),
                                  image: DecorationImage(

                                    fit: BoxFit.cover,
                                    image: imageSnap1.image,
                                  ),
/*
                                      fit: BoxFit.cover,
                                      image:
                                          NetworkImage(widget.images[0].imgUrl)
                                      // image: AssetImage(widget.images[0].imgUrl),
                                      ),
*/
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
                                width: 500,
                                height: 330,
                                decoration: BoxDecoration(
                                  shape: BoxShape.rectangle,
                                  borderRadius: BorderRadius.circular(8.0),
                                  border: chooseImgId == 1
                                      ? Border.all(
                                          color: Colors.green, width: 8)
                                      : Border.all(
                                          color: Colors.white, width: 4),
                                  image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: imageSnap2.image,
                                  ),
/*
                                      fit: BoxFit.cover,
                                      image:
                                          NetworkImage(widget.images[1].imgUrl)
                                      // image: AssetImage(widget.images[1].imgUrl),
                                      ),
*/
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
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
                                margin: EdgeInsets.only(left: 0, top: 10),
                                width: 500,
                                height: 330,
                                decoration: BoxDecoration(
                                  shape: BoxShape.rectangle,
                                  borderRadius: BorderRadius.circular(8.0),
                                  border: (chooseImgId == 2)
                                      ? Border.all(
                                          color: Colors.green, width: 8)
                                      : Border.all(
                                          color: Colors.white, width: 4),
                                  image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: imageSnap3.image,
                                  ),
/*
                                      fit: BoxFit.cover,
                                      image:
                                          NetworkImage(widget.images[2].imgUrl)
                                      // image: AssetImage(widget.images[2].imgUrl),
                                      ),
*/
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
                                margin: EdgeInsets.only(left: 10, top: 10),
                                width: 500,
                                height: 330,
                                decoration: BoxDecoration(
                                  shape: BoxShape.rectangle,
                                  borderRadius: BorderRadius.circular(8.0),
                                  border: (chooseImgId == 3)
                                      ? Border.all(
                                          color: Colors.green, width: 8)
                                      : Border.all(
                                          color: Colors.white, width: 4),
                                  image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: imageSnap4.image,
                                  ),
/*
                                      fit: BoxFit.cover,
                                      image:
                                          NetworkImage(widget.images[3].imgUrl)
                                      // image: AssetImage(widget.images[3].imgUrl),
                                      ),
*/
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        margin: EdgeInsets.only(left: 5, top: 15),
                        alignment: Alignment.bottomCenter,
                        child: ElevatedButton(
                          onPressed: () {
                            AudioPlayer().play(AssetSource('audio/button.mp3'));
                            // Add
                            _goToEffect();
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 30, vertical: 12),
                            child: StrokeText(
                              text: "결정",
                              textStyle: TextStyle(
                                fontSize: 85,
                                color: Colors.black,
                                fontFamily: 'GulyFont',
                              ),
                              strokeColor: Colors.white,
                              strokeWidth: 5,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.teal,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                                side: BorderSide(
                                  width: 5,
                                  color: Colors.white,
                                )),
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
