import 'package:shared_preferences/shared_preferences.dart';

class CachePreferences {
  static late SharedPreferences _prefs;

  static Future init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static Future<void> setUserCache(String email, String data) async {
    await _prefs.setString(email, data);
  }

  static String? getUserCache(String email) {
    return _prefs.getString(email);
  }

  static Future<void> clearCache() async {
    await _prefs.clear();
  }

  static Future<void> removeUserCache(String email) async {
    await _prefs.remove(email);
  }
}
