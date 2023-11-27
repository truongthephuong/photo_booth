import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:photobooth_section1/screens/photo_ai_result.dart';

import '../data_sources/helper.dart';

const _defaultColor = Color(0xFF34568B);

class PhotoResultList extends StatefulWidget {
  final List<String> aiImages;
  const PhotoResultList({super.key, required this.aiImages});

  @override
  State<StatefulWidget> createState() => _PhotoResultListState();
}

class _PhotoResultListState extends State<PhotoResultList> {
  @override
  void initState() {
    /*
    seconds = 0;
    timer = Timer.periodic(Duration(seconds: 1), (Timer t) {
      setState(() {
        seconds++;
      });

      if(seconds == 30) {
        Navigator.pushNamedAndRemoveUntil(
            context, '/home', ModalRoute.withName('/home'));
      }
      print('on time ');
      print(seconds);
    });
     */
    // photoHelper.expireScreen(context);
    super.initState();
  }

  @override
  void dispose() {
    //timer?.cancel();
    super.dispose();
  }

  int _selectedIndex = 1;
  static const List<Widget> _widgetOptions = <Widget>[
    Text('Home Page',
        style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold)),
    Text('From galary',
        style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold)),
    Text('From camera',
        style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold)),
  ];

  final List<Map<String, dynamic>> _items = [
    {
      "id": 0,
      "title": "Anime",
      "actPage": '/home',
      "imgUrl": "assets/images/list-doc/anime.gif"
    },
    {
      'id': 1,
      'title': "Caricature",
      'actPage': 'cate1',
      "imgUrl": 'assets/images/list-doc/caricature.gif'
    },
    {
      'id': 2,
      'title': "Cartoon",
      'actPage': 'cate2',
      "imgUrl": 'assets/images/list-doc/cartoon.gif'
    },
    {
      'id': 3,
      'title': "Comic",
      'actPage': 'cate3',
      "imgUrl": 'assets/images/list-doc/comic.gif'
    },
    {
      'id': 4,
      'title': "Pixar",
      'actPage': 'cate4',
      "imgUrl": 'assets/images/list-doc/pixar.gif'
    },
    {
      'id': 5,
      'title': "Slamdunk",
      'actPage': 'cate5',
      "imgUrl": 'assets/images/list-doc/slamdunk.gif'
    },
    {
      'id': 6,
      'title': "Anime",
      'actPage': 'cate6',
      "imgUrl": 'assets/images/list-doc/anime.gif'
    },
    {
      'id': 7,
      'title': "Caricature",
      'actPage': 'cate7',
      "imgUrl": 'assets/images/list-doc/caricature.gif'
    },
    {
      'id': 8,
      'title': "slamdunk",
      'actPage': 'cate8',
      "imgUrl": 'assets/images/list-doc/slamdunk.gif'
    },
  ];

  @override
  Widget build(BuildContext context) {
    List imgList = widget.aiImages;
    return Scaffold(
      appBar: AppBar(
        title: const Text("All Photos Had Created"),
        backgroundColor: Colors.amberAccent,
        centerTitle: true,
      ),
      body: MasonryGridView.count(
        itemCount: imgList.length,
        padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 10),
        // the number of columns
        crossAxisCount: 2,
        // vertical gap between two items
        mainAxisSpacing: 4,
        // horizontal gap between two items
        crossAxisSpacing: 5,
        itemBuilder: (context, index) {
          // display each item with a card
          return Card(
            // Give each item a random background color
            color: Color.fromARGB(Random().nextInt(256), Random().nextInt(256),
                Random().nextInt(256), Random().nextInt(256)),
            key: ValueKey(index),
            child: SizedBox(
              //height: _items[index]['height'],
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          PhotoAiResult(imgUrl: imgList[index], aiEffectId: 0),
                    ),
                  );
                  // Navigator.pushNamedAndRemoveUntil(
                  //     context,
                  //     _items[index]['actPage'],
                  //     ModalRoute.withName(_items[index]['actPage']));
                },
                child: Column(
                  children: [
                    Image.file(File(imgList[index])),
                    //Image.asset(_items[index]['imgUrl']),
                    Text('AI Photo $index',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
