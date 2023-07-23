import 'package:delivrili/service/api_client.dart';
import 'package:delivrili/utils/api_constants.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/userSignUp.dart';

class AuthRepo {
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;

  const AuthRepo({required this.apiClient, required this.sharedPreferences});

  Future<Response> registration(UserSignUp user) async {
    return await apiClient.postData(
        AppConstants.REGISTRATION_URI, user.toJson());
  }

  bool userIsLoggedIn() {
    return sharedPreferences.containsKey(AppConstants.TOKEN);
  }

  String getUserToken() {
    return sharedPreferences.getString(AppConstants.TOKEN) ?? "None";
  }

  Future<Response> login(String phone, String password) async {
    return await apiClient.postData(
        AppConstants.LOGIN_URI, {"phone": phone, "password": password});
  }

  Future<bool> saveUserToken(String token) async {
    apiClient.token = token;
    apiClient.updateHeaders(token);
    return await sharedPreferences.setString(AppConstants.TOKEN, token);
  }

  Future<void> saveUserNumberAndPassword(String number, String password) async {
    try {
      await sharedPreferences.setString(AppConstants.PHONE, number);
      await sharedPreferences.setString(AppConstants.PASSWORD, password);
    } catch (e) {}
  }

  void clearSharedData() async {
    await sharedPreferences.remove(AppConstants.TOKEN);
    await sharedPreferences.remove(AppConstants.PASSWORD);
    await sharedPreferences.remove(AppConstants.PHONE);

    apiClient.token = "";
    apiClient.updateHeaders("");
  }

  String getToken() {
    return apiClient.token;
  }
}
