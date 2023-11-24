import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../widgets/nav-drawer.dart';
import '../data_sources/helper.dart';

const _defaultColor = Color(0xFF34568B);

class PhotoListScreen extends StatefulWidget {
  const PhotoListScreen({super.key});

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
    photoHelper.expireScreen(context);
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
      "title": "Item 0",
      "actPage": '/home',
      "imgUrl": "assets/images/list-doc/anime.gif"
    },
    {
      'id': 1,
      'title': "Item 1",
      'actPage': 'cate1',
      "imgUrl": 'assets/images/list-doc/caricature.gif'
    },
    {
      'id': 2,
      'title': "Item 2",
      'actPage': 'cate2',
      "imgUrl": 'assets/images/list-doc/cartoon.gif'
    },
    {
      'id': 3,
      'title': "Item 3",
      'actPage': 'cate3',
      "imgUrl": 'assets/images/list-doc/comic.gif'
    },
    {
      'id': 4,
      'title': "Item 4",
      'actPage': 'cate4',
      "imgUrl": 'assets/images/list-doc/pixar.gif'
    },
    {
      'id': 5,
      'title': "Item 5",
      'actPage': 'cate5',
      "imgUrl": 'assets/images/list-doc/slamdunk.gif'
    },
    {
      'id': 6,
      'title': "Item 6",
      'actPage': 'cate6',
      "imgUrl": 'assets/images/list-doc/anime.gif'
    },
    {
      'id': 7,
      'title': "Item 7",
      'actPage': 'cate7',
      "imgUrl": 'assets/images/list-doc/caricature.gif'
    },
    {
      'id': 8,
      'title': "Item 8",
      'actPage': 'cate8',
      "imgUrl": 'assets/images/list-doc/slamdunk.gif'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Photo Editor Section"),
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
                  Navigator.pushNamedAndRemoveUntil(
                      context,
                      _items[index]['actPage'],
                      ModalRoute.withName(_items[index]['actPage']));
                },
                child: Column(
                  children: [
                    //Image.network(_items[index]['imgUrl']),
                    Image.asset(_items[index]['imgUrl']),
                    Text(_items[index]['title']),
                  ],
                ),
              ),
            ),
          );
        },
      ),
      drawer: const NavDrawer(),
      bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
              backgroundColor: Colors.white,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.account_box_outlined),
              label: 'Business',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.camera),
              label: 'Camera',
            ),
          ],
          type: BottomNavigationBarType.shifting,
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.green,
          unselectedItemColor: Colors.grey,
          iconSize: 40,
          onTap: _onItemTapped,
          elevation: 5),
    );
  }
}
