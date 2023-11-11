import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../widgets/nav-drawer.dart';
const _defaultColor = Color(0xFF34568B);

class PhotoSectionScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _PhotoSectionScreenState();
}

class _PhotoSectionScreenState extends State<PhotoSectionScreen> {

  @override
  void initState() {
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
          context as BuildContext, '/photo_cam', ModalRoute.withName('/photo_cam'));
    }

    setState(() {
      _selectedIndex = index;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Photo Editor Section"),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.only(left: 10),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: _buildList(),
      ),
      drawer: NavDrawer(),
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
          elevation: 5
      ),
    );
  }

  Widget _buildList() {
    return GridView.custom(
      gridDelegate: SliverWovenGridDelegate.count(
        crossAxisCount: 2,
        mainAxisSpacing: 4,
        crossAxisSpacing: 4,
        pattern: [
          WovenGridTile(1),
          WovenGridTile(
            5 / 7,
            crossAxisRatio: 0.9,
            alignment: AlignmentDirectional.centerEnd,
          ),
        ],
      ),
      childrenDelegate: SliverChildBuilderDelegate(
            (context, index) => Tile(index: index),
      ),
    );

  }

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
