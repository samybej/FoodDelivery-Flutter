import 'package:delivrili/pages/address/add_address_page.dart';
import 'package:delivrili/pages/cart/cart_view.dart';
import 'package:delivrili/pages/food/food_detail.dart';
import 'package:delivrili/pages/home/home_page.dart';
import 'package:delivrili/pages/home/splash_screen.dart';
import 'package:delivrili/user/login_view.dart';
import 'package:get/get.dart';

import '../pages/food/recommanded_food_detail.dart';

class Routes {
  static const String homeRoute = "/";
  static const String popularFood = "/popular-food";
  static const String recommandedFood = "/recommanded-food";
  static const String cartPage = "/cart-page";
  static const String splashScreen = "/splash-screen";
  static const String loginPage = "/log-in";
  static const String addAddress = "/add-address";

  static String getSplashScreen() => '$splashScreen';
  static String getHome() => '$homeRoute';
  static String getPopularFood(int index, [String? previousView]) {
    if (previousView == null) {
      return '$popularFood?index=$index';
    }
    return '$popularFood?index=$index&previous=$previousView';
  }

  static String getRecommandedFood(int index, [String? previousView]) {
    if (previousView == null) {
      return '$recommandedFood?index=$index';
    }
    return '$recommandedFood?index=$index&previous=$previousView';
  }

  static String getCartPage() => '$cartPage';

  static String getLogInPage() => '$loginPage';

  static String getAddressPage() => '$addAddress';

  static List<GetPage> routes = [
    GetPage(
        name: splashScreen,
        page: () => const SplashScreen(),
        transition: Transition.fadeIn),
    GetPage(
        name: homeRoute,
        page: () => const HomePage(),
        transition: Transition.fadeIn),
    GetPage(
        name: popularFood,
        page: () {
          var index = Get.parameters['index'];
          var previous = Get.parameters['previous'];
          if (previous == null) {
            return PopularFoodDetailsView(index: int.parse(index!));
          }
          return PopularFoodDetailsView(
              index: int.parse(index!), previous: previous);
        },
        transition: Transition.fadeIn),
    GetPage(
        name: recommandedFood,
        page: () {
          var index = Get.parameters['index'];
          var previous = Get.parameters['previous'];
          if (previous == null) {
            return SelectedFoodDetailsView(index: int.parse(index!));
          }
          return SelectedFoodDetailsView(
              index: int.parse(index!), previous: previous);
        },
        transition: Transition.fadeIn),
    GetPage(
        name: cartPage,
        page: () {
          return CartView();
        },
        transition: Transition.fadeIn),
    GetPage(
        name: loginPage,
        page: () {
          return LogInView();
        },
        transition: Transition.fadeIn),
    GetPage(
        name: addAddress,
        page: () {
          return AddAddressView();
        },
        transition: Transition.fadeIn)
  ];
}
