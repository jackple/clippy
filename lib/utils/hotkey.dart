import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:window_size/window_size.dart';
import 'package:hotkey_manager/hotkey_manager.dart';
import 'package:window_manager/window_manager.dart';
import 'package:clippy/utils/share_preferences.dart';
import 'package:clippy/constants/common.dart';

// Set hotkey scope (default is HotKeyScope.system)
const scope = HotKeyScope.system;

// 记录上一次绑定的快捷键, 用于解绑
HotKey? lastHotKey;

HotKey _generateHotKey(KeyCode keyCode, List<KeyModifier> modifiers) {
  return HotKey(
    keyCode,
    modifiers: modifiers,
    scope: scope,
  );
}

Future<void> hideWindow() async {
  await windowManager.hide();
}

Future<void> showWindow() async {
  Screen? screen = await getCurrentScreen();
  if (screen != null) {
    await windowManager.setSize(Size(screen.frame.width, 360));
    await windowManager.setPosition(Offset(0.0, screen.frame.height));
  }
  await windowManager.show();
}

Future<void> toggleWindowVisible() async {
  final visible = await windowManager.isVisible();
  return visible ? hideWindow() : showWindow();
}

/// 绑定打开主窗口的快捷键
Future<void> bindHotKey(KeyCode keyCode, List<KeyModifier> modifiers,
    [bool fromInit = false]) async {
  final hotKey = _generateHotKey(keyCode, modifiers);
  if (!fromInit) {
    final spIns = await SharedPreferences.instance;
    spIns.setString(SharePerferencesKey.toggleWindowVisibleKey,
        json.encode(hotKey.toJson()));
  }
  // 解绑上一次的快捷键
  if (lastHotKey != null) {
    await hotKeyManager.unregister(lastHotKey!);
  }
  lastHotKey = hotKey;
  await hotKeyManager.register(
    hotKey,
    keyDownHandler: (hk) {
      toggleWindowVisible();
    },
  );
}

class _Listener with WindowListener {
  @override
  void onWindowBlur() {
    // 失焦时隐藏窗口
    hideWindow();
  }
}

/// 初始化时绑定快捷键
Future<void> initHotKey() async {
  // 绑定esc
  hotKeyManager.register(
    HotKey(KeyCode.escape, scope: HotKeyScope.inapp),
    keyDownHandler: (hk) {
      toggleWindowVisible();
    },
  );

  // 窗口事件监听
  windowManager.addListener(_Listener());

  // 尝试从本地储存绑定快捷键
  final spIns = await SharedPreferences.instance;
  final localHotKeyStr =
      spIns.getString(SharePerferencesKey.toggleWindowVisibleKey);
  if (localHotKeyStr != null) {
    final hotKey = HotKey.fromJson(json.decode(localHotKeyStr));
    return bindHotKey(hotKey.keyCode, hotKey.modifiers!, true);
  }
  bindHotKey(KeyCode.keyV, [KeyModifier.meta, KeyModifier.shift], true);
}
