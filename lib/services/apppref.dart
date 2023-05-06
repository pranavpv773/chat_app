import 'package:shared_preferences/shared_preferences.dart';

class AppPref {
  static const _userEmail = "user_email";
  static const _userToken = "user_token";
  static const _useruid = "user_uid";
  static const _getteruid = "_getter_uid";

  static late final SharedPreferences _preference;
//User Token
  static String get userToken => _preference.getString(_userToken) ?? "";

  static set userToken(String value) =>
      _preference.setString(_userToken, value);

  static String get useruid => _preference.getString(_useruid) ?? "";

  static set useruid(String value) => _preference.setString(_useruid, value);

  static String get recieverUsid => _preference.getString(_getteruid) ?? "";

  static set recieverUsid(String value) =>
      _preference.setString(_getteruid, value);

  void reloadPreference() async {
    await _preference.reload();
  }

  static Future<void> init() async {
    _preference = await SharedPreferences.getInstance();
  }

  static String get usermail => _preference.getString(_userEmail) ?? '';
  static set usermail(String value) => _preference.setString(_userEmail, value);

  Future<void> clear() async {
    await _preference.clear();
  }
}
