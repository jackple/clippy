//
//  Generated file. Do not edit.
//

import FlutterMacOS
import Foundation

import hotkey_manager
import path_provider_foundation
import screen_retriever
import shared_preferences_foundation
import window_manager
import window_size

func RegisterGeneratedPlugins(registry: FlutterPluginRegistry) {
  HotkeyManagerPlugin.register(with: registry.registrar(forPlugin: "HotkeyManagerPlugin"))
  PathProviderPlugin.register(with: registry.registrar(forPlugin: "PathProviderPlugin"))
  ScreenRetrieverPlugin.register(with: registry.registrar(forPlugin: "ScreenRetrieverPlugin"))
  SharedPreferencesPlugin.register(with: registry.registrar(forPlugin: "SharedPreferencesPlugin"))
  WindowManagerPlugin.register(with: registry.registrar(forPlugin: "WindowManagerPlugin"))
  WindowSizePlugin.register(with: registry.registrar(forPlugin: "WindowSizePlugin"))
}
