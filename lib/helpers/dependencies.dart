import 'package:delivrili/controllers/auth_controller.dart';
import 'package:delivrili/controllers/cart_controller.dart';
import 'package:delivrili/controllers/location_controller.dart';
import 'package:delivrili/controllers/recommanded_food_controller.dart';
import 'package:delivrili/controllers/user_controller.dart';
import 'package:delivrili/repository/auth_repo.dart';
import 'package:delivrili/repository/cart_repo.dart';
import 'package:delivrili/repository/location_repo.dart';
import 'package:delivrili/repository/recommanded_food_repo.dart';
import 'package:delivrili/repository/user_repo.dart';
import 'package:delivrili/service/api_client.dart';
import 'package:delivrili/utils/api_constants.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../controllers/popular_food_controller.dart';
import '../repository/food_repo.dart';

Future<void> init() async {
  //sharedpreferences enables the ability to store data locally.
  //even if we restart the entire app, the data will remain saved locally !
  final sharedPreferences = await SharedPreferences.getInstance();

  Get.lazyPut(() => sharedPreferences);
  //Initializing the ApiClient
  Get.lazyPut(() => ApiClient(
      appBaseUrl: AppConstants.BASE_URL, sharedPreferences: Get.find()));
  //Initializing the repo
  Get.lazyPut(
      () => AuthRepo(apiClient: Get.find(), sharedPreferences: Get.find()));
  Get.lazyPut(() => UserRepo(
        apiClient: Get.find(),
      ));
  Get.lazyPut(() => FoodRepo(apiClient: Get.find()));
  Get.lazyPut(() => RecommandedFoodRepo(apiClient: Get.find()));
  Get.lazyPut(() => CartRepo(sharedPreferences: Get.find()));
  Get.lazyPut(
      () => LocationRepo(apiClient: Get.find(), sharedPreferences: Get.find()));
  //Controllers
  Get.lazyPut(() => AuthController(authRepo: Get.find()));
  Get.lazyPut(() => UserController(userRepo: Get.find()));
  Get.lazyPut(() => PopularFoodController(foodRepo: Get.find()));
  Get.lazyPut(() => RecommandedFoodController(recommandedFoodRepo: Get.find()));
  Get.lazyPut(() => CartController(cartRepo: Get.find()));
  Get.lazyPut(() => LocationController(locationRepo: Get.find()));
}
