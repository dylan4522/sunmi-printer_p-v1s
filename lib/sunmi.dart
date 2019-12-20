import 'dart:async';

import 'package:flutter/services.dart';

class Sunmi {
  static const MethodChannel _channel = const MethodChannel('sunmi');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }
}
