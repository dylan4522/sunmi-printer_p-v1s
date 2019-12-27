import 'dart:async';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

class Sunmi {
  static const MethodChannel _channel = const MethodChannel('sunmi');

//  static Future<void> printText(String printText, int fontSize, bool isBold, bool isUnderline, int alignment) async {
//    try {
//      final String result = await _channel.invokeMethod('printText', {'printText': printText, 'fontSize': fontSize, 'isBold': isBold, 'isUnderline': isUnderline, 'alignment': alignment});
//    } on PlatformException catch (e) {
//      print('PrintText Error: $e');
//    }
//  }
  static Future printText(String printText, int fontSize, bool isBold, bool isUnderline, int alignment) => _channel.invokeMethod('printText',{'printText': printText, 'fontSize': fontSize, 'isBold': isBold, 'isUnderline': isUnderline, 'alignment': alignment});

//  static Future<void> printQRCode(String data, int moduleSize, int errorLevel, int alignment) async {
//    try {
//      final String result = await _channel.invokeMethod('printQRCode', {'data': data, 'moduleSize': moduleSize, 'errorLevel': errorLevel, 'alignment': alignment});
//      print('PrintQrCode Result: $result');
//    } on PlatformException catch (e) {
//      print('PrintQrCode Error: $e');
//    }
//  }
  static Future printQRCode(String data, int moduleSize, int errorLevel, int alignment) => _channel.invokeMethod('printQRCode',{'data': data, 'moduleSize': moduleSize, 'errorLevel': errorLevel, 'alignment': alignment});

//  static Future<void> printImage(String imagePath, int alignment) async {
//    try {
//      final String result = await _channel.invokeMethod('printImage', {'imagePath': imagePath, 'alignment': alignment});
//    } on PlatformException catch (e) {
//      print('PrintImage Error: $e');
//    }
//  }
  static Future printImage(String imagePath, int alignment) => _channel.invokeMethod('printImage', {'imagePath': imagePath, 'alignment': alignment});

}
