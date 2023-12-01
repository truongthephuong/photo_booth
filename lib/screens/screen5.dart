import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:photobooth_section1/screens/screen6.dart';

import '../palatter.dart';
import '../widgets/background-image.dart';

class Screen5 extends StatefulWidget {
  const Screen5({super.key});

  @override
  _Screen5State createState() => _Screen5State();
}

class _Screen5State extends State<Screen5> {
  String txtLogin = 'Đăng Nhập';
  String txtLogout = 'Thoat';
  String txtFruit = 'Trái Cây';
  String txtService = 'Dịch vụ';
  String txtThuyCanh = 'Thủy canh';
  String txtNamAn = 'Nấm ăn';
  String txtChanNuoi = 'Chăn nuôi';
  String txtRaoVat = 'Rao vặt';
  String txtBonSai = 'Bon sai';
  String txtMoHinhVAC = 'Mô hình VAC';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        BackGroundImage(),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: SingleChildScrollView(
            child: SafeArea(
              child: Container(
                margin:
                    const EdgeInsets.only(left: 30.0, right: 30.0, top: 0.0),
                alignment: Alignment.center,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 80.0,
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
                    Container(
                      width: 1500,
                      height: 580,
                      //color: Colors.green[200],
                      alignment: Alignment.center,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            //color: Colors.green[200],
                            width: 448,
                            height: 440,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Colors.green[200],
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: Image.asset(
                                'assets/images/screen2.gif',
                                width: 450,
                                height: 450,
                              ),
                            ),
                          ),
                          Container(
                            width: 600,
                            height: 450,
                            child: SizedBox(
                              width: double.infinity,
                              height: 450,
                              child: GridView(
                                padding: const EdgeInsets.all(5),
                                scrollDirection: Axis.vertical,
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3,
                                  mainAxisSpacing: 2,
                                ),
                                children: [
                                  //Anime
                                  GestureDetector(
                                    onTap: () {
                                      print("Go to list cate");
                                    },
                                    child: Card(
                                      color: Colors.green[50],
                                      elevation: 8.0,
                                      margin: EdgeInsets.all(2.0),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(15)),
                                      child: Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Image.asset(
                                                'assets/images/effective/Anime/Anime_man.gif',
                                                height: 145,
                                                fit: BoxFit.fill),
                                          ),
                                          Text(
                                            'Anime-man',
                                            style: TextStyle(
                                              fontSize: 14.0,
                                              fontWeight: FontWeight.w700,
                                              color: Colors.pink,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      print("Go to list cate");
                                    },
                                    child: Card(
                                      color: Colors.green[50],
                                      elevation: 8.0,
                                      margin: EdgeInsets.all(2.0),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(15)),
                                      child: Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Image.asset(
                                                'assets/images/effective/Anime/Anime-woman.gif',
                                                height: 145,
                                                fit: BoxFit.fill),
                                          ),
                                          Text(
                                            'Anime-woman',
                                            style: TextStyle(
                                              fontSize: 14.0,
                                              fontWeight: FontWeight.w700,
                                              color: Colors.pink,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),

                                  //3DCartoon
                                  GestureDetector(
                                    onTap: () {
                                      print("Goto bon sai");
                                      Navigator.pop(context);
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => Screen6(
                                                imgUrl: 'test',
                                                effectName: 'aa'),
                                          ));
                                    },
                                    child: Card(
                                      color: Colors.green[50],
                                      elevation: 8.0,
                                      margin: EdgeInsets.all(2.0),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(15)),
                                      child: Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Image.asset(
                                                'assets/images/effective/3dcartoon/3dcartoon-man.gif',
                                                height: 145,
                                                fit: BoxFit.fill),
                                          ),
                                          Text(
                                            '3Dcartoon-man',
                                            style: TextStyle(
                                              fontSize: 14.0,
                                              fontWeight: FontWeight.w700,
                                              color: Colors.pink,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      print("Goto chan nuoi");
                                      Navigator.pop(context);
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => Screen6(
                                                imgUrl: 'aaa',
                                                effectName: 'test'),
                                          ));
                                    },
                                    child: Card(
                                      color: Colors.green[50],
                                      elevation: 8.0,
                                      margin: EdgeInsets.all(2.0),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(15)),
                                      child: Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Image.asset(
                                                'assets/images/effective/3dcartoon/3dcartoon-woman.gif',
                                                height: 145,
                                                fit: BoxFit.fill),
                                          ),
                                          Text(
                                            '3Dcartoon-woman',
                                            style: TextStyle(
                                              fontSize: 14.0,
                                              fontWeight: FontWeight.w700,
                                              color: Colors.pink,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),

                                  //AdorableGhost
                                  GestureDetector(
                                    onTap: () {
                                      print("pressed open google map");
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => Screen6(
                                                imgUrl: 'test',
                                                effectName: 'aaa')),
                                      );
                                    },
                                    child: Card(
                                      color: Colors.green[50],
                                      elevation: 8.0,
                                      margin: EdgeInsets.all(2.0),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(15)),
                                      child: Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Image.asset(
                                                'assets/images/effective/AdorableGhost/AdorableGhost-man.gif',
                                                height: 145,
                                                fit: BoxFit.fill),
                                          ),
                                          Text(
                                            'AdorableGhost-man',
                                            style: TextStyle(
                                              fontSize: 14.0,
                                              fontWeight: FontWeight.w700,
                                              color: Colors.pink,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      print("pressed open google map");
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => Screen6(
                                                imgUrl: 'aaa',
                                                effectName: 'Test')),
                                      );
                                    },
                                    child: Card(
                                      color: Colors.green[50],
                                      elevation: 8.0,
                                      margin: EdgeInsets.all(2.0),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(15)),
                                      child: Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Image.asset(
                                                'assets/images/effective/AdorableGhost/AdorableGhost-woman.gif',
                                                height: 145,
                                                fit: BoxFit.fill),
                                          ),
                                          Text(
                                            'AdorableGhost-woman',
                                            style: TextStyle(
                                              fontSize: 14.0,
                                              fontWeight: FontWeight.w700,
                                              color: Colors.pink,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),

                                  //Caricature
                                  GestureDetector(
                                    onTap: () {
                                      print("pressed open google map");
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => Screen6(
                                                imgUrl: 'aaa',
                                                effectName: 'test')),
                                      );
                                    },
                                    child: Card(
                                      color: Colors.green[50],
                                      elevation: 8.0,
                                      margin: EdgeInsets.all(2.0),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(15)),
                                      child: Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Image.asset(
                                                'assets/images/effective/Caricature/Caricature-man.gif',
                                                height: 145,
                                                fit: BoxFit.fill),
                                          ),
                                          Text(
                                            'Caricature-man',
                                            style: TextStyle(
                                              fontSize: 14.0,
                                              fontWeight: FontWeight.w700,
                                              color: Colors.pink,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      print("Go to list cate");
                                      Navigator.pop(context);
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => Screen6(
                                                imgUrl: 'aaa',
                                                effectName: 'test'),
                                          )); // create action handling method
                                    },
                                    child: Card(
                                      color: Colors.green[50],
                                      elevation: 8.0,
                                      margin: EdgeInsets.all(2.0),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(15)),
                                      child: Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Image.asset(
                                                'assets/images/effective/Caricature/Caricature-woman.gif',
                                                height: 145,
                                                fit: BoxFit.fill),
                                          ),
                                          Text(
                                            'Caricature-woman',
                                            style: TextStyle(
                                              fontSize: 14.0,
                                              fontWeight: FontWeight.w700,
                                              color: Colors.pink,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),

                                  //Cartoon
                                  GestureDetector(
                                    onTap: () {
                                      print("Goto nam an");
                                      Navigator.pop(context);
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => Screen6(
                                                imgUrl: 'aaa',
                                                effectName: 'test'),
                                          ));
                                    },
                                    child: Card(
                                      color: Colors.green[50],
                                      elevation: 8.0,
                                      margin: EdgeInsets.all(2.0),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(15)),
                                      child: Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Image.asset(
                                                'assets/images/effective/Cartoon/Cartoon-man.gif',
                                                height: 145,
                                                fit: BoxFit.fill),
                                          ),
                                          Text(
                                            'Cartoon-man',
                                            style: TextStyle(
                                              fontSize: 14.0,
                                              fontWeight: FontWeight.w700,
                                              color: Colors.pink,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      print("Goto bon sai");
                                      Navigator.pop(context);
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => Screen6(
                                                imgUrl: 'aaa',
                                                effectName: 'test'),
                                          ));
                                    },
                                    child: Card(
                                      color: Colors.green[50],
                                      elevation: 8.0,
                                      margin: EdgeInsets.all(2.0),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(15)),
                                      child: Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Image.asset(
                                                'assets/images/effective/Cartoon/Cartoon-woman.gif',
                                                height: 145,
                                                fit: BoxFit.fill),
                                          ),
                                          Text(
                                            'Cartoon-woman',
                                            style: TextStyle(
                                              fontSize: 14.0,
                                              fontWeight: FontWeight.w700,
                                              color: Colors.pink,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),

                                  //Comic
                                  GestureDetector(
                                    onTap: () {
                                      print("Goto chan nuoi");
                                      Navigator.pop(context);
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => Screen6(
                                                imgUrl: 'aaa',
                                                effectName: 'test'),
                                          ));
                                    },
                                    child: Card(
                                      color: Colors.green[50],
                                      elevation: 8.0,
                                      margin: EdgeInsets.all(2.0),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(15)),
                                      child: Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Image.asset(
                                                'assets/images/effective/Comic/Comic-man.gif',
                                                height: 145,
                                                fit: BoxFit.fill),
                                          ),
                                          Text(
                                            'Comic-man',
                                            style: TextStyle(
                                              fontSize: 14.0,
                                              fontWeight: FontWeight.w700,
                                              color: Colors.pink,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      print("pressed open google map");
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => Screen6(
                                                imgUrl: 'aaa',
                                                effectName: 'test')),
                                      );
                                    },
                                    child: Card(
                                      color: Colors.green[50],
                                      elevation: 8.0,
                                      margin: EdgeInsets.all(2.0),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(15)),
                                      child: Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Image.asset(
                                                'assets/images/effective/Comic/Comic-woman.gif',
                                                height: 145,
                                                fit: BoxFit.fill),
                                          ),
                                          Text(
                                            'Comic-woman',
                                            style: TextStyle(
                                              fontSize: 14.0,
                                              fontWeight: FontWeight.w700,
                                              color: Colors.pink,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),

                                  //GreenGoblin
                                  GestureDetector(
                                    onTap: () {
                                      print("pressed open google map");
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => Screen6(
                                                imgUrl: 'aaa',
                                                effectName: 'test')),
                                      );
                                    },
                                    child: Card(
                                      color: Colors.green[50],
                                      elevation: 8.0,
                                      margin: EdgeInsets.all(2.0),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(15)),
                                      child: Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Image.asset(
                                                'assets/images/effective/GreenGoblin/GreenGoblin-man.gif',
                                                height: 145,
                                                fit: BoxFit.fill),
                                          ),
                                          Text(
                                            'GreenGoblin-man',
                                            style: TextStyle(
                                              fontSize: 14.0,
                                              fontWeight: FontWeight.w700,
                                              color: Colors.pink,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      print("pressed open google map");
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => Screen6(
                                                imgUrl: 'aaa',
                                                effectName: 'test')),
                                      );
                                    },
                                    child: Card(
                                      color: Colors.green[50],
                                      elevation: 8.0,
                                      margin: EdgeInsets.all(2.0),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(15)),
                                      child: Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Image.asset(
                                                'assets/images/effective/GreenGoblin/GreenGoblin-woman.gif',
                                                height: 145,
                                                fit: BoxFit.fill),
                                          ),
                                          Text(
                                            'GreenGoblin-woman',
                                            style: TextStyle(
                                              fontSize: 14.0,
                                              fontWeight: FontWeight.w700,
                                              color: Colors.pink,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),

                                  //HellFire
                                  GestureDetector(
                                    onTap: () {
                                      print("Go to list cate");
                                      Navigator.pop(context);
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => Screen6(
                                                imgUrl: 'aaa',
                                                effectName: 'test'),
                                          )); // create action handling method
                                    },
                                    child: Card(
                                      color: Colors.green[50],
                                      elevation: 8.0,
                                      margin: EdgeInsets.all(2.0),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(15)),
                                      child: Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Image.asset(
                                                'assets/images/effective/HellFire/HellFire-man.gif',
                                                height: 145,
                                                fit: BoxFit.fill),
                                          ),
                                          Text(
                                            'HellFire-man',
                                            style: TextStyle(
                                              fontSize: 14.0,
                                              fontWeight: FontWeight.w700,
                                              color: Colors.pink,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      print("Goto nam an");
                                      Navigator.pop(context);
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => Screen6(
                                                imgUrl: 'aaa',
                                                effectName: 'test'),
                                          ));
                                    },
                                    child: Card(
                                      color: Colors.green[50],
                                      elevation: 8.0,
                                      margin: EdgeInsets.all(2.0),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(15)),
                                      child: Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Image.asset(
                                                'assets/images/effective/HellFire/HellFire-woman.gif',
                                                height: 145,
                                                fit: BoxFit.fill),
                                          ),
                                          Text(
                                            'HellFire-woman',
                                            style: TextStyle(
                                              fontSize: 14.0,
                                              fontWeight: FontWeight.w700,
                                              color: Colors.pink,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),

                                  //Necromancer
                                  GestureDetector(
                                    onTap: () {
                                      print("Goto bon sai");
                                      Navigator.pop(context);
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => Screen6(
                                                imgUrl: 'aaa',
                                                effectName: 'test'),
                                          ));
                                    },
                                    child: Card(
                                      color: Colors.green[50],
                                      elevation: 8.0,
                                      margin: EdgeInsets.all(2.0),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(15)),
                                      child: Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Image.asset(
                                                'assets/images/effective/Necromancer/Necromancer-man.gif',
                                                height: 145,
                                                fit: BoxFit.fill),
                                          ),
                                          Text(
                                            'Necromancer-man',
                                            style: TextStyle(
                                              fontSize: 14.0,
                                              fontWeight: FontWeight.w700,
                                              color: Colors.pink,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      print("Goto chan nuoi");
                                      Navigator.pop(context);
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => Screen6(
                                                imgUrl: 'aaa',
                                                effectName: 'test'),
                                          ));
                                    },
                                    child: Card(
                                      color: Colors.green[50],
                                      elevation: 8.0,
                                      margin: EdgeInsets.all(2.0),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(15)),
                                      child: Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Image.asset(
                                                'assets/images/effective/Necromancer/Necromancer-woman.gif',
                                                height: 145,
                                                fit: BoxFit.fill),
                                          ),
                                          Text(
                                            'Necromancer-woman',
                                            style: TextStyle(
                                              fontSize: 14.0,
                                              fontWeight: FontWeight.w700,
                                              color: Colors.pink,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),

                                  //Nightcrawler
                                  GestureDetector(
                                    onTap: () {
                                      print("pressed open google map");
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => Screen6(
                                                imgUrl: 'aaa',
                                                effectName: 'test')),
                                      );
                                    },
                                    child: Card(
                                      color: Colors.green[50],
                                      elevation: 8.0,
                                      margin: EdgeInsets.all(2.0),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(15)),
                                      child: Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Image.asset(
                                                'assets/images/effective/Nightcrawler/Nightcrawler-man.gif',
                                                height: 145,
                                                fit: BoxFit.fill),
                                          ),
                                          Text(
                                            'Nightcrawler-man',
                                            style: TextStyle(
                                              fontSize: 14.0,
                                              fontWeight: FontWeight.w700,
                                              color: Colors.pink,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      print("pressed open google map");
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => Screen6(
                                                imgUrl: 'aaa',
                                                effectName: 'test')),
                                      );
                                    },
                                    child: Card(
                                      color: Colors.green[50],
                                      elevation: 8.0,
                                      margin: EdgeInsets.all(2.0),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(15)),
                                      child: Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Image.asset(
                                                'assets/images/effective/Nightcrawler/Nightcrawler-woman.gif',
                                                height: 145,
                                                fit: BoxFit.fill),
                                          ),
                                          Text(
                                            'Nightcrawler-woman',
                                            style: TextStyle(
                                              fontSize: 14.0,
                                              fontWeight: FontWeight.w700,
                                              color: Colors.pink,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),

                                  //Pixar
                                  GestureDetector(
                                    onTap: () {
                                      print("pressed open google map");
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => Screen6(
                                                imgUrl: 'aaa',
                                                effectName: 'test')),
                                      );
                                    },
                                    child: Card(
                                      color: Colors.green[50],
                                      elevation: 8.0,
                                      margin: EdgeInsets.all(2.0),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(15)),
                                      child: Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Image.asset(
                                                'assets/images/effective/Pixar/Pixar-man.gif',
                                                height: 145,
                                                fit: BoxFit.fill),
                                          ),
                                          Text(
                                            'Pixar-man',
                                            style: TextStyle(
                                              fontSize: 14.0,
                                              fontWeight: FontWeight.w700,
                                              color: Colors.pink,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      print("Go to list cate");
                                      Navigator.pop(context);
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => Screen6(
                                                imgUrl: 'aaa',
                                                effectName: 'test'),
                                          )); // create action handling method
                                    },
                                    child: Card(
                                      color: Colors.green[50],
                                      elevation: 8.0,
                                      margin: EdgeInsets.all(2.0),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(15)),
                                      child: Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Image.asset(
                                                'assets/images/effective/Pixar/Pixar-woman.gif',
                                                height: 145,
                                                fit: BoxFit.fill),
                                          ),
                                          Text(
                                            'Pixar-woman',
                                            style: TextStyle(
                                              fontSize: 14.0,
                                              fontWeight: FontWeight.w700,
                                              color: Colors.pink,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),

                                  //Romantic
                                  GestureDetector(
                                    onTap: () {
                                      print("Goto nam an");
                                      Navigator.pop(context);
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => Screen6(
                                                imgUrl: 'aaa',
                                                effectName: 'test'),
                                          ));
                                    },
                                    child: Card(
                                      color: Colors.green[50],
                                      elevation: 8.0,
                                      margin: EdgeInsets.all(2.0),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(15)),
                                      child: Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Image.asset(
                                                'assets/images/effective/Romantic/Romantic-man.gif',
                                                height: 145,
                                                fit: BoxFit.fill),
                                          ),
                                          Text(
                                            'Romantic-man',
                                            style: TextStyle(
                                              fontSize: 14.0,
                                              fontWeight: FontWeight.w700,
                                              color: Colors.pink,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      print("Goto bon sai");
                                      Navigator.pop(context);
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => Screen6(
                                                imgUrl: 'aaa',
                                                effectName: 'test'),
                                          ));
                                    },
                                    child: Card(
                                      color: Colors.green[50],
                                      elevation: 8.0,
                                      margin: EdgeInsets.all(2.0),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(15)),
                                      child: Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Image.asset(
                                                'assets/images/effective/Romantic/Romantic-woman.gif',
                                                height: 145,
                                                fit: BoxFit.fill),
                                          ),
                                          Text(
                                            'Romantic-woman',
                                            style: TextStyle(
                                              fontSize: 14.0,
                                              fontWeight: FontWeight.w700,
                                              color: Colors.pink,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),

                                  //Ultraviolet
                                  GestureDetector(
                                    onTap: () {
                                      print("Goto chan nuoi");
                                      Navigator.pop(context);
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => Screen6(
                                                imgUrl: 'aaa',
                                                effectName: 'test'),
                                          ));
                                    },
                                    child: Card(
                                      color: Colors.green[50],
                                      elevation: 8.0,
                                      margin: EdgeInsets.all(2.0),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(15)),
                                      child: Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Image.asset(
                                                'assets/images/effective/Ultraviolet/Ultraviolet-man.gif',
                                                height: 145,
                                                fit: BoxFit.fill),
                                          ),
                                          Text(
                                            'Ultraviolet-man',
                                            style: TextStyle(
                                              fontSize: 14.0,
                                              fontWeight: FontWeight.w700,
                                              color: Colors.pink,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      print("pressed open google map");
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => Screen6(
                                                imgUrl: 'aaa',
                                                effectName: 'test')),
                                      );
                                    },
                                    child: Card(
                                      color: Colors.green[50],
                                      elevation: 8.0,
                                      margin: EdgeInsets.all(2.0),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(15)),
                                      child: Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Image.asset(
                                                'assets/images/effective/Ultraviolet/Ultraviolet-woman.gif',
                                                height: 145,
                                                fit: BoxFit.fill),
                                          ),
                                          Text(
                                            'Ultraviolet-woman',
                                            style: TextStyle(
                                              fontSize: 14.0,
                                              fontWeight: FontWeight.w700,
                                              color: Colors.pink,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),

                                  //WalkingDead
                                  GestureDetector(
                                    onTap: () {
                                      print("pressed open google map");
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => Screen6(
                                                imgUrl: 'aaa',
                                                effectName: 'test')),
                                      );
                                    },
                                    child: Card(
                                      color: Colors.green[50],
                                      elevation: 8.0,
                                      margin: EdgeInsets.all(2.0),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(15)),
                                      child: Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Image.asset(
                                                'assets/images/effective/WalkingDead/WalkingDead-man.gif',
                                                height: 145,
                                                fit: BoxFit.fill),
                                          ),
                                          Text(
                                            'WalkingDead-man',
                                            style: TextStyle(
                                              fontSize: 14.0,
                                              fontWeight: FontWeight.w700,
                                              color: Colors.pink,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      print("pressed open google map");
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => Screen6(
                                                imgUrl: 'aaa',
                                                effectName: 'test')),
                                      );
                                    },
                                    child: Card(
                                      color: Colors.green[50],
                                      elevation: 8.0,
                                      margin: EdgeInsets.all(2.0),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(15)),
                                      child: Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Image.asset(
                                                'assets/images/effective/WalkingDead/WalkingDead-woman.gif',
                                                height: 145,
                                                fit: BoxFit.fill),
                                          ),
                                          Text(
                                            'WalkingDead-woman',
                                            style: TextStyle(
                                              fontSize: 14.0,
                                              fontWeight: FontWeight.w700,
                                              color: Colors.pink,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),

                                  //Witch
                                  GestureDetector(
                                    onTap: () {
                                      print("Go to list cate");
                                      Navigator.pop(context);
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => Screen6(
                                                imgUrl: 'aaa',
                                                effectName: 'test'),
                                          )); // create action handling method
                                    },
                                    child: Card(
                                      color: Colors.green[50],
                                      elevation: 8.0,
                                      margin: EdgeInsets.all(2.0),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(15)),
                                      child: Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Image.asset(
                                                'assets/images/effective/Witch/Witch-man.gif',
                                                height: 145,
                                                fit: BoxFit.fill),
                                          ),
                                          Text(
                                            'Witch-man',
                                            style: TextStyle(
                                              fontSize: 14.0,
                                              fontWeight: FontWeight.w700,
                                              color: Colors.pink,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      print("Goto nam an");
                                      Navigator.pop(context);
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => Screen6(
                                                imgUrl: 'aaa',
                                                effectName: 'test'),
                                          ));
                                    },
                                    child: Card(
                                      color: Colors.green[50],
                                      elevation: 8.0,
                                      margin: EdgeInsets.all(2.0),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(15)),
                                      child: Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Image.asset(
                                                'assets/images/effective/Witch/Witch-woman.gif',
                                                height: 145,
                                                fit: BoxFit.fill),
                                          ),
                                          Text(
                                            'Witch-woman',
                                            style: TextStyle(
                                              fontSize: 14.0,
                                              fontWeight: FontWeight.w700,
                                              color: Colors.pink,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
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
