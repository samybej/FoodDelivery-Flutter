import 'package:delivrili/pages/food/food_detail.dart';
import 'package:get/get.dart';

import '../pages/food/recommanded_food_detail.dart';
import '../pages/home/home_page.dart';

class Routes {
  static const String homeRoute = "/";
  static const String popularFood = "/popular-food";
  static const String recommandedFood = "/recommanded-food";

  static List<GetPage> routes = [
    GetPage(name: "/", page: () => const FoodPageView()),
    GetPage(
        name: popularFood,
        page: () => const PopularFoodDetailsView(),
        transition: Transition.fadeIn),
    GetPage(name: recommandedFood, page: () => const SelectedFoodDetailsView()),
  ];
}
