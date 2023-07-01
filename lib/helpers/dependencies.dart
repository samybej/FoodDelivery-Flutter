import 'package:delivrili/service/api_client.dart';
import 'package:delivrili/utils/api_constants.dart';
import 'package:get/get.dart';

import '../controllers/popular_food_controller.dart';
import '../repository/food_repo.dart';

Future<void> init() async {
  //Initializing the ApiClient
  Get.lazyPut(() => ApiClient(appBaseUrl: AppConstants.BASE_URL));
  //Initializing the repo
  Get.lazyPut(() => FoodRepo(apiClient: Get.find()));
  //Controllers
  Get.lazyPut(() => PopularFoodController(foodRepo: Get.find()));
}
