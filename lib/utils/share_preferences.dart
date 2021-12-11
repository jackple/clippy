import 'package:shared_preferences/shared_preferences.dart'
    as ori_shared_preferences;

ori_shared_preferences.SharedPreferences? _instance;

class SharedPreferences {
  static Future<ori_shared_preferences.SharedPreferences> get instance async {
    _instance ??= await ori_shared_preferences.SharedPreferences.getInstance();
    return _instance as ori_shared_preferences.SharedPreferences;
  }
}
