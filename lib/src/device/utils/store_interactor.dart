import 'package:dia_app/src/domain/entities/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

const _TOKEN = 'token';
const _USER_TYPE = 'type';

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

  Future<UserType> getUserType() async {
    final prefs = await SharedPreferences.getInstance();
    switch (prefs.getInt(_USER_TYPE)) {
      case 0: return UserType.Patient;
      case 1: return UserType.Doctor;
    }
    return null;
  }

  Future<void> setUserType(UserType userType) async {
    final prefs = await SharedPreferences.getInstance();
    switch (userType) {
      case UserType.Patient:
        await prefs.setInt(_USER_TYPE, 0);
        break;
      case UserType.Doctor:
        await prefs.setInt(_USER_TYPE, 1);
        break;
    }
  }

  Future<bool> removeType() async {
    final prefs = await SharedPreferences.getInstance();
    return await prefs.remove(_USER_TYPE);
  }
}
