import 'dart:async';
import 'dart:developer';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:video_player/video_player.dart';
import 'package:photobooth_section1/screens/screen3.dart';

import '../palatter.dart';
import '../widgets/background-image.dart';

class Screen2 extends StatefulWidget {
  const Screen2({super.key});

  @override
  State<StatefulWidget> createState() => _Screen2State();
}

class _Screen2State extends State<Screen2> {
  late VideoPlayerController _controller;
  String _storedUserValue = '';
  late CameraDescription firstCamera;

  static const MaterialColor black = MaterialColor(
    0xFFFFFFFF,
    <int, Color>{
      50: Color(0x00000000),
      100: Color(0x00000000),
      200: Color(0x00000000),
      300: Color(0x00000000),
      400: Color(0x00000000),
      500: Color(0x00000000),
      600: Color(0x00000000),
      700: Color(0x00000000),
      800: Color(0x00000000),
      900: Color(0x00000000),
    },
  );

  @override
  void initState() {
    _loadStoredValue();
    super.initState();
    _setCamera();
  }

  @override
  void dispose() {
    super.dispose();
    //_controller.dispose();
  }

  _setCamera() async {
    final cameras = await availableCameras();
    setState(() {
      firstCamera = cameras.first;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: black,
      ),
      // standard dark theme
      darkTheme: ThemeData.dark(),

      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Stack(
          children: [
            BackGroundImage(),
            Scaffold(
              backgroundColor: Colors.transparent,
              body: SingleChildScrollView(
                child: SafeArea(
                  child: Container(
                    margin: const EdgeInsets.only(
                        left: 30.0, right: 30.0, top: 0.0),
                    alignment: Alignment.center,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 60.0,
                        ),
                        Center(
                          child: RichText(
                            text: TextSpan(
                              text: '인공지능 ',
                              style: kHeading,
                              children: <TextSpan>[
                                TextSpan(text: '은 어떻게 ', style: kHeading1),
                                TextSpan(text: '나의 모습을 ', style: kButton),
                                TextSpan(text: '바꾸어 줄까요? ', style: kHeading1),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          width: 1500,
                          height: 580,
                          //color: Colors.green[200],
                          alignment: Alignment.center,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                width: 448,
                                height: 440,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: Colors.green[200],
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(15),
                                  child: Image.asset(
                                    'assets/images/screen2.gif',
                                    width: 450,
                                    height: 450,
                                  ),
                                ),
                              ),
                              Container(
                                width: 60,
                                height: 450,
                                //color: Colors.blue[200],
                              ),
                              Container(
                                width: 448,
                                height: 440,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: Colors.green[200],
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(15),
                                  child: Image.asset(
                                    'assets/images/screen2.gif',
                                    width: 450,
                                    height: 450,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              floatingActionButton: Align(
                child: FloatingActionButton(
                  backgroundColor: Colors.white54.withOpacity(0.2),
                  child: Icon(Icons.arrow_forward_ios_sharp, size: 30.0),
                  onPressed: () {
                    Navigator.push(
                      context,
                      //MaterialPageRoute(builder: (context) => CameraApp()),
                      MaterialPageRoute(builder: (context) => Screen3()),
                    );
                  },
                ),
                alignment: Alignment(1, 0.1),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _loadStoredValue() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print(prefs.getString('username'));

    setState(() {
      _storedUserValue = prefs.getString('username') ?? '';
    });
  }

  _getVideoBackground() {
    var visible;
    return AnimatedOpacity(
      opacity: visible ? 1.0 : 0.0,
      duration: const Duration(milliseconds: 1000),
      child: VideoPlayer(_controller),
    );
  }

  _getBackgroundColor() {
    return Container(
      color: Colors.black,
    );
  }

  _getContent(context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        const SizedBox(
          height: 50.0,
        ),
        /*
        const Image(
          image: AssetImage("assets/images/logo.png"),
          width: 150.0,
        ),
         */
        const Text(
          "MONGTAMEDIA",
          style: TextStyle(color: Colors.white, fontSize: 40),
        ),
        const Text(
          "Photo - Booth",
          style: TextStyle(color: Colors.white, fontSize: 40),
        ),
        Container(
          margin: const EdgeInsets.only(left: 30.0, right: 30.0, top: 40.0),
          alignment: Alignment.center,
          child: const Text(
            "View and share videos of current ocean conditions.",
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
        ),
        const Spacer(),
        ..._getLoginButtons(context)
      ],
    );
  }

  _getLoginButtons(context) {
    return <Widget>[
      Container(
        margin: const EdgeInsets.only(left: 20, right: 20),
        height: 80,
        width: 200,
        decoration: BoxDecoration(
            border: Border.all(
              color: Colors.black,
            ),
            borderRadius: const BorderRadius.all(Radius.circular(20))),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor: Colors.grey.withOpacity(0.1),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          child: const Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Text(
              'Get Photo',
              style: kBodyText,
            ),
          ),
          onPressed: () async {
            Navigator.pop(context);
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Screen3()),
              //MaterialPageRoute( builder: (context) => const TakePictureScreen()),
            );
          },
        ),
      ),
      Container(
        margin: const EdgeInsets.only(top: 10, left: 20, right: 20),
        height: 80,
        width: 200,
        decoration: BoxDecoration(
            border: Border.all(
              color: Colors.black,
            ),
            borderRadius: const BorderRadius.all(Radius.circular(20))),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor: Colors.grey.withOpacity(0.1),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          child: const Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Text(
              'Photo List',
              style: kBodyText,
            ),
          ),
          onPressed: () async {
            Navigator.pop(context);
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Screen3()),
            );
          },
        ),
      ),
    ];
  }
}
