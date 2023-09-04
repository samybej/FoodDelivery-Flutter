import 'package:delivrili/controllers/cart_controller.dart';
import 'package:delivrili/controllers/popular_food_controller.dart';
import 'package:delivrili/controllers/recommanded_food_controller.dart';

import 'package:delivrili/pages/home/food_page.dart';
import 'package:delivrili/pages/home/splash_screen.dart';

import 'package:delivrili/routes/routes.dart';
import 'package:delivrili/user/login_view.dart';
import 'package:delivrili/user/sign_up_view.dart';
import 'package:delivrili/utils/theme_colors.dart';
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
    //GetMaterialApp instead of MaterialApp to get the context when the app is initialized so that we can use it for our Dimensions class
    Get.find<CartController>().getCartLocalStorage();
    return GetBuilder<PopularFoodController>(
      builder: (_) {
        return GetBuilder<RecommandedFoodController>(
          builder: (_) {
            return GetMaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Flutter Demo',
              initialRoute: Routes.getSplashScreen(),
              getPages: Routes.routes,
              theme: ThemeData(
                  primaryColor: AppColors.mainColor, fontFamily: "Lato"),
              // home: LogInView(),
            );
          },
        );
      },
    );
  }
}
