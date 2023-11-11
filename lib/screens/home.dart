import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:video_player/video_player.dart';

import '../palatter.dart';
import '../screens/photo_list_screen.dart';
import '../screens/photo_cam.dart';
import '../screens/photo_capture.dart';

class IntroScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  late VideoPlayerController _controller;

  @override
  void initState() {
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

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  int _selectedIndex = 0;
  static const List<Widget> _widgetOptions = <Widget>[
    Text('Home Page', style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold)),
    Text('From galary', style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold)),
    Text('From camera', style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold)),
  ];

  void _onItemTapped(int index) {
    print(index);

    // if(index == 1) {
    //   _pickImagefromGallery();
    // }
    if(index == 2) {
      Navigator.pushNamedAndRemoveUntil(
          context as BuildContext, '/photo_cam', ModalRoute.withName('/photo_cam'));
    }

    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.green),

      // standard dark theme
      darkTheme: ThemeData.dark(),

      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Stack(
          children: <Widget>[
            SizedBox.expand(
              child: FittedBox(
                fit: BoxFit.cover,
                child: SizedBox(
                  width: _controller.value.size?.width ?? 0,
                  height: _controller.value.size?.height ?? 0,
                  child: VideoPlayer(_controller),
                ),
              ),
            ),
            //LoginWidget()
            _getContent(context)
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
            backgroundColor:Colors.black.withOpacity(0.1),
            currentIndex: _selectedIndex,
            selectedItemColor: Colors.green,
            unselectedItemColor: Colors.grey,
            iconSize: 40,
            onTap: _onItemTapped,
            elevation: 5
        ),
      ),
    );
  }

  _getVideoBackground() {
    var _visible;
    return AnimatedOpacity(
      opacity: _visible ? 1.0 : 0.0,
      duration: Duration(milliseconds: 1000),
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
        SizedBox(
          height: 50.0,
        ),
        Image(
          image: AssetImage("assets/images/logo.png"),
          width: 150.0,
        ),
        Text(
          "Photo - Booth",
          style: TextStyle(color: Colors.white, fontSize: 40),
        ),
        Container(
          margin: const EdgeInsets.only(left: 30.0, right: 30.0, top: 40.0),
          alignment: Alignment.center,
          child: Text(
            "View and share videos of current ocean conditions.",
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
        ),
        Spacer(),
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
            borderRadius: BorderRadius.all(Radius.circular(20))
        ),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: Colors.grey.withOpacity(0.1), // background
            onPrimary: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Text(
              'Get Photo',
              style: kBodyText,
            ),
          ),
          onPressed: () async {
            Navigator.pop(context);
            Navigator.push(
              context,
              //MaterialPageRoute( builder: (context) => PhotoCapture()),
              MaterialPageRoute( builder: (context) => TakePictureScreen()),
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
            borderRadius: BorderRadius.all(Radius.circular(20))
        ),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: Colors.grey.withOpacity(0.1),
            onPrimary: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Text(
              'Photo List',
              style: kBodyText,
            ),
          ),
          onPressed: () async {
            Navigator.pop(context);
            Navigator.push(
              context,
              MaterialPageRoute( builder: (context) => PhotoListScreen()),
            );
          },
        ),
      ),
    ];
  }


}