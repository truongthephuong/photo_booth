import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'dart:async';
import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import '../main.dart';
import '../widgets/nav-drawer.dart';
import '../palatter.dart';

class TakePictureScreen extends StatefulWidget {
  @override
  _TakePictureScreenState createState() => _TakePictureScreenState();
}

class _TakePictureScreenState extends State<TakePictureScreen>
    with WidgetsBindingObserver {
  late CameraDescription camera;
  late CameraController controller;
  bool _isCameraInitialized = false;
  late String _url;
  final resolutionPresets = ResolutionPreset.values;
  ResolutionPreset currentResolutionPreset = ResolutionPreset.high;
  bool isImageSelected = false;
  File? imageFile;
  late File saveImagefile;

  int _selectedIndex = 0;
  static const List<Widget> _widgetOptions = <Widget>[
    Text('Home Page', style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold)),
    Text('From galary', style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold)),
    Text('From camera', style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold)),
  ];

  void _onItemTapped(int index) {
    print(index);
    if(index == 1) {
      _pickImagefromGallery();
    }
    if(index == 2) {
      Navigator.pushNamedAndRemoveUntil(
          context as BuildContext, '/photo_cam', ModalRoute.withName('/photo_cam'));
    }

    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    // Hide the status bar
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);

    onNewCameraSelected(cameras[0]);
    // TODO: implement initState
    super.initState();

  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
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

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    final CameraController? cameraController = controller;

    // App state changed before we got the chance to initialize.
    if (cameraController == null || !cameraController.value.isInitialized) {
      return;
    }

    if (state == AppLifecycleState.inactive) {
      // Free up memory when camera not active
      cameraController.dispose();
    } else if (state == AppLifecycleState.resumed) {
      // Reinitialize the camera with same properties
      onNewCameraSelected(cameraController.description);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 59, 59, 59),
      appBar: AppBar(
        title: const Text('Photo Booth - Get Photo'),
      ),
      body: Center(
        child: Column(
          children: [
            Container(
                padding: const EdgeInsets.all(8.0),
              child: Row(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(left: 10, right: 10),
                      height: 60,
                      width: 150,
                      decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.white,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(20))
                      ),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.white.withOpacity(0.1), // background
                          onPrimary: Colors.black,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Text(
                            'From Gallery',
                            style: kBodyText,
                          ),
                        ),
                        onPressed: () async {
                          await _pickImagefromGallery();
                        },
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 10, right: 10),
                      height: 60,
                      width: 170,
                      decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.white,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(20))
                      ),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.white.withOpacity(0.1), // background
                          onPrimary: Colors.black,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Text(
                            'From Camera',
                            style: kBodyText,
                          ),
                        ),
                        onPressed: () async {
                          await _captureImagefromCamera();
                        },
                      ),
                    ),
                  ]
              )
            ),
            isImageSelected
                ? Expanded (
              child: Container(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image(
                        image: FileImage(imageFile!),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 10, right: 10),
                      height: 60,
                      width: 150,
                      decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.white,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(20))
                      ),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.white.withOpacity(0.1), // background
                          onPrimary: Colors.black,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Text(
                            'Save Photo',
                            style: kBodyText,
                          ),
                        ),
                        onPressed: () async {
                          await _captureImagefromCamera();
                        },
                      ),
                    ),
                  ],
                ),

              ),
            )
                : Container(),
          ],
        ),
      ),
      drawer: NavDrawer(),
      bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
              backgroundColor: Colors.white,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.business),
              label: 'Business',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.camera),
              label: 'Camera',
            ),
          ],
          type: BottomNavigationBarType.shifting,
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.green,
          unselectedItemColor: Colors.grey,
          iconSize: 40,
          onTap: _onItemTapped,
          elevation: 5
      ),
    );
  }

  _pickImagefromGallery() async {
    try {
      final pickedImage =
      await ImagePicker().pickImage(source: ImageSource.gallery);
      if (pickedImage != null) {
        setState(() {
          imageFile = File(pickedImage.path);
          isImageSelected = true;
        });
      } else {
        print('User didnt pick any image.');
      }
    } catch (e) {
      print(e.toString());
    }
  }

  _pickImagefromCamera() async {
    try {
      final pickedImage =
      await ImagePicker().pickImage(source: ImageSource.camera);
      if (pickedImage != null) {
        setState(() {
          imageFile = File(pickedImage.path);
          print('Image from camera');
          print(imageFile);
          isImageSelected = true;
        });
        //_saveImage(pickedImage.path);
      } else {
        print('User didnt pick any image.');
      }
    } catch (e) {
      print(e.toString());
    }
  }

  _captureImagefromCamera() async {
    print('Load camera ');
    /// Capture Image in 5 seconds
    const captureInterval = Duration(seconds: 5);
    var capImage = null;
    try {

      Future.delayed(Duration(seconds: 5), () {
        print('auto get photo ');
        capImage = ImagePicker().pickImage(source: ImageSource.camera);
        if (capImage != null) {
          setState(() {
            imageFile = File(capImage.path);
            print('Image from camera');
            print(imageFile);
            isImageSelected = true;
          });
          //_saveImage(pickedImage.path);
        } else {
          print('User didnt pick any image.');
        }
      });
      capImage = await ImagePicker().pickImage(source: ImageSource.camera);
      if (capImage != null) {
        setState(() {
          imageFile = File(capImage.path);
          print('Image from camera');
          print(imageFile);
          isImageSelected = true;
        });
        //_saveImage(pickedImage.path);
      } else {
        print('User didnt pick any image.');
      }
    } catch (e) {
      print(e.toString());
    }
  }

  _saveImage() async {
    Uint8List bytes = await saveImagefile.readAsBytes();
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

}
