import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:photobooth_section1/screens/screen4.dart';

class Screen3 extends StatefulWidget {
  @override
  State<Screen3> createState() => _Screen3State();
}

class _Screen3State extends State<Screen3> {
  late CameraController _controller;
  late List<CameraDescription> cameras;
  bool isCameraReady = false;

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
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Screen4()));
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
