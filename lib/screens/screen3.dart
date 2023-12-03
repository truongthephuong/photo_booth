import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_image/flutter_native_image.dart';
import 'package:path_provider/path_provider.dart';
import 'package:photobooth_section1/models/image_model.dart';
import 'package:photobooth_section1/screens/screen4.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart' as path;

class Screen3 extends StatefulWidget {
  @override
  State<Screen3> createState() => _Screen3State();
}

class _Screen3State extends State<Screen3> {
  late CameraController _controller;
  late List<CameraDescription> cameras;
  bool isCameraReady = false;
  List<ImageModel> savedImages = [];

  @override
  void initState() {
    super.initState();
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

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void startTimer() {
    takePhoto();
  }

  /**
   * Create folder inside root directory
   * 
   * Snap photo -> go to 'myphotos/{userID}/temp'
   * If user choose photo -> go into 'myphotos/{userID}/Target'
   * If photo apply AI -> go to Result with format 'myphotos/{userID}/Result/{Effect-ID}.png'
   */
  void takePhoto() async {
    if (_controller.value.isInitialized) {
      try {
        // Capture photo
        final XFile file = await _controller.takePicture();

        // Get directory to save
        Directory _tempDir = Directory('');
        _tempDir = await getTemporaryDirectory();

        Directory current = Directory.current;

        print('current dir');
        print(current.path);

        SharedPreferences prefs = await SharedPreferences.getInstance();

        // Parent folder
        final String internalFolder = path.join(current.path, 'myphotos');
        await Directory(internalFolder).create(recursive: true);

        // User folder
        DateTime now = DateTime.now();
        String _username = DateFormat('yyyyMMddkk').format(now);
        await prefs.setString("username", _username);

        final String userDir = path.join(internalFolder, _username);
        await Directory(userDir).create(recursive: true);

        // Temp folder
        final String tempUserDir = path.join(userDir, 'temp');
        await Directory(tempUserDir).create(recursive: true);

        // Save photo
        final String userPath =
            path.join(tempUserDir, path.basename(file.path));
        await File(file.path).copy(userPath);

        _resizePhoto(userPath);

        final ImageModel savedImage = ImageModel(
          id: savedImages.length + 1,
          title: '${_username} ${savedImages.length + 1}',
          actPage: 'actPaged1',
          imgUrl: userPath,
        );

        setState(() {
          savedImages.add(savedImage);
        });
      } catch (e) {
        print("Error taking photo: $e");
      }
    }
  }

  Future<String> _resizePhoto(String filePath) async {
    ImageProperties properties =
        await FlutterNativeImage.getImageProperties(filePath);
    int? width = properties.width;
    File compressedFile = await FlutterNativeImage.compressImage(filePath,
        quality: 80, targetWidth: 640, targetHeight: 628);
    print('resize path');
    print(compressedFile.path);
    return compressedFile.path;
  }

  Widget build(BuildContext context) {
    if (!isCameraReady) {
      return Container();
    }

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
                      text: '인공지능',
                      style: TextStyle(
                          fontSize: 60,
                          fontWeight: FontWeight.bold,
                          color: Colors.orangeAccent,
                          fontFamily: 'GulyFont'),
                      children: <TextSpan>[
                        TextSpan(
                          text: ' 은 어떻게 나를 바꾸어 줄까요?',
                          style: TextStyle(
                              fontSize: 60,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              fontFamily: 'GulyFont'),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  // Rounded Image
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          Container(
                            margin: EdgeInsets.only(left: 200),
                            height: 483,
                            width: 841,
                            child: ClipRRect(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              child: AspectRatio(
                                aspectRatio: 1,
                                child: CameraPreview(_controller),
                              ),
                            ),
                          )
                          // Container(
                          //   child: AspectRatio(
                          //     aspectRatio: 0.75,
                          //     child: CameraPreview(_controller),
                          //   ),
                          // )
                          // Container(
                          //   margin: EdgeInsets.only(left: 150),
                          //   width: 841,
                          //   height: 483,
                          //   decoration: BoxDecoration(
                          //     shape: BoxShape.rectangle,
                          //     //border: Border.all(color: Colors.white, width: 4),
                          //     image: DecorationImage(
                          //       fit: BoxFit.cover,
                          //       image:
                          //           AssetImage('assets/template/screen3.png'),
                          //     ),
                          //   ),
                          // ),
                        ],
                      ),
                      Column(
                        children: [
                          Container(
                            margin: EdgeInsets.only(left: 10, top: 390),
                            alignment: Alignment.bottomCenter,
                            child: ElevatedButton(
                              onPressed: () {
                                // Add
                                startTimer();
                              },
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 30, vertical: 20),
                                child: Text('촬영',
                                    style: TextStyle(
                                        fontSize: 45,
                                        color: Colors.black,
                                        fontFamily: 'GulyFont')),
                              ),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.green,
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

                  // SizedBox(
                  //   height: 20,
                  // ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class PhotoCamForm extends StatelessWidget {
  PhotoCamForm(this._controller);

  final CameraController _controller;

  Widget build(BuildContext context) {
    return CameraPreview(_controller);
  }
}
