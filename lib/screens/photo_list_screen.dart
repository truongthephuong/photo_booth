import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:photobooth_section1/screens/photo_ai_result.dart';

import '../widgets/nav-drawer.dart';
import '../data_sources/helper.dart';

const _defaultColor = Color(0xFF34568B);

class PhotoListScreen extends StatefulWidget {
  final String imgUrl;
  const PhotoListScreen({super.key, required this.imgUrl});

  @override
  State<StatefulWidget> createState() => _PhotoListScreenState();
}

class _PhotoListScreenState extends State<PhotoListScreen> {
  // late Timer timer;
  // late int seconds;
  PhotoHelper photoHelper = new PhotoHelper();

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

  void _onItemTapped(int index) {
    print(index);
    // if(index == 1) {
    //   _pickImagefromGallery();
    // }
    if (index == 0) {
      Navigator.pushNamedAndRemoveUntil(
          context, '/home', ModalRoute.withName('/home'));
    }
    if (index == 2) {
      Navigator.pushNamedAndRemoveUntil(
          context, '/photo_cam', ModalRoute.withName('/photo_cam'));
    }

    setState(() {
      _selectedIndex = index;
    });
  }

/*
  // Generate a list of dummy items
  final List<Map<String, dynamic>> _items =
    List.generate(
      20, (index) => {
        "id": index,
        "title": "Item $index",
        "height": Random().nextInt(350) + 150.5
      });

*/
  final List<Map<String, dynamic>> _items = [
    {
      "id": 0,
      "title": "Anime",
      "effect": "anime",
      "actPage": '/home',
      "imgUrl": "assets/images/list-doc/anime.gif"
    },
    {
      'id': 1,
      'title': "Caricature",
      "effect": "caricature",
      'actPage': 'cate1',
      "imgUrl": 'assets/images/list-doc/caricature.gif'
    },
    {
      'id': 2,
      'title': "Cartoon",
      "effect": "cartoon",
      'actPage': 'cate2',
      "imgUrl": 'assets/images/list-doc/cartoon.gif'
    },
    {
      'id': 3,
      'title': "Comic",
      "effect": "comic",
      'actPage': 'cate3',
      "imgUrl": 'assets/images/list-doc/comic.gif'
    },
    {
      'id': 4,
      'title': "Pixar",
      "effect": "pixar",
      'actPage': 'cate4',
      "imgUrl": 'assets/images/list-doc/pixar.gif'
    },
    {
      'id': 5,
      'title': "Slamdunk",
      "effect": "slamdunk",
      'actPage': 'cate5',
      "imgUrl": 'assets/images/list-doc/slamdunk.gif'
    },
    {
      'id': 6,
      'title': "Anime",
      "effect": "anime",
      'actPage': 'cate6',
      "imgUrl": 'assets/images/list-doc/anime.gif'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Choose effect"),
        backgroundColor: Colors.amberAccent,
        centerTitle: true,
      ),
      body: MasonryGridView.count(
        itemCount: _items.length,
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
            key: ValueKey(_items[index]['id']),
            child: SizedBox(
              //height: _items[index]['height'],
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PhotoAiResult(
                          imgUrl: widget.imgUrl,
                          effectName: _items[index]['effect']),
                    ),
                  );
                  // Navigator.pushNamedAndRemoveUntil(
                  //     context,
                  //     _items[index]['actPage'],
                  //     ModalRoute.withName(_items[index]['actPage']));
                },
                child: Column(
                  children: [
                    Image.asset(_items[index]['imgUrl']),
                    //Image.asset(_items[index]['imgUrl']),
                    Text(_items[index]['title'],
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
