import 'package:shared_preferences/shared_preferences.dart';

class DataSharedPreferences {
  static const String CITY_ID = "CITY_ID";
  static const String LANGUAGE = "LANGUAGE";

  static Future<int> getReaderInt(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt(key) ?? 0;
  }

  static void SaveDataInt(String key, int newValue) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt(key, newValue);
  }

  static Future<String> getReaderStr(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(key) ?? "";
  }

  static void SaveDataStr(String key, String newValue) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(key, newValue);
  }
}
