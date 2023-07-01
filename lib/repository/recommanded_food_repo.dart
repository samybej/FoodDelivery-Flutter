import 'package:delivrili/service/api_client.dart';
import 'package:delivrili/utils/api_constants.dart';
import 'package:get/get.dart';

class RecommandedFoodRepo extends GetxService {
  final ApiClient apiClient;

  RecommandedFoodRepo({required this.apiClient});

  Future<Response> getRecommandedProductList() async {
    return await apiClient.getData(AppConstants.RECOMMANDED_PRODUCT_URI);
  }
}
