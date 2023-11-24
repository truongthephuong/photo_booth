import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:photobooth_section1/models/image_model.dart';
import 'package:photobooth_section1/screens/photo_cam.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../widgets/nav-drawer.dart';
import '../data_sources/helper.dart';

const _defaultColor = Color(0xFF34568B);

class PhotoListScreen extends StatefulWidget {
  final List<String> images;
  PhotoListScreen({super.key, required this.images});

  @override
  State<StatefulWidget> createState() => _PhotoListScreenState();
}

class _PhotoListScreenState extends State<PhotoListScreen> {
  // late Timer timer;
  // late int seconds;
  PhotoHelper photoHelper = new PhotoHelper();
  List<String> images = [];

  @override
  void initState() {
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
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => CameraApp()));
    }

    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    images = widget.images;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Photo Editor Section"),
        centerTitle: true,
      ),
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // Number of columns in the grid
          crossAxisSpacing: 8.0, // Spacing between columns
          mainAxisSpacing: 8.0, // Spacing between rows
        ),
        itemCount: images.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              print('Tapped on image at index $index');
            },
            child: Card(
              elevation: 2.0,
              child: Image.file(
                File(images[index]),
                fit: BoxFit.cover,
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

_loadImageList() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getStringList('images') as List<String>;
}
