import 'package:delivrili/pages/food/food_detail.dart';
import 'package:get/get.dart';

import '../pages/food/recommanded_food_detail.dart';
import '../pages/home/home_page.dart';

class Routes {
  static const String homeRoute = "/";
  static const String popularFood = "/popular-food";
  static const String recommandedFood = "/recommanded-food";

  static String getHome() => '$homeRoute';
  static String getPopularFood(int index) => '$popularFood?index=$index';
  static String getRecommandedFood(int index) =>
      '$recommandedFood?index=$index';

  static List<GetPage> routes = [
    GetPage(name: "/", page: () => const FoodPageView()),
    GetPage(
        name: popularFood,
        page: () {
          var index = Get.parameters['index'];
          return PopularFoodDetailsView(index: int.parse(index!));
        },
        transition: Transition.fadeIn),
    GetPage(
        name: recommandedFood,
        page: () {
          var index = Get.parameters['index'];
          return SelectedFoodDetailsView(index: int.parse(index!));
        }),
  ];
}
