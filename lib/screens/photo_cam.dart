import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';
import 'package:photobooth_section1/models/image_model.dart';
import 'package:photobooth_section1/screens/photo_ai_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:image/image.dart' as img;

class CameraApp extends StatefulWidget {
  @override
  _CameraAppState createState() => _CameraAppState();
}

class _CameraAppState extends State<CameraApp> {
  late CameraController _controller;
  late List<CameraDescription> cameras;
  bool isCameraReady = false;
  List<ImageModel> savedImages = [];

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
          _countdown = 5;
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

        final ImageModel savedImage = ImageModel(
          id: savedImages.length + 1,
          title: '${_username} ${savedImages.length + 1}',
          actPage: 'actPage1',
          imgUrl: userPath,
        );

        setState(() {
          savedImages.add(savedImage);
        });

        // img.Image? imageResize =
        //     img.decodeImage(File(userPath).readAsBytesSync());
        // imageResize = img.copyResize(imageResize!, height: 512, width: 512);

        //await saveImage(imageResize, userPath);
      } catch (e) {
        print('Error taking photo: $e');
      }
    }
  }

  Future<void> saveImage(img.Image? imageResize, String filePath) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String _username = prefs.getString('username') ?? "";

    File(filePath)
        .writeAsBytesSync(Uint8List.fromList(img.encodeJpg(imageResize!)));

    final ImageModel savedImage = ImageModel(
      id: savedImages.length + 1,
      title: '${_username} ${savedImages.length + 1}',
      actPage: 'actPage1',
      imgUrl: filePath,
    );

    setState(() {
      savedImages.add(savedImage);
    });
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
      appBar: AppBar(
        title: const Text(
          "Snap Photo",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.amberAccent,
        centerTitle: true,
      ),
      body: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          startTimer();
        },
        child: PhotoCamForm(_countdown, _controller),
      ),
      bottomNavigationBar: ThumbnailGridView(
        images: savedImages,
      ),
      floatingActionButton: FloatingActionButton.extended(
        label: Text('Go to gallery'),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PhotoAiScreen(
                images: savedImages,
              ),
            ),
          );
        },
        icon: Icon(Icons.navigate_next, size: 24.0),
        backgroundColor: Colors.blueAccent,
        elevation: 0.0,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
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
            style: TextStyle(fontSize: 100.0, color: Colors.blueAccent),
          ),
        ),
      ],
    );
  }
}

class ThumbnailGridView extends StatelessWidget {
  final List<ImageModel> images;

  const ThumbnailGridView({Key? key, required this.images}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: images.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Stack(
              children: [
                Image.file(
                  File(images[index].imgUrl),
                  width: 80.0,
                  height: 80.0,
                  fit: BoxFit.cover,
                ),
                // Positioned(
                //   top: 0,
                //   right: 0,
                //   child: IconButton(
                //     icon: Icon(Icons.close),
                //     onPressed: () {
                //       // Remove the photo from the provider
                //       images.removeAt(index);
                //       setState(() => {});
                //     },
                //   ),
                // ),
              ],
            ),
          );
        },
      ),
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
