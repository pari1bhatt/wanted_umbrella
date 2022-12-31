import 'package:shared_preferences/shared_preferences.dart';

class Prefs {
  static late SharedPreferences _prefs;
  static const String userEmail = 'user_email';

  static Future<SharedPreferences> init() async {
    _prefs = await SharedPreferences.getInstance();
    return _prefs;
  }

  //UserEmail
  static Future<bool> setUserEmail(String value) async =>
      await _prefs.setString(userEmail, value);

  static String? getUserEmail() => _prefs.getString(userEmail);

  //deletes..
  static Future<bool> remove(String key) async => await _prefs.remove(key);

  static Future<bool> clear() async => await _prefs.clear();
}