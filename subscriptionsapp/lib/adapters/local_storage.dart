import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  late SharedPreferencesAsync _preferencesAsync;

  LocalStorage() {
    _preferencesAsync = SharedPreferencesAsync();
  }


  Future<void> setLoginStatus(bool loginStatus) async {
    await _preferencesAsync.setBool('isAuthenticated', loginStatus);
  }

  Future<void> setUserData(String key, String value) async{
    await _preferencesAsync.setString(key, value);
  }

  Future<bool> getLoginStatus() async => await _preferencesAsync.getBool('isAuthenticated') ?? false;

  Future<String> getUserData(String key) async => await _preferencesAsync.getString(key) ?? '';
  Future<void> clearUserData() async {
    await _preferencesAsync.clear();
  }

}
