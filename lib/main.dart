import 'package:delivrili/controllers/popular_food_controller.dart';
import 'package:delivrili/controllers/recommanded_food_controller.dart';
import 'package:delivrili/pages/cart/cart_view.dart';
import 'package:delivrili/pages/food/food_detail.dart';
import 'package:delivrili/pages/food/recommanded_food_detail.dart';
import 'package:delivrili/pages/home/home_page.dart';
import 'package:delivrili/pages/home/home_page_body.dart';
import 'package:delivrili/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'helpers/dependencies.dart' as dep;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dep.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Get.find<PopularFoodController>().getPopularProductList();
    Get.find<RecommandedFoodController>().getRecommandedProductList();

    //GetMaterialApp instead of MaterialApp to get the context when the app is initialized so that we can use it for our Dimensions class
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      initialRoute: Routes.getHome(),
      getPages: Routes.routes,
      home: FoodPageView(),
    );
  }
}
