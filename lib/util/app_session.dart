import 'dart:convert';
import 'package:flutter_ideal_ott_api/dto/user_dto.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppSession {
  static AppSession? _instance;
  SharedPreferences? _sharedPreferences;

  AppSession._() {
    _instance = this;
  }

  factory AppSession() => _instance ?? AppSession._();

  Future<void> init() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  // Shared Preference keys
  static const keyUser = 'user';
  static const keyLanguage = 'language';

  Future<void> storeUserDetail(jsonResultObj) async {
    String user = jsonEncode(UserDto.fromJson(jsonResultObj));
    _sharedPreferences?.setString(keyUser, user);
  }

  Future<void> removeUserDetail() async {
    _sharedPreferences?.setString(keyUser, "");
  }

  Future<UserDto?> getUserDetail() async {
    var data = _sharedPreferences?.getString(keyUser);
    if (data == null || data.isEmpty) return null;
    var jsonObjMap = jsonDecode(data.toString());
    var u = UserDto.fromJson(jsonObjMap);
    return u;
  }

  Future<void> storeUserLanguage(String languageMode) async {
    _sharedPreferences?.setString(keyLanguage, languageMode);
    print(">>>>>>>>>>>>>>>>> ${languageMode}");
  }

  Future<void> removeUserLanguage() async {
    _sharedPreferences?.setString(keyLanguage, "");
  }

  Future<String?> getUserLangauge() async {
    var data = await _sharedPreferences?.getString(keyLanguage);
    print(">>>>>>>>>>>>>>>>> ${data}");
    return data;
  }
}
