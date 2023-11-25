import 'dart:convert';

import 'package:flutter/material.dart';

class PhotoAiResult extends StatefulWidget {

  @override
  _PhotoAiResultState createState() => _PhotoAiResultState();
}

class _PhotoAiResultState extends State<PhotoAiResult> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final imgStr = ModalRoute.of(context)!.settings.arguments;
    print('at Ai result');
    print(imgStr);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Photo Result From AI"),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 10),
            Expanded(
              child: Container(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.memory(base64Decode(imgStr.toString())),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // setState(() {
          //   index = (index + 1) % customizations.length;
          // });
        },
        foregroundColor: Colors.deepOrange,
        backgroundColor: Colors.white70,
        child: const Icon(Icons.account_balance_wallet_outlined),
      ),
    );
  }

}