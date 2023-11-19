import 'dart:async';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class CameraApp extends StatefulWidget {
  @override
  _CameraAppState createState() => _CameraAppState();
}

class _CameraAppState extends State<CameraApp> {
  late CameraController _controller;
  late List<CameraDescription> cameras;
  bool isCameraReady = false;

  int _countdown = 5; // Set your desired countdown time
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    cameras = await availableCameras();

    _controller = CameraController(cameras[0], ResolutionPreset.medium);
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

        // Do something with the captured photo file
        print('Photo captured: ${file.path}');
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
      body: Stack(
        children: [
          CameraPreview(_controller),
          Center(
            child: Text(
              '$_countdown',
              style: TextStyle(fontSize: 40.0, color: Colors.white),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          startTimer();
        },
        child: Icon(Icons.camera),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
