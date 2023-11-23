import 'dart:async';
import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';
import 'package:photobooth_section1/models/image_model.dart';
import 'package:photobooth_section1/screens/photo_list_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CameraApp extends StatefulWidget {
  @override
  _CameraAppState createState() => _CameraAppState();
}

class _CameraAppState extends State<CameraApp> {
  late CameraController _controller;
  late List<CameraDescription> cameras;
  bool isCameraReady = false;
  final List<String> images = [];

  int _countdown = 5;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _loadStoredValue();
    _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    cameras = await availableCameras();

    _controller = CameraController(cameras[0], ResolutionPreset.ultraHigh);
    await _controller.initialize();

    if (!mounted) return;

    setState(() {
      isCameraReady = true;
    });
  }

  void startTimer() {
    const oneSec = const Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_countdown == 0) {
          timer.cancel();
          takePhoto();
        } else {
          setState(() {
            _countdown--;
          });
        }
      },
    );
  }

  void takePhoto() async {
    if (_controller.value.isInitialized) {
      try {
        // Capture photo
        final XFile file = await _controller.takePicture();

        // Get directory to save
        Directory _documentDir = Directory('');
        _documentDir = await getApplicationDocumentsDirectory();

        SharedPreferences prefs = await SharedPreferences.getInstance();
        String _username = prefs.getString('username') ?? "";

        final String userDir = path.join(_documentDir.path, _username);
        await Directory(userDir).create(recursive: true);

        final String userPath = path.join(userDir, path.basename(file.path));
        await File(file.path).copy(userPath);

        // Test
        print('Photo captured: $userPath');

        images.add(userPath);

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PhotoListScreen(
              images: images,
            ),
          ),
        );
      } catch (e) {
        print('Error taking photo: $e');
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!isCameraReady) {
      return Container(); // or show loading indicator
    }

    return Scaffold(
      body: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          startTimer();
        },
        child: PhotoCamForm(_countdown, _controller),
      ),
    );
  }
}

class PhotoCamForm extends StatelessWidget {
  PhotoCamForm(this._countdown, this._controller);

  final int _countdown;
  final CameraController _controller;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CameraPreview(_controller),
        Center(
          child: Text(
            '$_countdown',
            style: TextStyle(fontSize: 60.0, color: Colors.white),
          ),
        ),
      ],
    );
  }
}

_loadStoredValue() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  Directory _documentDir = Directory('');
  _documentDir = await getApplicationDocumentsDirectory();
  print('on home screen');
  print(prefs.getString('username'));
  print('document dir' + _documentDir.path);
}
