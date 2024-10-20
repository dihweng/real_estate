import 'package:shared_preferences/shared_preferences.dart';

enum AuthStatus { LOGGED_IN, LOGGED_OUT, IS_LOADING }

enum ErrorStatus { ERROR, SUCCESS }

enum UserType { VERIFIED, UNVERIFIED }

const APP_CONFIG = 'app_config';
const authTokenKey = 'auth_token';
const AUTH_USER_TYPE = 'user_type';
const USER_THEME = "user_theme";
const SYSTEM_THEME = "system_theme";

class LocalStoreHelper {


  static saveInfo(token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(authTokenKey, token);
  }

  static Future<String> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(authTokenKey) ?? '';
  }

  static Future<bool> removeUserToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.remove(authTokenKey);
  }

  static Future<bool> removeToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.remove(authTokenKey);
  }

  static Future<String> getUserToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(authTokenKey) ?? '';
  }

  ///Persist user's system theme, and set the default to true
  static Future<bool> setSystemThemeSettings(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setBool(SYSTEM_THEME, value);
  }

  static Future<bool> getSystemThemeSettings() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(SYSTEM_THEME) ?? true;
  }

  static Future<bool> setTheme(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setBool(USER_THEME, value);
  }

  static getTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(USER_THEME);
  }

}
