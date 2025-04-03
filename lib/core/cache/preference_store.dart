// ignore_for_file: constant_identifier_names
import 'package:shared_preferences/shared_preferences.dart';

class PreferenceStore {
  static const String _IS_LOGGED_IN = 'is_logged_in';
  static const String _IS_APP_THEME_LIGHT = 'is_app_theme_light';
  static const String _CURRENT_LOCAL = 'current_local';
  static const String _CURRENT_ROLE = 'current_role';
  static const String _IS_USER_LOGGED_IN = 'is_user_logged_in';

  late SharedPreferences _sharedPreferences;

  PreferenceStore();

  Future<bool> init() async {
    _sharedPreferences = await SharedPreferences.getInstance();
    return true;
  }

  Future<bool> reset() async {
    return true;
  }

  bool isAppThemeLight() {
    return _sharedPreferences.getBool(_IS_APP_THEME_LIGHT) ?? true;
  }

  String getCurrentLocal() {
    return _sharedPreferences.getString(_CURRENT_LOCAL) ?? 'en';
  }
  Future<bool> setCurrentLocal(String local) async {
    return _sharedPreferences.setString(_CURRENT_LOCAL, local);
  }

  String getCurrentRole() {
    return _sharedPreferences.getString(_CURRENT_ROLE) ?? 'en';
  }

  Future<bool> isLoggedIn(bool isLoggedIn) async {
    return _sharedPreferences.setBool(_IS_LOGGED_IN, isLoggedIn);
  }

  bool getIsLoggedIn() {
    return _sharedPreferences.getBool(_IS_LOGGED_IN) ?? false;
  }

  Future<bool> setCurrentRole(String role) async {
    return _sharedPreferences.setString(_CURRENT_ROLE, role);
  }

  Future<bool> setAppThemeLight(bool isLight) async {
    return _sharedPreferences.setBool(_IS_APP_THEME_LIGHT, isLight);
  }

}
