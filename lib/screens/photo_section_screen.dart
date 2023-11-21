import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../data_sources/helper.dart';
import '../widgets/nav-drawer.dart';
const _defaultColor = Color(0xFF34568B);

class PhotoSectionScreen extends StatefulWidget {
  const PhotoSectionScreen({super.key});

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
    Text('Home Page', style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold)),
    Text('From galary', style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold)),
    Text('From camera', style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold)),
  ];

  void _onItemTapped(int index) {
    print(index);
    // if(index == 1) {
    //   _pickImagefromGallery();
    // }
    if(index == 2) {
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
          elevation: 5
      ),
    );
  }

  List<ImgList> imgList = [
    ImgList(id : 6, imgUrl: 'assets/images/list-ngang/anime.png'),
    ImgList(id : 1, imgUrl: 'assets/images/list-ngang/caricature.png'),
    ImgList(id : 2, imgUrl: 'assets/images/list-ngang/cartoon.png'),
    ImgList(id : 3, imgUrl: 'assets/images/list-ngang/comic.png'),
    ImgList(id : 4, imgUrl: 'assets/images/list-ngang/pixar.png'),
    ImgList(id : 5, imgUrl: 'assets/images/list-ngang/slamdunk.png'),
  ];

  Widget _buildList() {
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
              child: Container(
                  width: 500,
                  height: 195,
                  child: Image.asset(item.imgUrl)
              ),
            )
        ],
      ),
    );
  }

}

class ImgList{
  String imgUrl;
  int id;
  ImgList({required this.imgUrl, required this.id});
}

class Tile extends StatelessWidget {
  const Tile({
    Key? key,
    required this.index,
    this.extent,
    this.backgroundColor,
    this.bottomSpace,
  }) : super(key: key);

  final int index;
  final double? extent;
  final double? bottomSpace;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    final child = Container(
      color: backgroundColor ?? _defaultColor,
      height: extent,
      child: Center(
        child: CircleAvatar(
          minRadius: 20,
          maxRadius: 20,
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          child: Text('$index', style: const TextStyle(fontSize: 20)),
        ),
      ),
    );

    if (bottomSpace == null) {
      return child;
    }

    return Column(
      children: [
        Expanded(child: child),
        Container(
          height: bottomSpace,
          color: Colors.green,
        )
      ],
    );
  }
}

class ImageTile extends StatelessWidget {
  const ImageTile({
    Key? key,
    required this.index,
    required this.width,
    required this.height,
  }) : super(key: key);

  final int index;
  final int width;
  final int height;

  @override
  Widget build(BuildContext context) {
    return Image.network(
      'https://picsum.photos/$width/$height?random=$index',
      width: width.toDouble(),
      height: height.toDouble(),
      fit: BoxFit.cover,
    );
  }
}
