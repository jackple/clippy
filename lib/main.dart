import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:window_manager/window_manager.dart';
import 'package:hotkey_manager/hotkey_manager.dart';

import 'widget/theme.dart';
import 'widget/home/home.dart';
import 'utils/common.dart';
import 'utils/extension.dart';
import 'utils/hotkey.dart';
import 'utils/logger.dart';
import 'database/database.dart';
import 'database/type/record.dart';
import 'store/index.dart';

Future<void> getLatestRecord() async {
  var filePath = await getClipboardContent(false);
  if (filePath != null) {
    if (filePath.isNotEmpty) {
      recordStore.addRecord(RECORD_TYPE.file, filePath);
    }
    return;
  }
  var clipboardData = await Clipboard.getData(Clipboard.kTextPlain);
  if (clipboardData?.text != null) {
    if (clipboardData!.text!.isNotEmpty) {
      recordStore.addRecord(RECORD_TYPE.text, clipboardData.text!);
    }
    return;
  }
  final imageBase64Str = await getClipboardContent(true);
  if (!isEmptyString(imageBase64Str)) {
    recordStore.addRecord(RECORD_TYPE.image, imageBase64Str!);
  }
}

/// 初始化剪切板相关
Future<void> initRecords() async {
  // 获取剪切板的数据库记录
  await recordStore.getRecords();

  /// 定时获取剪切板内容
  Timer.periodic(const Duration(milliseconds: 500), (t) {
    getLatestRecord();
  });
}

Future<void> init() async {
  await initLogger();
  await createDBInstance();
  initRecords();
  // For hot reload, `unregisterAll()` needs to be called.
  hotKeyManager.unregisterAll();
  // Must add this line.
  await windowManager.ensureInitialized();

  windowManager.waitUntilReadyToShow().then((_) async {
    // Set to frameless window
    await windowManager.setAsFrameless();
    await windowManager.setSkipTaskbar(true);
    await windowManager.setMovable(false);
    // 绑定显示窗口的快捷键
    initHotKey();
  });
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  init();
  // 全局错误
  FlutterError.onError = (details) async {
    logger.e('catch by FlutterError.onError: ', details);
    if (details.stack != null) {
      Zone.current.handleUncaughtError(details.exception, details.stack!);
    }
  };

  runZonedGuarded<void>(() {
    runApp(const MyApp());
  }, (Object error, StackTrace stack) {
    logger.e('catch by Guarded: ', error, stack);
  });
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'clippy',
      // 不显示右上角的debug字样
      debugShowCheckedModeBanner: false,
      theme: appTheme,
      home: const Home(),
    );
  }
}