import 'package:dia_app/src/domain/entities/user.dart';
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

  static Future<UserRole> getRole() async {
    final prefs = await SharedPreferences.getInstance();
    switch (prefs.getInt(_ROLE)) {
      case 0: return UserRole.Patient;
      case 1: return UserRole.Doctor;
    }
    return null;
  }

  static Future<void> setRole(UserRole role) async {
    final prefs = await SharedPreferences.getInstance();
    switch (role) {
      case UserRole.Patient:
        await prefs.setInt(_ROLE, 0);
        break;
      case UserRole.Doctor:
        await prefs.setInt(_ROLE, 1);
        break;
    }
  }

  static Future<bool> removeRole() async {
    final prefs = await SharedPreferences.getInstance();
    return await prefs.remove(_ROLE);
  }
}
