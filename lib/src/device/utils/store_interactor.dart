import 'package:dia_app/src/domain/entities/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

const _TOKEN = 'token';
const _ROLE = 'role';

class StoreInteractor {
  Future<String> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_TOKEN);
  }

  Future<void> setToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_TOKEN, token);
  }

  Future<bool> removeToken() async {
    final prefs = await SharedPreferences.getInstance();
    return await prefs.remove(_TOKEN);
  }

  Future<UserRole> getRole() async {
    final prefs = await SharedPreferences.getInstance();
    switch (prefs.getInt(_ROLE)) {
      case 0: return UserRole.Patient;
      case 1: return UserRole.Doctor;
    }
    return null;
  }

  Future<void> setRole(UserRole role) async {
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

  Future<bool> removeRole() async {
    final prefs = await SharedPreferences.getInstance();
    return await prefs.remove(_ROLE);
  }
}
