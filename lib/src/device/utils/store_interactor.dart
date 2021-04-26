import 'package:shared_preferences/shared_preferences.dart';

const _TOKEN = 'token';
const _ROLE = 'role';

class StoreInteractor {
  static Future<String> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_TOKEN);
  }

  static Future<void> setToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_TOKEN, token);
  }

  static Future<bool> removeToken() async {
    final prefs = await SharedPreferences.getInstance();
    return await prefs.remove(_TOKEN);
  }

  static Future<int> getRole() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(_ROLE);
  }

  static Future<void> setRole(int role) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_ROLE, role);
  }

  static Future<bool> removeRole() async {
    final prefs = await SharedPreferences.getInstance();
    return await prefs.remove(_ROLE);
  }
}
