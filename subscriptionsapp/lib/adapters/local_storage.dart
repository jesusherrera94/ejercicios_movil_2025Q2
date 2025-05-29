import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  late SharedPreferencesAsync _preferencesAsync;

  LocalStorage() {
    _preferencesAsync = SharedPreferencesAsync();
  }


  Future<void> setLoginStatus(bool loginStatus) async {
    await _preferencesAsync.setBool('isAuthenticated', loginStatus);
  }

  Future<bool> getLoginStatus() async => await _preferencesAsync.getBool('isAuthenticated') ?? false;

}