import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:sunmi/sunmi.dart';
import 'package:path_provider/path_provider.dart';

//void main()=>runApp(MyApp());

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String printStatus = '';

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
    setState(() {
      printStatus = Sunmi.printStatus;
    });
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            title: const Text('Sunmi Printer Plugin example app'),
          ),
          body: Center(
            child: Column(
              children: <Widget>[
                RaisedButton(
                  child: Text('Print Text'),
                  onPressed: () {
                    Sunmi.printText("Hello World", 30, false, false, 1);
                    setState(() {
                      printStatus = 'Printing';
                    });
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
                  onPressed: () {
                    Sunmi.printQRCode("www.google.com", 16, 0, 1);
                    setState(() {
                      printStatus = 'Printing';
                    });
                  },
                ),
                RaisedButton(
                  child: Text('Print Image'),
                  onPressed: () {
                    Sunmi.printImage(imagePath, 1);
                    setState(() {
                      printStatus = 'Printing';
                    });
                  },
                ),
              ],
            ),
          )),
    );
  }
}
