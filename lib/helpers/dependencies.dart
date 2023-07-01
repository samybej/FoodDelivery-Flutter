import 'package:delivrili/controllers/recommanded_food_controller.dart';
import 'package:delivrili/repository/recommanded_food_repo.dart';
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
  Get.lazyPut(() => RecommandedFoodRepo(apiClient: Get.find()));
  //Controllers
  Get.lazyPut(() => PopularFoodController(foodRepo: Get.find()));
  Get.lazyPut(() => RecommandedFoodController(recommandedFoodRepo: Get.find()));
}
