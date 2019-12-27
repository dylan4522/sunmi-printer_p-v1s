import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:sunmi/sunmi.dart';
import 'package:path_provider/path_provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    initSaveToPath();
  }

  String imagePath;

  void initSaveToPath() async {
    final filename = 'lihkg_pig_drink.png';
    var bytes = await rootBundle.load("assets/image/lihkg_pig_drink.png");
    String dir = (await getApplicationDocumentsDirectory()).path;
    writeToFile(bytes, '$dir/$filename');

    setState(() {
      imagePath = '$dir/$filename';
    });
  }

  //write to app path
  Future<void> writeToFile(ByteData data, String path) {
    final buffer = data.buffer;
    return new File(path).writeAsBytes(
        buffer.asUint8List(data.offsetInBytes, data.lengthInBytes));
  }

  static const platform = const MethodChannel('sunmi');

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            title: const Text('Sunmi Printer Plugin example app'),
          ),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                RaisedButton(
                  child: Text('Print Text'),
                  onPressed: () async {
                    print(await Sunmi.printText("Hello World", 30, false, false, 1));
                  },
                ),
                RaisedButton(
                  child: Text('Print New Line'),
                  onPressed: () {
                    Sunmi.printText("", 30, false, false, 1);
                  },
                ),
                RaisedButton(
                  child: Text('Print QR Code'),
                  onPressed: () async{
                    print(await Sunmi.printQRCode("www.google.com", 16, 0, 1));
                  },
                ),
                RaisedButton(
                  child: Text('Print Image'),
                  onPressed: () async{
                    print("Clicked Print Image");
                    print(await Sunmi.printImage(imagePath, 1));
                  },
                ),
              ],
            ),
          )),
    );
  }
}
