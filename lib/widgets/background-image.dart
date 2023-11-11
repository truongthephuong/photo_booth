import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BackGroundImage extends StatelessWidget {
  const BackGroundImage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (bounds) => LinearGradient(
        colors: [Colors.black, Colors.black12],
        begin: Alignment.bottomCenter,
        end: Alignment.center,
      ).createShader(bounds),
      blendMode: BlendMode.darken,
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/main_bg.jpg'),
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(Colors.black45, BlendMode.darken)
          ),
        ),
      ),
    );
  }
}