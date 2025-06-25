import 'dart:convert';

import 'package:app_games/modules/feature_login/domain/entities/authentication_user.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class AppSharedPreferences {
  saveUserSession({required AuthenticationUser user});

  Future<AuthenticationUser?>getUserSession();

  saveToken({required String accessToken});

  Future<String> getAccessToken();
  Future<bool> isLogin();
  removeUserSession();
}

class AppSharedPreferencesImpl extends AppSharedPreferences{
  final String accessTokenKey = "pref_access_token";
  final String userKey = "authenticated_user_key";

  @override
  Future<String> getAccessToken() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('pref_access_token') ?? '';
    return token;
  }
  @override
  Future<bool> isLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('pref_access_token') ?? "";
    if (token.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }
  @override
  saveUserSession({
    required AuthenticationUser user,
  }) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(
      userKey,
      jsonEncode(user.toJson()),
    );
  }
   @override
Future<AuthenticationUser?> getUserSession() async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  final userJson = preferences.getString(userKey);
  if (userJson == null) return null;
  final Map<String, dynamic> userMap = jsonDecode(userJson);
  return AuthenticationUser.fromJson(userMap);
}
  @override
  saveToken({required String accessToken}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(
      'pref_access_token',
      accessToken,
    );
  }
  @override
  removeUserSession() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('pref_access_token');
    prefs.remove(userKey);
  }
}