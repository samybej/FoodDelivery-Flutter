import 'package:delivrili/service/api_client.dart';
import 'package:delivrili/utils/api_constants.dart';
import 'package:get/get.dart';

class FoodRepo extends GetxService {
  final ApiClient apiClient;

  FoodRepo({required this.apiClient});

  Future<Response> getPopularFoodList() async {
    return await apiClient.getData(AppConstants.POPULAR_PRODUCT_URI);
  }
}
