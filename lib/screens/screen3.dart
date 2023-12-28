import 'dart:async';
import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:camera/camera.dart';
import 'package:camera_platform_interface/camera_platform_interface.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:path_provider/path_provider.dart';
import 'package:photobooth_section1/models/image_model.dart';
import 'package:photobooth_section1/palatter.dart';
import 'package:photobooth_section1/screens/screen4.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';
import 'dart:math';
import 'package:path/path.dart' as path;
import 'package:image/image.dart' as img;
import 'package:stroke_text/stroke_text.dart';

class Screen3 extends StatefulWidget {
  @override
  State<Screen3> createState() => _Screen3State();
}

class _Screen3State extends State<Screen3> {
  late CameraController _controller;
  late List<CameraDescription> _cameras;
  bool isCameraReady = false;

  List<ImageModel> savedImages = [];
  File? _imageFile;
  String userDirPath = '';

  int _countdown = 3;
  late Timer _timer;
  bool startCount = false;
  bool okToTimer = true;

  int _cameraIndex = 0;
  int _cameraId = -1;
  bool _initialized = false;

  ResolutionPreset _resolutionPreset = ResolutionPreset.veryHigh;
  StreamSubscription<CameraErrorEvent>? _errorStreamSubscription;
  StreamSubscription<CameraClosingEvent>? _cameraClosingStreamSubscription;
  Size? _previewSize;

  @override
  void initState() {
    super.initState();
    _freshPhotoDir();
    WidgetsFlutterBinding.ensureInitialized();
    _fetchCameras();
  }

  /// Fetches list of available cameras from camera_windows plugin.
  Future<void> _fetchCameras() async {
    String cameraInfo;
    List<CameraDescription> cameras = <CameraDescription>[];

    int cameraIndex = 0;
    try {
      cameras = await CameraPlatform.instance.availableCameras();
      if (cameras.isEmpty) {
        cameraInfo = 'No available cameras';
      } else {
        cameraIndex = _cameraIndex % cameras.length;
        cameraInfo = 'Found camera: ${cameras[cameraIndex].name}';
      }
    } on PlatformException catch (e) {
      cameraInfo = 'Failed to get cameras: ${e.code}: ${e.message}';
    }

    print(cameraInfo);

    if (mounted) {
      setState(() {
        _cameraIndex = cameraIndex;
        _cameras = cameras;
      });

      _initializeCamera();
    }
  }

  /// Initializes the camera on the device.
  Future<void> _initializeCamera() async {
    if (_cameras.isEmpty) {
      return;
    }

    int cameraId = -1;
    try {
      final int cameraIndex = _cameraIndex % _cameras.length;
      final CameraDescription camera = _cameras[cameraIndex];

      cameraId = await CameraPlatform.instance.createCamera(
        camera,
        _resolutionPreset,
      );

      unawaited(_errorStreamSubscription?.cancel());
      _errorStreamSubscription = CameraPlatform.instance
          .onCameraError(cameraId)
          .listen(_onCameraError);

      unawaited(_cameraClosingStreamSubscription?.cancel());
      _cameraClosingStreamSubscription = CameraPlatform.instance
          .onCameraClosing(cameraId)
          .listen(_onCameraClosing);

      final Future<CameraInitializedEvent> initialized =
          CameraPlatform.instance.onCameraInitialized(cameraId).first;

      await CameraPlatform.instance.initializeCamera(
        cameraId,
      );

      final CameraInitializedEvent event = await initialized;
      _previewSize = Size(
        event.previewWidth,
        event.previewHeight,
      );

      if (mounted) {
        setState(() {
          _initialized = true;
          _cameraId = cameraId;
          _cameraIndex = cameraIndex;
        });
      }
    } on CameraException catch (e) {
      try {
        if (cameraId >= 0) {
          await CameraPlatform.instance.dispose(cameraId);
        }
      } on CameraException catch (e) {
        debugPrint('Failed to dispose camera: ${e.code}: ${e.description}');
      }

      // Reset state.
      if (mounted) {
        setState(() {
          _initialized = false;
          _cameraId = -1;
          _cameraIndex = 0;
          _previewSize = null;
        });
      }
    }
  }

  void _onCameraError(CameraErrorEvent event) {}

  void _onCameraClosing(CameraClosingEvent event) {}

  _freshPhotoDir() async {
    setState(() {
      savedImages = [];
    });
    Directory current = Directory.current;

    // Parent folder
    final String internalFolder = path.join(current.path, 'myphotos');
    bool exists = await Directory(internalFolder).exists();
    if (exists) {
      final Directory dir = Directory(internalFolder);
      dir.deleteSync(recursive: true);
    }
  }

  @override
  void dispose() {
    _disposeCurrentCamera();
    _errorStreamSubscription?.cancel();
    _errorStreamSubscription = null;
    _cameraClosingStreamSubscription?.cancel();
    _cameraClosingStreamSubscription = null;
    super.dispose();
  }

  void startTimer() {
    const twoSec = const Duration(seconds: 2);
    _timer = Timer.periodic(twoSec, (Timer timer) {
      if (_countdown == 0) {
        timer.cancel();
        takePhoto();
        _countdown = 3;
        startCount = false;
        if (okToTimer) {
          AudioPlayer().play(AssetSource('audio/take_picture.mp3'));
          startTimer();
        }
      } else {
        setState(() {
          _countdown--;
          startCount = true;
        });
      }
    });
  }

  Future<void> _disposeCurrentCamera() async {
    if (_cameraId >= 0 && _initialized) {
      try {
        await CameraPlatform.instance.dispose(_cameraId);

        if (mounted) {
          setState(() {
            _initialized = false;
            _cameraId = -1;
            _previewSize = null;
          });
        }
      } on CameraException catch (e) {
        if (mounted) {
          print('Failed to dispose camera: ${e.code}: ${e.description}');
        }
      }
    }
  }

  void takePhoto() async {
    try {
      if (savedImages.length > 2) {
        setState(() {
          okToTimer = false;
        });
        Timer(Duration(seconds: 5), () {
          Navigator.pop(context);
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => Screen4(
                        images: savedImages,
                      )));
        });
      }

      // Capture photo
      final XFile file = await CameraPlatform.instance.takePicture(_cameraId);

      // Get directory to save
      Directory current = Directory.current;

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

      setState(() {
        userDirPath = userDir;
      });

      // User folder
      final String tempUserDir = path.join(userDir, 'User');
      await Directory(tempUserDir).create(recursive: true);

      // Save photo
      int userPhotoId = savedImages.length + 1;
      final String userPath = path.join(tempUserDir, path.basename(file.path));
      await File(file.path).copy(userPath);

      // setState(() {
      //   _imageFile = File(userPath);
      // });

      final ImageModel savedImage = ImageModel(
        id: userPhotoId,
        title: 'user_photo_$userPhotoId',
        imgUrl: userPath,
      );

      setState(() {
        savedImages.add(savedImage);
      });
    } catch (e) {
      print("Error taking photo: $e");
    }
  }

  Future<void> _cropPhoto() async {
    if (_imageFile == null) {
      return;
    }

    final image = img.decodeImage(await _imageFile!.readAsBytes())!;
    var cropSize = min(image.width, image.height);
    int offsetX = (image.width - cropSize) ~/ 2;
    int offsetY = (image.height - cropSize) ~/ 2;

    final croppedImage = img.copyCrop(image, offsetX, offsetY, 500, 350);

    // Temp folder
    final String tempUserDir = path.join(userDirPath, 'User');
    await Directory(tempUserDir).create(recursive: true);

    // Save photo
    int userPhotoId = savedImages.length + 1;
    final String userPath =
        path.join(tempUserDir, 'user_photo_$userPhotoId.jpg');
    File(userPath).writeAsBytesSync(img.encodeJpg(croppedImage));

    final ImageModel savedImage = ImageModel(
      id: userPhotoId,
      title: 'user_photo_$userPhotoId',
      imgUrl: userPath,
    );

    setState(() {
      savedImages.add(savedImage);
    });

    if (savedImages.length >= 4) {
      Timer(Duration(seconds: 5), () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => Screen4(
                      images: savedImages,
                    )));
      });
    }
  }

  Widget build(BuildContext context) {
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
            Container(
              //mainAxisAlignment: MainAxisAlignment.center,
              height: 500, //500
              //color: Colors.white70,
              margin: const EdgeInsets.only(
                left: 0.0, //10
                right: 10.0, //0
                top: 10.0,
                bottom: 1250,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/template/text-screen3-a.png',
                    width: 972, //1000
                    height: 324, //3840
                  )
                ],
              ),
            ),
            Container(
              //color: Colors.deepOrangeAccent,
              margin: const EdgeInsets.only(
                left: 10.0,
                right: 0.0,
                top: 70.0,
                bottom: 300,
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: 90),
                    // Rounded Image
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(
                                  color: Colors.white,
                                  width: 5,
                                ),
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              alignment: Alignment.center,
                              margin: EdgeInsets.only(left: 0, top: 320),
                              height: 635, //550
                              width: 840, //690
                              child: ClipRRect(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                                child: AspectRatio(
                                  aspectRatio: 10.0 / 7.5, //5/4
                                  // aspectRatio: _previewSize!.width /_previewSize!.height,
                                  child: CameraPlatform.instance
                                      .buildPreview(_cameraId),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              margin: EdgeInsets.only(left: 8, top: 20),
                              alignment: Alignment.bottomCenter,
                              child: ElevatedButton(
                                onPressed: () {
                                  AudioPlayer().play(
                                      AssetSource('audio/take_picture.mp3'));
                                  // Trigger start countdown
                                  startTimer();
                                },
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 30, vertical: 20),
                                  child: (startCount || savedImages.isNotEmpty)
                                      ? StrokeText(
                                          text:
                                              okToTimer ? '$_countdown' : "촬영",
                                          textStyle: TextStyle(
                                            fontSize: 80,
                                            color: Colors.black,
                                            fontFamily: 'GulyFont',
                                          ),
                                          strokeColor: Colors.white,
                                          strokeWidth: 5,
                                        )
                                      : StrokeText(
                                          text: "촬영",
                                          textStyle: TextStyle(
                                            fontSize: 80,
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
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    Container(
                      margin: EdgeInsets.only(left: 30, top: 20),
                      height: 220,
                      width: 900,
                      //color: Colors.green[200],
                      alignment: Alignment.center,
                      child: ThumbnailGridView(
                        images: savedImages,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        /*
        bottomNavigationBar: ThumbnailGridView(
          images: savedImages,
        ),

         */
      ),
    );
  }
}

class ThumbnailGridView extends StatelessWidget {
  final List<ImageModel> images;
  const ThumbnailGridView({Key? key, required this.images}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 180,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: images.length,
        itemBuilder: (context, index) {
          Image imageSnap = Image.file(
            File(images[index].imgUrl),
            width: 200.0,
            height: 180.0,
            fit: BoxFit.cover,
          );
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Stack(
              children: [
                Container(
                  width: 200.0,
                  height: 180.0,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: imageSnap.image,
                      fit: BoxFit.fill,
                    ),
                    border: Border.all(
                      color: Colors.white,
                      width: 5,
                    ),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
