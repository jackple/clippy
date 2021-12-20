import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

/// 判断字符串是否为空
bool isEmptyString(String? data) => data == null || data.isEmpty;

/// 判断数组是否为空
bool isEmptyList(List? data) => data == null || data.isEmpty;

/// 时间格式化
String relativeDateFormat(int timeStamp) {
  final now = DateTime.now();
  final time = DateTime.fromMillisecondsSinceEpoch(timeStamp);
  final difference = now.difference(time);
  final days = difference.inDays;
  final hours = difference.inHours;
  final minutes = difference.inMinutes;
  late String result;
  if (days > 3) {
    bool isNowYear = now.year == time.year;
    var pattern = isNowYear ? 'MM-dd' : 'yyyy-MM-dd';
    result = DateFormat(pattern).format(time);
  } else if (days > 0) {
    result = '$days天前';
  } else if (hours > 0) {
    result = '$hours小时前';
  } else if (minutes > 0) {
    result = '$minutes分钟前';
  } else {
    result = '刚刚';
  }
  return result;
}

/// 匹配字符串是不是颜色
bool isColor(String text) {
  final reg = RegExp(r"^#?[0-9a-fA-F]{6}$");
  return reg.hasMatch(text);
}

String _hexColorRorrect(String color) {
  // 如果传入的十六进制颜色值不符合要求，返回默认值
  if (color.length == 7 &&
      int.tryParse(color.substring(1, 7), radix: 16) != null) {
    color = color.substring(1, 7);
  }
  if (color.length == 6 && int.tryParse(color, radix: 16) != null) {
    return color;
  }
  return '00c8c8';
}

String _padZero(String str) {
  str = '0' + str;
  return str.substring(str.length - 2);
}

/// css颜色转换为flutter颜色对象
Color hexToColor(String color) {
  return Color(int.parse(_hexColorRorrect(color), radix: 16) + 0xFF000000);
}

/// 取hex color的相反颜色, 带透明度
Color reverseColor(String color) {
  color = _hexColorRorrect(color);
  final r =
      (255 - int.parse(color.substring(0, 2), radix: 16)).toRadixString(16);
  final g =
      (255 - int.parse(color.substring(2, 4), radix: 16)).toRadixString(16);
  final b =
      (255 - int.parse(color.substring(4, 6), radix: 16)).toRadixString(16);
  final newColorStr = '${_padZero(r)}${_padZero(g)}${_padZero(b)}';
  return hexToColor(newColorStr).withOpacity(0.6);
}

/// 去除本机文件地址前面的file协议
String removeFileProtocol(String path) {
  if (!isEmptyString(path) && path.startsWith('file://')) {
    path = path.substring(7);
  }
  return path;
}

/// 获取文件的大小
Future<int?> getFileSize(String path) async {
  path = removeFileProtocol(path);
  final file = File(Uri.decodeComponent(path));
  final len = await file.length();
  return len;
}

const _suffixes = ["B", "KB", "MB", "GB", "TB", "PB", "EB", "ZB", "YB"];

/// 获取文件的大小的格式化
String getFileSizeFormat(int bytes, [int decimals = 3]) {
  if (bytes <= 0) return "0 B";
  var i = (log(bytes) / log(1024)).floor();
  return ((bytes / pow(1024, i)).toStringAsFixed(decimals)) +
      ' ' +
      _suffixes[i];
}
