import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:photobooth_section1/models/ai_model.dart';
import 'package:photobooth_section1/screens/screen6.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../palatter.dart';
import '../widgets/background-image.dart';

class Screen5 extends StatefulWidget {
  String image;
  Screen5({required this.image});

  @override
  _Screen5State createState() => _Screen5State();
}

class _Screen5State extends State<Screen5> {
  List<AIModel> models = [
    AIModel(
        id: 1,
        img: 'assets/images/effective/Anime/Anime_man.gif',
        name: 'Anime'),
    AIModel(
        id: 2,
        img: 'assets/images/effective/Anime/Anime-woman.gif',
        name: 'Anime'),
    AIModel(
        id: 3,
        img: 'assets/images/effective/3dcartoon/3dcartoon-man.gif',
        name: '3Dcartoon'),
    AIModel(
        id: 4,
        img: 'assets/images/effective/3dcartoon/3dcartoon-woman.gif',
        name: '3Dcartoon'),
    AIModel(
        id: 5,
        img: 'assets/images/effective/AdorableGhost/AdorableGhost-man.gif',
        name: 'AdorableGhost'),
    AIModel(
      id: 6,
      img: 'assets/images/effective/AdorableGhost/AdorableGhost-woman.gif',
      name: 'AdorableGhost',
    ),
    AIModel(
        id: 7,
        img: 'assets/images/effective/Caricature/Caricature-man.gif',
        name: 'Caricature'),
    AIModel(
        id: 8,
        img: 'assets/images/effective/Caricature/Caricature-woman.gif',
        name: 'Caricature'),
    AIModel(
        id: 9,
        img: 'assets/images/effective/Cartoon/Cartoon-man.gif',
        name: 'Cartoon'),
    AIModel(
        id: 10,
        img: 'assets/images/effective/Cartoon/Cartoon-woman.gif',
        name: 'Cartoon'),
    AIModel(
        id: 11,
        img: 'assets/images/effective/Comic/Comic-man.gif',
        name: 'Comic'),
    AIModel(
        id: 12,
        img: 'assets/images/effective/Comic/Comic-woman.gif',
        name: 'Comic'),
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  void _callEffect(String imgUrl, String effectName, int effectID) {
    _handleEffect(imgUrl, effectName, effectID);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Screen6(imgUrl: imgUrl, effectName: effectName),
      ),
    );
  }

  _handleEffect(String imgUrl, String effectName, int effectID) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('aiEffectIDSess', effectID);
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> widgets = [];
    for (int i = 0; i < models.length; i++) {
      widgets.add(
        GestureDetector(
          onTap: () {
            _callEffect(widget.image, models[i].name, models[i].id);
          },
          child: Card(
            color: Colors.green[50],
            elevation: 8.0,
            margin: EdgeInsets.all(2.0),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child:
                      Image.asset(models[i].img, height: 110, fit: BoxFit.fill),
                ),
                Text(
                  models[i].name,
                  style: TextStyle(
                    fontSize: 12.0,
                    fontWeight: FontWeight.w700,
                    color: Colors.pink,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }

    return Stack(
      children: [
        BackGroundImage(),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: SingleChildScrollView(
            child: SafeArea(
              child: Container(
                margin:
                    const EdgeInsets.only(left: 10.0, right: 10.0, top: 0.0),
                alignment: Alignment.center,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 20.0,
                    ),
                    Center(
                      child: RichText(
                        text: TextSpan(
                          text: '인공지능 ',
                          style: kHeading,
                          children: <TextSpan>[
                            TextSpan(text: '은 어떻게 ', style: kHeading1),
                            TextSpan(
                                text: '은 어떻게 나를 바꾸어 줄까요? ', style: kHeading1),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    Container(
                      width: 500,
                      height: 580,
                      //color: Colors.green[200],
                      alignment: Alignment.center,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            //color: Colors.green[200],
                            width: 244,
                            height: 240,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Colors.green[200],
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: Image.file(File(widget.image)),
                            ),
                          ),
                          Container(
                            width: 500,
                            height: 300,
                            child: SizedBox(
                              width: double.infinity,
                              height: 390,
                              child: Container(
                                child: GridView(
                                  padding: const EdgeInsets.all(5),
                                  scrollDirection: Axis.vertical,
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 3,
                                    mainAxisSpacing: 2,
                                  ),
                                  children: widgets,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
