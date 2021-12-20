import 'package:flutter/services.dart';

import 'logger.dart';

const _channelName = 'clipboard/image';
var _methodChannel = const MethodChannel(_channelName);

Future<String?> getClipboardContent([bool image = false]) async {
  try {
    final result = await _methodChannel
        .invokeMethod(image ? 'getClipboardImage' : 'getClipboardFile');
    return result;
  } on PlatformException catch (e) {
    logger.e("error in getting clipboard content");
    // ignore: avoid_print
    print(e);
  }
}

Future<void> setClipboardContent(String data, [bool image = false]) async {
  try {
    final result = await _methodChannel.invokeMethod(
        image ? 'setClipboardImage' : 'setClipboardFile', data);
    return result;
  } on PlatformException catch (e) {
    logger.e("error in setting clipboard content");
    // ignore: avoid_print
    print(e);
  }
}
