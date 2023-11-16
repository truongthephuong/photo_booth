import 'dart:async';
import 'package:flutter/material.dart';
import './screens/home.dart';
import './screens/photo_cam.dart';
import './screens/login_screen.dart';
import 'package:camera/camera.dart';
//import 'package:camera_windows/camera_windows.dart';
import 'package:camera_platform_interface/camera_platform_interface.dart';
List<CameraDescription> cameras = [];

Future<void> main() async {

  try {
    WidgetsFlutterBinding.ensureInitialized();
    cameras = await availableCameras();
    //cameras = await CameraPlatform.instance.availableCameras();
  } on CameraException catch (e) {
    print('Error in fetching the cameras: $e');
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Photo Booth',
      routes: {
        //'/': (context) => const IntroScreen(),
        '/': (context) => UserLoginScreen(),
        '/photo_cam': (context) => const TakePictureScreen(),
        '/home': (context) => const IntroScreen(),
        //'/detail_content': (context) => DetailContentScreen(0),
      },
      theme: ThemeData(
        primarySwatch: black,
      ),
    );
  }
}


