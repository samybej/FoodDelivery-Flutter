import 'package:delivrili/service/api_client.dart';
import 'package:get/get.dart';

class FoodRepo extends GetxService {
  final ApiClient apiClient;

  FoodRepo({required this.apiClient});

  Future<Response> getPopularFoodList() async {
    return await apiClient.getData("/api/v1/products/popular");
  }
}
