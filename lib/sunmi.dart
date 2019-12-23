import 'dart:async';
import 'package:flutter/services.dart';

class Sunmi{
  static const MethodChannel _channel = const MethodChannel('sunmi');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }


  static Future<void> printText(String printText, int fontSize, bool isBold, bool isUnderline, int alignment) async {
    try {
      final String result = await _channel.invokeMethod('printText',{'printText':printText,'fontSize':fontSize,'isBold':isBold,'isUnderline':isUnderline,'alignment':alignment});
    } on PlatformException catch (e) {
      print(e);
    }
  }

  static Future<void> printQRCode(String data, int moduleSize, int errorLevel,int alignment) async{
    try{
      final String result = await _channel.invokeMethod('printQRCode',{'data':data,'moduleSize':moduleSize, 'errorLevel':errorLevel,'alignment':alignment});
    }on PlatformException catch (e){
      print(e);
    }
  }

  static Future<void>printImage(String imagePath, int alignment) async{
    try{
      final String result = await _channel.invokeMethod('printImage',{'imagePath':imagePath,'alignment':alignment});
    }on PlatformException catch (e){
      print('PrintImage Error: $e');
    }
  }

}
