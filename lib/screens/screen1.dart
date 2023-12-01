
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:photobooth_section1/screens/screen5.dart';
import '../palatter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/api_response.dart';

import '../widgets/background-image.dart';
import 'screen2.dart';

class Screen1 extends StatefulWidget {
  const Screen1({super.key});

  @override
  _Screen1State createState() => _Screen1State();
}

class _Screen1State extends State<Screen1> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  final _formKey = GlobalKey<FormState>();
  bool _validate = false;

  late String directory;
  List<FileSystemEntity> files = [];

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        BackGroundImage(),
        Scaffold(
          backgroundColor: Colors.transparent,
          /*
          appBar: AppBar(
            title: Text(
              "Photo Booth System",
              style: TextStyle(color: Colors.black),
            ),
            backgroundColor: Colors.amberAccent,
            centerTitle: true,
          ),
          */
          body: SingleChildScrollView(
            child: SafeArea(
              child: Column(
                children: [
                  Container(
                    height: 60,
                    child: Center(
                      child: RichText(
                          text: TextSpan(
                            text: '인공지능 ',
                            style: kHeading,
                            children: <TextSpan>[
                              TextSpan(text: '이 바꾸어주는 ', style: kHeading1),
                            ],
                          ),
                      ),
                    ),
                  ),
                  Container(
                    height: 50,
                    child: Center(
                      child: RichText(
                          text: TextSpan(text: '나의 모습', style: kHeading2),
                        ),
                    ),
                  ),
                  Container(
                    width: 1400,
                    height: 480,
                    child: Column(
                      children: [
                        Image.asset(
                          '/images/welcome.png',
                          width: 1400,
                          height: 480,
                        ),
                      ],
                    ),
                  ),
                  Form(
                    key: _formKey,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        children: [
                          Column(
                            children: [
                              SizedBox(
                                height: 20,
                              ),
                              Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(16)
                                ),
                                width: 256,
                                child: ElevatedButton(
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(vertical: 10),
                                      child: Text(
                                        '시작',
                                        style: kButton,
                                      ),
                                    ),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.white.withOpacity(0.9),
                                    ),
                                    onPressed: () {
                                      Navigator.pop(context);
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: (context) => Screen5()),
                                      );
                                    }),
                              ),
                              SizedBox(
                                height: 20,
                              ),

                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }


  Future<String> createFolder(String cow) async {
    print('Begin create folder');
    final folderName = cow;
    final path = Directory(folderName);
    var status = await Permission.storage.status;
    if (!status.isGranted) {
      await Permission.storage.request();
    }
    if ((await path.exists())) {
      return 'existed';
    } else {
      path.create();
      return path.path;
    }
  }

  static Future<String> getExternalDocumentPath() async {
    // To check whether permission is given for this app or not.
    var status = await Permission.storage.status;
    if (!status.isGranted) {
      // If not we will ask for permission first
      await Permission.storage.request();
    }
    Directory _directory = Directory("");
    if (Platform.isAndroid) {
      // Redirects it to download folder in android
      _directory = Directory("/storage/emulated/0/Download");
    } else {
      _directory = await getApplicationDocumentsDirectory();
    }

    final exPath = _directory.path;
    print("Saved Path: $exPath");
    await Directory(exPath).create(recursive: true);
    return exPath;
  }

  static Future<String> get _localPath async {
    // final directory = await getApplicationDocumentsDirectory();
    // return directory.path;
    // To get the external path from device of download folder
    final String directory = await getExternalDocumentPath();
    return directory;
  }

}
