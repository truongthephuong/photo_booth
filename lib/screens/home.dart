import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:photobooth_section1/screens/photo_cam.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:video_player/video_player.dart';
import 'package:video_player_win/video_player_win.dart';

import '../palatter.dart';
import '../screens/photo_list_screen.dart';
import '../screens/photo_capture.dart';
import '../widgets/background-image.dart';
import '../screens/photo_section_screen.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({super.key});

  @override
  State<StatefulWidget> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  late VideoPlayerController _controller;
  String _storedUserValue = '';

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
    _controller = VideoPlayerController.asset("assets/videos/man_surfing.mp4");
    _controller.initialize().then((_) {
      _controller.setVolume(0);
      _controller.play();
      _controller.setLooping(true);
      Timer(const Duration(milliseconds: 100), () {
        setState(() {
          _controller.play();
        });
      });
    });
/*
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

 */

    //reload();
    super.initState();
  }

  void reload() {
    _controller?.dispose();

    _controller = VideoPlayerController.asset("assets/videos/man_surf.mp4");

    _controller!.initialize().then((value) {
      if (_controller!.value.isInitialized) {
        _controller!.play();
        setState(() {});

        _controller!.addListener(() {
          if (_controller!.value.isCompleted) {
            log("ui: player pos=${_controller!.value.position} (completed)");
          } else {
            log("ui: player pos=${_controller!.value.position}");
          }
        });
      } else {
        log("video file load failed");
      }
    }).catchError((e) {
      log("controller.initialize() error occurs: $e");
    });
    setState(() {});
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  int _selectedIndex = 0;
  static const List<Widget> _widgetOptions = <Widget>[
    Text('Home Page',
        style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold)),
    Text('From galary',
        style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold)),
    Text('From camera',
        style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold)),
  ];

  void _onItemTapped(int index) {
    print(index);

    if (index == 1) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => PhotoSectionScreen(images: [],)),
      );
    }
    if (index == 2) {
      Navigator.pushNamedAndRemoveUntil(
          context, '/photo_cam', ModalRoute.withName('/photo_cam'));
    }

    setState(() {
      _selectedIndex = index;
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
          /*
          children: <Widget>[
            SizedBox.expand(
              child: FittedBox(
                fit: BoxFit.cover,
                child: SizedBox(
                  width: _controller.value.size.width ?? 0,
                  height: _controller.value.size.height ?? 0,
                  child: VideoPlayer(_controller),
                ),
              ),
            ),
            //LoginWidget()
            _getContent(context)
          ],
           */
          children: [
            BackGroundImage(),
            Scaffold(
              backgroundColor: Colors.transparent,
              body: SingleChildScrollView(
                child: SafeArea(
                    child: Container(
                  margin:
                      const EdgeInsets.only(left: 30.0, right: 30.0, top: 40.0),
                  alignment: Alignment.center,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
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
                        margin: const EdgeInsets.only(left: 20, right: 20),
                        height: 80,
                        width: 200,
                        decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.black,
                            ),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(20))),
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
                              MaterialPageRoute(
                                  builder: (context) => CameraApp()),
                              //MaterialPageRoute( builder: (context) => const TakePictureScreen()),
                            );
                          },
                        ),
                      ),
                      Container(
                        margin:
                            const EdgeInsets.only(top: 10, left: 20, right: 20),
                        height: 80,
                        width: 200,
                        decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.black,
                            ),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(20))),
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
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const PhotoListScreen()),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                )),
              ),
            )
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
                backgroundColor: Colors.white,
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.account_box_outlined),
                label: 'Photo List',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.camera),
                label: 'Camera',
              ),
            ],
            type: BottomNavigationBarType.shifting,
            backgroundColor: Colors.black.withOpacity(0.1),
            currentIndex: _selectedIndex,
            selectedItemColor: Colors.black,
            unselectedItemColor: Colors.grey,
            iconSize: 40,
            onTap: _onItemTapped,
            elevation: 5),
      ),
    );
  }

  _loadStoredValue() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print('on home screen');
    print(prefs.getString('username'));

    setState(() {
      _storedUserValue = prefs.getString('username') ?? '';
    });
    print('_storedUserValue');
    print(_storedUserValue);
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
              MaterialPageRoute(builder: (context) => CameraApp()),
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
              MaterialPageRoute(builder: (context) => const PhotoListScreen()),
            );
          },
        ),
      ),
    ];
  }
}
