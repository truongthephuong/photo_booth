import 'package:flutter/material.dart';
import 'package:photobooth_section1/screens/screen5.dart';

class Screen4 extends StatelessWidget {
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Stack(
          fit: StackFit.expand,
          children: [
            // Background Image
            Image(
              image: AssetImage('assets/template/theme.png'),
              fit: BoxFit.cover,
            ),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RichText(
                    text: TextSpan(
                      text: '합성할 사진',
                      style: TextStyle(
                          fontSize: 60,
                          fontWeight: FontWeight.bold,
                          color: Colors.orangeAccent,
                          fontFamily: 'GulyFont'),
                      children: <TextSpan>[
                        TextSpan(
                          text: ' 을 선택해 주세요!',
                          style: TextStyle(
                              fontSize: 60,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                              fontFamily: 'GulyFont'),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          Container(
                            margin: EdgeInsets.only(left: 350),
                            width: 355,
                            height: 252,
                            decoration: BoxDecoration(
                              shape: BoxShape.rectangle,
                              //border: Border.all(color: Colors.white, width: 4),
                              image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: AssetImage(
                                      'assets/template/screen4.png')),
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Container(
                            margin: EdgeInsets.only(left: 0),
                            width: 355,
                            height: 252,
                            decoration: BoxDecoration(
                              shape: BoxShape.rectangle,
                              //border: Border.all(color: Colors.white, width: 4),
                              image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: AssetImage(
                                      'assets/template/screen4.png')),
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Container(
                            width: 355,
                          )
                        ],
                      )
                    ],
                  ),
                  // Rounded Image
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          Container(
                            margin: EdgeInsets.only(left: 180),
                            width: 355,
                            height: 252,
                            decoration: BoxDecoration(
                              shape: BoxShape.rectangle,
                              //border: Border.all(color: Colors.white, width: 4),
                              image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: AssetImage(
                                      'assets/template/screen4.png')),
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Container(
                            margin: EdgeInsets.only(left: 0),
                            width: 355,
                            height: 252,
                            decoration: BoxDecoration(
                              shape: BoxShape.rectangle,
                              //border: Border.all(color: Colors.white, width: 4),
                              image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: AssetImage(
                                      'assets/template/screen4.png')),
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Container(
                            margin: EdgeInsets.only(left: 20, top: 120),
                            alignment: Alignment.bottomCenter,
                            child: ElevatedButton(
                              onPressed: () {
                                // Add
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Screen5()));
                              },
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 20),
                                child: Text('시작',
                                    style: TextStyle(
                                        fontSize: 50,
                                        color: Colors.black,
                                        fontFamily: 'GulyFont')),
                              ),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.lightGreen,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),

                  // SizedBox(
                  //   height: 20,
                  // ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
