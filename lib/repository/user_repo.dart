import 'package:delivrili/service/api_client.dart';
import 'package:delivrili/utils/api_constants.dart';
import 'package:get/get.dart';

class UserRepo {
  final ApiClient apiClient;
  UserRepo({required this.apiClient});

  Future<Response> getUserInfo() async {
    return await apiClient.getData(AppConstants.USER_INFO);
  }
}
