import 'dart:async';
import 'dart:typed_data';
import 'package:flutter/services.dart';

class FlutterBarcodeSdk {
  static const int IF_UNKNOWN = -1;
  static const int IF_YUV420 = 0;
  static const int IF_BRGA8888 = 1;

  static const MethodChannel _channel =
      const MethodChannel('flutter_barcode_sdk');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }

  Future<List<Map<dynamic, dynamic>>> decodeFile(String filename) async {
    return List<Map<dynamic, dynamic>>.from(
        await _channel.invokeMethod('decodeFile', {'filename': filename}));
  }

  Future<List<Map<dynamic, dynamic>>> decodeFileBytes(Uint8List bytes) async {
    assert(bytes.isNotEmpty);
    return List<Map<dynamic, dynamic>>.from(
        await _channel.invokeMethod('decodeFileBytes', {'bytes': bytes}));
  }

  Future<List<Map<dynamic, dynamic>>> decodeImageBuffer(
      Uint8List bytes, int width, int height, int stride, int format) async {
    return List<Map<dynamic, dynamic>>.from(
        await _channel.invokeMethod('decodeImageBuffer', {
      'bytes': bytes,
      'width': width,
      'height': height,
      'stride': stride,
      'format': format
    }));
  }
}
