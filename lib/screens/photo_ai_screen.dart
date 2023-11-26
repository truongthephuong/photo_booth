import 'dart:async';
import 'dart:io';
import 'package:carousel_slider/carousel_slider.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:photobooth_section1/models/image_model.dart';
import 'package:photobooth_section1/screens/photo_list_screen.dart';
import 'package:photobooth_section1/screens/photo_section_screen.dart';

import '../data_sources/helper.dart';

class PhotoAiScreen extends StatefulWidget {
  // Debug
  List<ImageModel> images = [];
  PhotoAiScreen({required this.images});

  @override
  State<PhotoAiScreen> createState() => _PhotoAiScreenState();
}

class _PhotoAiScreenState extends State<PhotoAiScreen> {
  bool isImageSelected = false;
  String imgSelect = '';
  int cntImg = 0;

  @override
  void initState() {
    WidgetsFlutterBinding.ensureInitialized();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //List imgList = ModalRoute.of(context)!.settings.arguments as List;
    List<ImageModel> imgList = widget.images;
    // print('on build widget ');
    // print(imgList[0]);
    return MaterialApp(
      title: "Select images",
      //debugShowCheckedModeBanner: false,
      //darkTheme: ThemeData.dark(),
      home: Scaffold(
        appBar: AppBar(
          title: const Text(
            "Select images",
            style: TextStyle(color: Colors.black),
          ),
          backgroundColor: Colors.amberAccent,
          centerTitle: true,
        ),
        body: Center(
          child: Column(
            children: [
              const SizedBox(height: 10),
              CarouselSlider(
                options: CarouselOptions(
                  autoPlay: false,
                  autoPlayInterval: const Duration(seconds: 2),
                  autoPlayAnimationDuration: const Duration(milliseconds: 400),
                  height: 250,
                ),
                items: imgList.map((item) {
                  return GridTile(
                    footer: Container(
                        padding: const EdgeInsets.all(15),
                        color: Colors.black54,
                        child: Text(
                          item.id.toString(),
                          style: const TextStyle(
                              color: Colors.white, fontSize: 20),
                          textAlign: TextAlign.center,
                        )),
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          isImageSelected = true;
                          imgSelect = item.imgUrl;
                        });

                        // print('Select image');
                        // print(imgSelect);
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text(
                          'You had choise : ' + item.imgUrl,
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                          ),
                        )));
                      },
                      child:
                          Image.file(File(item.imgUrl), fit: BoxFit.fitWidth),
                      //child: Image.asset(item.imgUrl, fit: BoxFit.fitWidth),
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: 30),
              // const Text(
              //   'Other Content',
              //   style: TextStyle(
              //     fontSize: 24,
              //   ),
              //   textAlign: TextAlign.center,
              // ),
              isImageSelected
                  ? Expanded(
                      child: Container(
                        height: 512,
                        width: 512,
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Image.file(File(imgSelect)),
                              //child: Image.asset(imgSelect),
                            ),
                          ],
                        ),
                      ),
                    )
                  : Container(
                      /*
                    child: const Text(
                      'Not yet select picture, please choose picture',
                      style: TextStyle(
                        fontSize: 24,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  */
                      ),
              FloatingActionButton.extended(
                label: Text('Apply Effect'),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => PhotoListScreen(
                              imgUrl: imgSelect,
                            )),
                  );
                },
                icon: Icon(
                  Icons.app_registration,
                  size: 24.0,
                ),
                backgroundColor: Colors.blueAccent,
                elevation: 0.0,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
