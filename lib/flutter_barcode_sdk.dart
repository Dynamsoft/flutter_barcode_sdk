import 'dart:async';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_sdk/dynamsoft_barcode.dart';

/// Image pixel format.
enum ImagePixelFormat {
  /// 0:Black, 1:White
  IPF_BINARY,

  /// 0:White, 1:Black
  IPF_BINARYINVERTED,

  /// 8bit gray
  IPF_GRAYSCALED,

  /// NV21
  IPF_NV21,

  /// 16bit with RGB channel order stored in memory from high to low address
  IPF_RGB_565,

  /// 16bit with RGB channel order stored in memory from high to low address
  IPF_RGB_555,

  /// 24bit with RGB channel order stored in memory from high to low address
  IPF_RGB_888,

  /// 32bit with ARGB channel order stored in memory from high to low address
  IPF_ARGB_8888,

  /// 48bit with RGB channel order stored in memory from high to low address
  IPF_RGB_161616,

  /// 64bit with ARGB channel order stored in memory from high to low address
  IPF_ARGB_16161616,

  /// 32bit with ABGR channel order stored in memory from high to low address
  IPF_ABGR_8888,

  /// 64bit with ABGR channel order stored in memory from high to low address
  IPF_ABGR_16161616,

  /// 24bit with BGR channel order stored in memory from high to low address
  IPF_BGR_888
}

class FlutterBarcodeSdk {
  static const MethodChannel _channel =
      const MethodChannel('flutter_barcode_sdk');

  /// Set Dynamsoft Barcode Reader License Key
  /// Apply for a 30-day FREE trial license: https://www.dynamsoft.com/customer/license/trialLicense/?product=dcv&package=cross-platform
  Future<int> setLicense(String license) async {
    int ret = await _channel.invokeMethod('setLicense', {'license': license});
    return ret;
  }

  /// Decodes barcodes from an image file.
  Future<List<BarcodeResult>> decodeFile(String filename) async {
    List<Map<dynamic, dynamic>> ret = List<Map<dynamic, dynamic>>.from(
        await _channel.invokeMethod('decodeFile', {'filename': filename}));
    return convertResults(ret);
  }

  /// Decodes barcodes from an image buffer.
  ///
  /// E.g. [CameraImage]
  Future<List<BarcodeResult>> decodeImageBuffer(
      Uint8List bytes, int width, int height, int stride, int format) async {
    List<Map<dynamic, dynamic>> ret = List<Map<dynamic, dynamic>>.from(
        await _channel.invokeMethod('decodeImageBuffer', {
      'bytes': bytes,
      'width': width,
      'height': height,
      'stride': stride,
      'format': format
    }));
    return convertResults(ret);
  }

  /// Set barcode formats.
  /// https://www.dynamsoft.com/barcode-reader/parameters/enum/format-enums.html?ver=latest#barcodeformat
  Future<int> setBarcodeFormats(int formats) async {
    return await _channel
        .invokeMethod('setBarcodeFormats', {'formats': formats});
  }

  /// Get all current parameters configured for barcode detection algorithm.
  /// https://www.dynamsoft.com/barcode-reader/parameters/reference/image-parameter/?ver=latest
  Future<String> getParameters() async {
    return await _channel.invokeMethod('getParameters');
  }

  /// Set parameters to adjust barcode detection algorithm.
  Future<int> setParameters(String params) async {
    return await _channel.invokeMethod('setParameters', {'params': params});
  }

  /// Initialize barcode reader object.
  Future<int> init() async {
    int ret = await _channel.invokeMethod('init');
    return ret;
  }
}
