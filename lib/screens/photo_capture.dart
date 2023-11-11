import 'dart:async';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'dart:async';
import 'dart:io';

import '../main.dart';

class PhotoCapture extends  StatefulWidget {
  @override
  State<PhotoCapture> createState() => _PhotoCaptureState();
}

class _PhotoCaptureState extends State<PhotoCapture> with WidgetsBindingObserver {
  CameraController? controller;
  Timer? countdownTimer;
  Duration myDuration = const Duration(seconds: 10);
  late CameraDescription camera;
  //late CameraController controller;
  bool _isCameraInitialized = false;
  final resolutionPresets = ResolutionPreset.values;
  ResolutionPreset currentResolutionPreset = ResolutionPreset.high;

  @override
  void initState() {
    //SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
    onNewCameraSelected(cameras[0]);
    super.initState();
    //controller = CameraController(cameras[0], ResolutionPreset.max, imageFormatGroup: ImageFormatGroup.jpeg,);
    // controller?.initialize().then((_) {
    //   if (!mounted) {
    //     return;
    //   }
    //   setState(() {});
    // });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  void startTimer() {
    countdownTimer =
        Timer.periodic(const Duration(seconds: 1), (_) => setCountDown());
  }

  void setCountDown() {
    const reduceSecondsBy = 1;
    setState(() {
      final seconds = myDuration.inSeconds - reduceSecondsBy;
      if (seconds < 0) {
        countdownTimer!.cancel();
      } else {
        myDuration = Duration(seconds: seconds);
      }
    });
  }

  void onNewCameraSelected(CameraDescription cameraDescription) async {
    final previousCameraController = controller;
    // Instantiating the camera controller
    final CameraController cameraController = CameraController(
      cameraDescription,
      currentResolutionPreset,
      imageFormatGroup: ImageFormatGroup.jpeg,
    );

    // Dispose the previous controller
    await previousCameraController?.dispose();

    // Replace with the new controller
    if (mounted) {
      setState(() {
        controller = cameraController;
      });
    }

    // Update UI if controller updated
    cameraController.addListener(() {
      if (mounted) setState(() {});
    });

    // Initialize controller
    try {
      await cameraController.initialize();
    } on CameraException catch (e) {
      print('Error initializing camera: $e');
    }

    // Update the Boolean
    if (mounted) {
      setState(() {
        _isCameraInitialized = controller!.value.isInitialized;
      });
    }
  }

  /*
  Future<bool> _requestPermission() async {
    Map<Permission, PermissionStatus> result =
    await [Permission.storage, Permission.camera].request();
    if (result[Permission.storage] == PermissionStatus.granted &&
        result[Permission.camera] == PermissionStatus.granted) {
      return true;
    }
    return false;
  }

  Future<File?> _getImage(ImageSource source) async {
    final bool isGranted = await _requestPermission();
    if (!isGranted) {
      return null;
    }
    final ImagePicker _picker =   ImagePicker();
    final XFile? image = await _picker.pickImage(source: source);
    if (image != null) {
      return File(image.path);
    }
    return null;
  }

  _cropImage() async {
    File? croppedfile = await ImageCropper.cropImage(
        sourcePath: imagepath,
        aspectRatioPresets: [
          CropAspectRatioPreset.square,
          CropAspectRatioPreset.ratio3x2,
          CropAspectRatioPreset.original,
          CropAspectRatioPreset.ratio4x3,
          CropAspectRatioPreset.ratio16x9
        ],
        androidUiSettings: AndroidUiSettings(
          toolbarTitle: 'Image Cropper',
          toolbarColor: Colors.deepPurpleAccent,
          toolbarWidgetColor: Colors.white,
          initAspectRatio: CropAspectRatioPreset.original,
          lockAspectRatio: false,
        ),
        iosUiSettings: IOSUiSettings(
          minimumAspectRatio: 1.0,
        )
    );

    if (croppedfile != null) {
      imagefile = croppedfile;
      setState(() { });
    } else{
      print("Image is not cropped.");
    }
  }

  _saveImage() async {
    Uint8List bytes = await imagefile.readAsBytes();
    var result = await ImageGallerySaver.saveImage(
        bytes,
        quality: 80,
        name: "my_mage.jpg"
    );
    if(result["isSuccess"] == true){
      print("Image saved successfully.");
    } else{
      print(result["errorMessage"]);
    }
  }

   */

  @override
  Widget build(BuildContext context) {
    // if (!controller!.value.isInitialized) {
    //   return Container();
    // }
    String strDigits(int n) => n.toString().padLeft(2, '0');
    final days = strDigits(myDuration.inDays);
    // Step 7
    final hours = strDigits(myDuration.inHours.remainder(24));
    final minutes = strDigits(myDuration.inMinutes.remainder(60));
    final seconds = strDigits(myDuration.inSeconds.remainder(60));

    return Scaffold(
      body: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            CameraPreview(controller!),
            Text(
              '$minutes:$seconds',
              style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 30),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 100),
              child: ElevatedButton(
                  onPressed: startTimer, child: const Text("Start")),
            )
          ],
        ),
      ),
    );

  }

}