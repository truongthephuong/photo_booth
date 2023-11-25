import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:carousel_slider/carousel_slider.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:photobooth_section1/screens/photo_ai_result.dart';

import '../models/ai_payload.dart';
import '../palatter.dart';

class PhotoAiScreen extends StatefulWidget {

  @override
  State<PhotoAiScreen> createState() => _PhotoAiScreenState();
}

class _PhotoAiScreenState extends State<PhotoAiScreen> {
  bool isImageSelected = false;
  String imgSelect = '';

  @override
  void initState() {
    WidgetsFlutterBinding.ensureInitialized();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List imgList = ModalRoute.of(context)!.settings.arguments as List;

    print('on build widget ');
    print(imgList[0]);
    return MaterialApp(
      //debugShowCheckedModeBanner: false,
      //darkTheme: ThemeData.dark(),

      home: Column(
        children: [
          const SizedBox(height: 10),
          CarouselSlider(
            options: CarouselOptions(
              autoPlay: true,
              autoPlayInterval: const Duration(seconds: 6),
              autoPlayAnimationDuration: const Duration(milliseconds: 400),
              height: 250,
            ),
            items: imgList.map((item) {
              return GridTile(
                footer: Container(
                    padding: const EdgeInsets.all(15),
                    color: Colors.black54,
                    child: Text(
                      item.id.toString(),
                      style: const TextStyle(color: Colors.white, fontSize: 20),
                      textAlign: TextAlign.center,
                    )),
                child: GestureDetector(
                    onTap: () {
                      setState(() {
                        isImageSelected = true;
                        imgSelect = item.imgUrl;
                      });

                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content:
                          Text('You had choise : ' + item.imgUrl,
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                            ),
                          )
                          )
                      );
                    },
                    child: Image.asset(item.imgUrl, fit: BoxFit.fitWidth),
                  ),

              );
            }).toList(),
          ),
          const SizedBox(height: 30),
          isImageSelected ? Expanded(
            child: Container(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset(imgSelect),
                  ),
                ],
              ),
            ),
          ) : Container(),
          Container(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.black, backgroundColor: Colors.white.withOpacity(0.1),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: const Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Text(
                  'Get Photo Effect',
                  style: kBodyText,
                ),
              ),
              onPressed: () async {
                await _pickImagefromAiApi(imgSelect);
              },
            ),
          ),
          Container(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.black, backgroundColor: Colors.white.withOpacity(0.1),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: const Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Text(
                  'Load Photo From Base64',
                  style: kBodyText,
                ),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute( builder: (context) => PhotoAiResult()),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  _pickImagefromAiApi(imgUrl) async {
    AnimePayload payLoad = AnimePayload(
      prompt: "(((best quality, high quality, highres))), 1boy, handsome, beautiful, young, celebrity, angular face",
      negativePrompt:
      "nsfw, poorly_drawn, blurry, cropped, worst quality, normal quality, low quality, jpeg artifacts, bad_hands, missing fingers, extra digit, bad_anatomy, bad_proportions, bad_feet, watermark, username, artist name, signature, error, text, lower, fewer digits, extra digit, (worst quality, low quality:1.4), monochrome, blurry, missing fingers, extra digit, fewer digits, extra body parts, bad anatomy, censored, collage, logo, border, child, loli, shota, ((deformation))",
      samplerName: "Euler",
      batchSize: 2,
      steps: 20,
      cfgScale: 7,
      width: 512,
      height: 512,
      overrideSettingsRestoreAfterwards: true,
      samplerIndex: "Euler",
      scriptArgs: [],
      sendImages: true,
      saveImages: true,
      alwaysonScripts: AlwaysonScripts(
        controlNet: ControlNetArgs(
          controlMode: "Balanced",
          enabled: true,
          guidanceEnd: 1,
          guidanceStart: 0,
          inputImage: "encoded_base64_image_here",
          inputMode: "simple",
          isUi: true,
          loopback: false,
          lowVram: false,
          model: "control_v11p_sd15_lineart [43d4be0d]",
          module: "lineart_standard (from white bg & black line)",
          outputDir: "",
          pixelPerfect: true,
          processorRes: 512,
          resizeMode: "Crop and Resize",
          thresholdA: -1,
          thresholdB: -1,
          weight: 0.8,
        ),
      ),
    );

    // print('Photo url ');
    // print(imgUrl);
    // print('payload');
    // print(payLoad.toJson());
    ByteData bytes = await rootBundle.load(imgUrl);
    var buffer = bytes.buffer;
    var imgBase64 = base64.encode(Uint8List.view(buffer));
    print('Convert to base64 ');
    print(imgBase64);

    Navigator.push(
      context,
        MaterialPageRoute( builder: (context) => PhotoAiResult(),
          settings: RouteSettings(
            arguments: imgBase64,
          ),
        )
    );

    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text('Name or phone must required.')));
  }

}

