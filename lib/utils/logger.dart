import 'dart:io';

import 'package:logger/logger.dart';
// ignore: implementation_imports
import 'package:logger/src/outputs/file_output.dart' show FileOutput;
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:clippy/constants/common.dart';

late Logger logger;

PrettyPrinter pp = PrettyPrinter();

class MyPrinter extends LogPrinter {
  @override
  List<String> log(LogEvent event) {
    String levelStr = event.level.toString().split('.').last;
    String timeStr = pp.getTime();
    String messageStr = pp.stringifyMessage(event.message);
    String? errorStr = event.error?.toString();
    String? stackTraceStr;
    if (event.stackTrace != null) {
      stackTraceStr = pp.formatStackTrace(event.stackTrace, 8)!;
    }

    String data = '[$timeStr] [$levelStr] $messageStr';
    if (stackTraceStr != null) {
      data += ' $stackTraceStr';
    }
    if (errorStr != null) {
      data += errorStr;
    }
    data += '\n';
    return [data];
  }
}

Future<void> initLogger() async {
  Directory appDocDir = await getApplicationDocumentsDirectory();
  final appLogFile = join(appDocDir.path, 'app.log');

  // app log
  File aFile = File(appLogFile);
  if (!aFile.existsSync()) {
    aFile.createSync();
  }
  logger = Logger(
      printer: MyPrinter(), output: isProd ? FileOutput(file: aFile) : null);

  logger.i('logger is ready!');
}
