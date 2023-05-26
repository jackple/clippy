import 'package:flutter/material.dart';

/// 基础颜色
const Color colorPrimary = Color(0xff00c8c8);

/// 基础颜色
const Color colorPrimaryHighligth = Color(0xff22d6d0);

/// 背景灰1级
const Color colorGrayBg1 = Color(0xffd8d8d8);

/// 背景灰2级
const Color colorGrayBg2 = Color(0xffe8eaea);

/// 背景灰3级
const Color colorGrayBg3 = Color(0xfff1f2f2);

/// 背景灰4级
const Color colorGrayBg4 = Color(0xfff5f6f7);

/// 背景灰5级
const Color colorGrayBg5 = Color(0xffededed);

/// 背景灰6级
const Color colorGrayBg6 = Color(0xfff4f4f4);

/// 黑色1级
const Color colorBlack1 = Color(0xff0A1312);

/// 黑色2级
const Color colorBlack2 = Color(0xff555555);

/// 灰色3级
const Color colorGray = Color(0xff888888);

/// 分割线颜色(灰)
const Color colorDivider = Color.fromRGBO(10, 19, 18, 0.075);

/// 分割线颜色(灰), 用于editor
const Color colorEditorDivider = Color.fromRGBO(10, 19, 18, 0.2);

/// 创建主题颜色
MaterialColor createMaterialColor(Color color) {
  List strengths = <double>[.05];
  Map<int, Color> swatch = {};
  final int r = color.red, g = color.green, b = color.blue;

  for (int i = 1; i < 10; i++) {
    strengths.add(0.1 * i);
  }
  for (var strength in strengths) {
    final double ds = 0.5 - strength;
    swatch[(strength * 1000).round()] = Color.fromRGBO(
      r + ((ds < 0 ? r : (255 - r)) * ds).round(),
      g + ((ds < 0 ? g : (255 - g)) * ds).round(),
      b + ((ds < 0 ? b : (255 - b)) * ds).round(),
      1,
    );
  }
  return MaterialColor(color.value, swatch);
}

/// 文本主题
const TextTheme textTheme = TextTheme(
  // body
  bodyLarge:
      TextStyle(color: colorBlack2, fontSize: 14, fontWeight: FontWeight.w400),
  bodyMedium:
      TextStyle(color: colorBlack2, fontSize: 14, fontWeight: FontWeight.w300),
  // subtitle
  titleMedium: TextStyle(color: colorBlack1, fontSize: 14),
  titleSmall:
      TextStyle(color: colorGray, fontSize: 12, fontWeight: FontWeight.w300),
  // headline
  displayLarge: TextStyle(color: colorBlack1, fontSize: 18),
  displayMedium: TextStyle(color: colorBlack1, fontSize: 16),
  displaySmall: TextStyle(color: colorBlack1, fontSize: 14),
  headlineMedium:
      TextStyle(color: colorBlack1, fontSize: 13, fontWeight: FontWeight.w300),
  headlineSmall:
      TextStyle(color: colorGray, fontSize: 12, fontWeight: FontWeight.w300),
  // button
  labelLarge: TextStyle(color: Colors.white, fontSize: 14),
);

const UnderlineInputBorder underlineInputBorder =
    UnderlineInputBorder(borderSide: BorderSide(color: colorDivider, width: 1));

const OutlineInputBorder outlineInputBorder = OutlineInputBorder(
    borderSide: BorderSide(color: colorDivider, width: 0.5),
    borderRadius: BorderRadius.all(Radius.circular(5)));
const OutlineInputBorder focusOutlineInputBorder = OutlineInputBorder(
    borderSide: BorderSide(color: colorDivider, width: 0.5),
    borderRadius: BorderRadius.all(Radius.circular(5)));

/// app主题
final ThemeData appTheme = ThemeData(
  textTheme: textTheme,

  // App主要部分的背景色
  primaryColor: colorPrimary,
  // 用于墨水喷溅动画或指示菜单被选中时的高亮颜色
  highlightColor: colorPrimaryHighligth,
  // 分隔符(Dividers)和弹窗分隔符(PopupMenuDividers)的颜色，也用于ListTiles和DataTables的行之间。要创建使用这种颜色的合适的边界，请考虑Divider.createBorderSide。
  dividerColor: colorDivider,
  // 小部件处于非活动(但启用)状态时使用的颜色。例如，未选中的复选框。通常与accentColor形成对比。
  unselectedWidgetColor: colorGray,

  // 输入框样式
  inputDecorationTheme: const InputDecorationTheme(
      hintStyle: TextStyle(
          fontSize: 14, color: colorGray, fontWeight: FontWeight.w300),
      border: outlineInputBorder,
      enabledBorder: outlineInputBorder,
      // 聚焦时不需要高亮border
      focusedBorder: focusOutlineInputBorder),

  primarySwatch: createMaterialColor(colorPrimary),
  // This makes the visual density adapt to the platform that you run
  // the app on. For desktop platforms, the controls will be smaller and
  // closer together (more dense) than on mobile platforms.
  visualDensity: VisualDensity.adaptivePlatformDensity,
);
