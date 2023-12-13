import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
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
      name: 'Anime',
      effect: 'anime-man',
    ),
    AIModel(
      id: 2,
      img: 'assets/images/effective/Anime/Anime-woman.gif',
      name: 'Anime',
      effect: 'anime-woman',
    ),
    AIModel(
      id: 3,
      img: 'assets/images/effective/3dcartoon/3dcartoon-man.gif',
      name: '3Dcartoon',
      effect: '3dcartoon-man',
    ),
    AIModel(
      id: 4,
      img: 'assets/images/effective/3dcartoon/3dcartoon-woman.gif',
      name: '3Dcartoon',
      effect: '3dcartoon-woman',
    ),
    AIModel(
      id: 5,
      img: 'assets/images/effective/AdorableGhost/AdorableGhost-man.gif',
      name: 'AdorableGhost',
      effect: 'AdorableGhost-man',
    ),
    AIModel(
        id: 6,
        img: 'assets/images/effective/AdorableGhost/AdorableGhost-woman.gif',
        name: 'AdorableGhost',
        effect: 'AdorableGhost-Woman'),
    AIModel(
      id: 7,
      img: 'assets/images/effective/Caricature/Caricature-man.gif',
      name: 'Caricature',
      effect: 'Caricature-man',
    ),
    AIModel(
      id: 8,
      img: 'assets/images/effective/Caricature/Caricature-woman.gif',
      name: 'Caricature',
      effect: 'Caricature-woman',
    ),
    AIModel(
      id: 9,
      img: 'assets/images/effective/Cartoon/Cartoon-man.gif',
      name: 'Cartoon',
      effect: 'Cartoon-man',
    ),
    AIModel(
      id: 10,
      img: 'assets/images/effective/Cartoon/Cartoon-woman.gif',
      name: 'Cartoon',
      effect: 'Cartoon-woman',
    ),
    AIModel(
      id: 11,
      img: 'assets/images/effective/Comic/Comic-man.gif',
      name: 'Comic',
      effect: 'comic-man',
    ),
    AIModel(
      id: 12,
      img: 'assets/images/effective/Comic/Comic-woman.gif',
      name: 'Comic',
      effect: 'comic-woman',
    ),
  /*
    AIModel(
      id: 13,
      img: 'assets/images/effective/GreenGoblin/GreenGoblin-man.gif',
      name: 'GreenGoblin',
      effect: 'GreenGoblin-man',
    ),
    AIModel(
      id: 14,
      img: 'assets/images/effective/GreenGoblin/GreenGoblin-woman.gif',
      name: 'GreenGoblin',
      effect: 'GreenGoblin-woman',
    ),
    AIModel(
      id: 15,
      img: 'assets/images/effective/HellFire/HellFire-man.gif',
      name: 'HellFire',
      effect: 'HellFire-man',
    ),
    AIModel(
      id: 16,
      img: 'assets/images/effective/HellFire/HellFire-woman.gif',
      name: 'HellFire',
      effect: 'HellFire-woman',
    ),
    AIModel(
      id: 17,
      img: 'assets/images/effective/Necromancer/Necromancer-man.gif',
      name: 'Necromancer',
      effect: 'necromancer-man',
    ),
    AIModel(
      id: 18,
      img: 'assets/images/effective/Necromancer/Necromancer-woman.gif',
      name: 'Necromancer',
      effect: 'necromancer-woman',
    ),
  */
    AIModel(
      id: 19,
      img: 'assets/images/effective/Nightcrawler/Nightcrawler-man.gif',
      name: 'Nightcrawler',
      effect: 'Nightcrawler-man',
    ),
    AIModel(
      id: 20,
      img: 'assets/images/effective/Nightcrawler/Nightcrawler-woman.gif',
      name: 'Nightcrawler',
      effect: 'Nightcrawler-woman',
    ),
    AIModel(
      id: 21,
      img: 'assets/images/effective/Pixar/Pixar-man.gif',
      name: 'Pixar',
      effect: 'pixar-man',
    ),
    AIModel(
      id: 22,
      img: 'assets/images/effective/Pixar/Pixar-woman.gif',
      name: 'Pixar',
      effect: 'pixar-woman',
    ),
    AIModel(
      id: 23,
      img: 'assets/images/effective/Romantic/Romantic-man.gif',
      name: 'Romantic',
      effect: 'romantic-man',
    ),
    AIModel(
      id: 24,
      img: 'assets/images/effective/Romantic/Romantic-woman.gif',
      name: 'Romantic',
      effect: 'romantic-woman',
    ),
  /*
    AIModel(
      id: 25,
      img: 'assets/images/effective/Ultraviolet/Ultraviolet-man.gif',
      name: 'Ultraviolet',
      effect: 'Ultraviolet-man',
    ),
    AIModel(
      id: 26,
      img: 'assets/images/effective/Ultraviolet/Ultraviolet-woman.gif',
      name: 'Ultraviolet',
      effect: 'Ultraviolet-woman',
    ),
    AIModel(
      id: 27,
      img: 'assets/images/effective/WalkingDead/WalkingDead-man.gif',
      name: 'WalkingDead',
      effect: 'walkingdead-man',
    ),
    AIModel(
      id: 28,
      img: 'assets/images/effective/WalkingDead/WalkingDead-woman.gif',
      name: 'WalkingDead',
      effect: 'walkingdead-woman',
    ),
    AIModel(
      id: 29,
      img: 'assets/images/effective/Witch/Witch-man.gif',
      name: 'Witch',
      effect: 'witch-man',
    ),
    AIModel(
      id: 30,
      img: 'assets/images/effective/Witch/Witch-woman.gif',
      name: 'Witch',
      effect: 'witch-woman',
    ),
  */
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
            _callEffect(widget.image, models[i].effect, models[i].id);
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
                  child: Container(
                    height: 110,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(models[i].img,),
                        fit: BoxFit.fill,
                      ),
                      //color: Colors.deepOrange,
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    //child: Image.asset(models[i].img, width: 80),
                  ),

                  //Image.asset(models[i].img, height: 110, fit: BoxFit.fill),
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
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SingleChildScrollView(
                child: SafeArea(
                  child: Container(
                    margin: const EdgeInsets.only(
                      left: 10.0,
                      right: 10.0,
                      top: 100.0,
                      bottom: 350,
                    ),
                    alignment: Alignment.center,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(
                            bottom: 80.0,
                          ),
                          width: 500,
                          height: 1200,
                          //color: Colors.green[200],
                          alignment: Alignment.center,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Center(
                                child: Container(
                                  width: 340.0,
                                  height: 336.0,
                                  decoration: BoxDecoration(
                                    //color: Colors.teal,
                                    border: Border.all(
                                      color: Colors.white,
                                      width: 1,
                                    ),
                                    borderRadius: BorderRadius.circular(15.0),
                                    image: DecorationImage(
                                      image: AssetImage('assets/template/screen5_layer.png'),
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                  child: Center(
                                    child: Container(
                                      margin: const EdgeInsets.only(
                                        top: 70.0,
                                      ),
                                      width: 490.0,
                                      height: 520.0,
                                      decoration: BoxDecoration(
                                        // border: Border.all(
                                        //   color: Colors.white,
                                        //   width: 1,
                                        // ),
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        image: DecorationImage(
                                          image: new FileImage(
                                            File(widget.image),
                                          ), // Add your foreground image path
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 20.0,
                              ),
                              Center(
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    textStyle: const TextStyle(fontSize: 30),
                                    backgroundColor: Colors.blueAccent,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                  ),
                                  onPressed: () {
                                    AudioPlayer().play(AssetSource('audio/button.mp3'));
                                    // Navigator.push(
                                    //   context,
                                    //   MaterialPageRoute(
                                    //       builder: (context) => Screen6(
                                    //             imgUrl: '',
                                    //             effectName: '',
                                    //           )),
                                    //   //MaterialPageRoute(builder: (context) => Screen3()),
                                    // );
                                  },
                                  child: const Padding(
                                    padding: EdgeInsets.symmetric(vertical: 20),
                                    child: Text(
                                      '스타일 선택',
                                      style: TextStyle(
                                        fontSize: 50,
                                        color: Colors.white,
                                        backgroundColor: Colors.blueAccent,
                                        fontFamily: 'GulyFont',
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 20.0,
                              ),
                              Container(
                                //color: Colors.white,
                                width: 500,
                                height: 500,
                                child: SizedBox(
                                  width: double.infinity,
                                  height: 500,
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
              )
            ],
          ),
        )
      ],
    );
  }
}
