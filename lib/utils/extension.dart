import 'package:clippy/database/type/record.dart';
import 'package:clippy/utils/common.dart';
import 'package:flutter/services.dart';
import 'package:clippy/store/index.dart';

import 'logger.dart';

const _channelName = 'clipboard/image';
var _methodChannel = const MethodChannel(_channelName);

void initExtension() {
  _methodChannel.setMethodCallHandler((call) async {
    if (call.method != 'postContent' || call.arguments == null) {
      return;
    }
    final type = call.arguments['type'] as int;
    final value = call.arguments['value'] as String;
    if (isEmptyString(value)) {
      return;
    }
    if (type == RECORD_TYPE.text.index) {
      return recordStore.addRecord(RECORD_TYPE.text, value);
    }
    if (type == RECORD_TYPE.image.index) {
      return recordStore.addRecord(RECORD_TYPE.image, value);
    }
    if (type == RECORD_TYPE.file.index) {
      return recordStore.addRecord(RECORD_TYPE.file, value);
    }
  });
}

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
