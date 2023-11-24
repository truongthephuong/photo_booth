import 'dart:async';

import 'package:flutter/cupertino.dart';

class PhotoHelper {
  late Timer timer;
  late int seconds;

  void expireScreen(context) {
    seconds = 0;
    timer = Timer.periodic(Duration(seconds: 1), (Timer t) {
      seconds++;

      if(seconds == 30) {
        seconds = 0;
        timer?.cancel();
        Navigator.pushNamedAndRemoveUntil(
            context, '/home', ModalRoute.withName('/home'));
      }
      print('on time ');
      print(seconds);
    });
  }

}

class ImgList{
  String imgUrl;
  int id;
  ImgList({required this.imgUrl, required this.id});
}