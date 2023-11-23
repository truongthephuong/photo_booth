import 'dart:async';
import 'dart:io';
import 'package:carousel_slider/carousel_slider.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../data_sources/helper.dart';

class PhotoAiScreen extends StatefulWidget {

  @override
  State<PhotoAiScreen> createState() => _PhotoAiScreenState();
}

class _PhotoAiScreenState extends State<PhotoAiScreen> {
  bool isImageSelected = false;
  String imgSelect = '';

  @override
  void initState() {
    WidgetsFlutterBinding.ensureInitialized();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List imgList = ModalRoute.of(context)!.settings.arguments as List;
    print('on build widget ');
    print(imgList[0]);
    return MaterialApp(
      //debugShowCheckedModeBanner: false,
      //darkTheme: ThemeData.dark(),
      home: Column(
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
                      style: const TextStyle(color: Colors.white, fontSize: 20),
                      textAlign: TextAlign.center,
                    )),
                child: GestureDetector(
                    onTap: () {
                      setState(() {
                        isImageSelected = true;
                        imgSelect = item.imgUrl;
                      });

                      print('Select image');
                      print(imgSelect);
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content:
                          Text('You had choise : ' + item.imgUrl,
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                            ),
                          )
                          )
                      );
                    },
                    child: Image.asset(item.imgUrl, fit: BoxFit.fitWidth),
                  ),

              );
            }).toList(),
          ),
          const SizedBox(height: 30),
          const Text(
            'Other Content',
            style: TextStyle(
              fontSize: 24,
            ),
            textAlign: TextAlign.center,
          ),
          isImageSelected ? Expanded(
            child: Container(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset(imgSelect),
                  ),
                ],
              ),
            ),
          ) : Container(
            child: const Text(
              'Not yet select picture, please choose picture',
              style: TextStyle(
                fontSize: 24,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }

}
