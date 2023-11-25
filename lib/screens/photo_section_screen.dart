import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:photobooth_section1/models/image_model.dart';
import 'package:photobooth_section1/screens/photo_ai_screen.dart';

import '../data_sources/helper.dart';
import '../widgets/nav-drawer.dart';

const _defaultColor = Color(0xFF34568B);

class PhotoSectionScreen extends StatefulWidget {
  final List<ImageModel> images;
  PhotoSectionScreen({Key? key, required this.images}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _PhotoSectionScreenState();
}

class _PhotoSectionScreenState extends State<PhotoSectionScreen> {
  PhotoHelper photoHelper = new PhotoHelper();

  @override
  void initState() {
    photoHelper.expireScreen(context);
    super.initState();
  }

  int _selectedIndex = 0;
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
    if (index == 2) {
      Navigator.pushNamedAndRemoveUntil(
          context, '/photo_cam', ModalRoute.withName('/photo_cam'));
    }

    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Photo Editor Section"),
        centerTitle: true,
      ),
      body: Container(
        padding: const EdgeInsets.only(left: 10),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: _buildList(),
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
              label: 'List Effective',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.camera),
              label: 'Camera',
            ),
          ],
          type: BottomNavigationBarType.shifting,
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.black,
          unselectedItemColor: Colors.grey,
          iconSize: 40,
          onTap: _onItemTapped,
          elevation: 5),
    );
  }

  List<ImgList> imgList = [
    ImgList(id: 6, imgUrl: 'assets/images/list-ngang/anime.png'),
    ImgList(id: 1, imgUrl: 'assets/images/list-ngang/caricature.png'),
    ImgList(id: 2, imgUrl: 'assets/images/list-ngang/cartoon.png'),
    ImgList(id: 3, imgUrl: 'assets/images/list-ngang/comic.png'),
    ImgList(id: 4, imgUrl: 'assets/images/list-ngang/pixar.png'),
    ImgList(id: 5, imgUrl: 'assets/images/list-ngang/slamdunk.png'),
  ];

  List<ImgList> imgList1 = [
    ImgList(id : 6, imgUrl: 'assets/images/bonsai.jpg'),
    ImgList(id : 1, imgUrl: 'assets/images/thuycanh.jpg'),
    ImgList(id : 2, imgUrl: 'assets/images/Berries01.jpg'),
    ImgList(id : 3, imgUrl: 'assets/images/hoa-tra-trang.jpg'),
    ImgList(id : 4, imgUrl: 'assets/images/mohinhvac.jpg'),
    ImgList(id : 5, imgUrl: 'assets/images/nam-an.jpg'),
  ];


  Widget _buildList() {
    //List<ImageModel> imgList = widget.images;// code of Huy
    var ImgCount = imgList.length;
    return Padding(
      padding: EdgeInsets.all(2.0),
      // list view to show images and list count
      child: ListView(
        scrollDirection: Axis.vertical,
        children: [
          Row(children: [
            // showing item count
            //Text("Image Count:$ImgCount"),
            SizedBox(width: 45),
          ]),
          // showing list of images
          for (var item in imgList)
            Center(
              child: GestureDetector(
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text('You had choise : ' + item.id.toString())));
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PhotoAiScreen(),
                      settings: RouteSettings(
                        arguments: imgList1,
                      ),
                    ),
                  );
                },
                child: Container(
                    width: 500,
                    height: 195,
                    //child: Image.file(File(item.imgUrl))), //code of Huy
                    child: Image.asset(item.imgUrl),),
              ),
            )
        ],
      ),
    );
  }
}

class ImgList {
  String imgUrl;
  int id;
  ImgList({required this.imgUrl, required this.id});
}

