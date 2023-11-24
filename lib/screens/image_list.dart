import 'dart:io';

import 'package:flutter/material.dart';
import 'package:photobooth_section1/models/image_model.dart';

class ImageListScreen extends StatelessWidget {
  final List<ImageModel> images;

  const ImageListScreen({Key? key, required this.images}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Image List'),
      ),
      body: ListView.builder(
        itemCount: images.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(images[index].title),
            onTap: () {
              // Navigate to a detailed view or perform other actions
              // with the selected image if needed
              print('Selected Image: ${images[index].imgUrl}');
            },
          );
        },
      ),
    );
  }
}
