  import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper {

  static late SharedPreferences _preferences;
  static bool _initialized = false;

  static Future<void> init() async {
    if (!_initialized) {
      _preferences = await SharedPreferences.getInstance();
      _initialized = true;
    }
  }

  static Future<bool> setString(String key, String value) async {
    _ensureInitialized();
    return _preferences.setString(key, value);
  }

  static Future<String?> getString(String key) async {
    _ensureInitialized();
    return _preferences.getString(key);
  }

  static Future<bool> setBoolean(String key, bool value) async {
    _ensureInitialized();
    return _preferences.setBool(key, value);
  }

  static Future<bool?> getBoolean(String key) async {
    _ensureInitialized();
    return _preferences.getBool(key);
  }


  static Future<bool> removeKey(String key) async {
    _ensureInitialized();
    return _preferences.remove(key);
  }

  static void _ensureInitialized() {
    if (!_initialized) {
      throw Exception(
          'CashHelper not initialized! Call await CashHelper.init() in main().'
      );
    }
  }

  static Future<bool> clearAll() => _preferences.clear();

// Save any JSON-encodable object
  static Future<void> setJson(String key, dynamic value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(key, jsonEncode(value));
  }

  // Get a decoded JSON map/list
  static Future<dynamic> getJson(String key) async {
    final prefs = await SharedPreferences.getInstance();
    final str = prefs.getString(key);
    if (str == null) return null;
    return jsonDecode(str);
  }

  static Future<void> remove(String key) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove(key);
  }
}