import 'dart:async';

import 'package:delivrili/routes/routes.dart';
import 'package:delivrili/utils/dimensions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/popular_food_controller.dart';
import '../../controllers/recommanded_food_controller.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController controller;
  Future<void> _loadResources() async {
    await Get.find<PopularFoodController>().getPopularProductList();
    await Get.find<RecommandedFoodController>().getRecommandedProductList();
  }

  @override
  void initState() {
    _loadResources();
    controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 2))
          ..forward();
    animation = CurvedAnimation(parent: controller, curve: Curves.linear);
    Timer(const Duration(seconds: 3), () {
      Get.offNamed(Routes.getHome());
    });
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        ScaleTransition(
            scale: animation,
            child: Center(
                child: Image.asset("assets/image/logo part 1.png",
                    width: Dimensions.splashImage))),
        Center(
            child: Image.asset("assets/image/logo part 2.png",
                width: Dimensions.splashImage)),
      ]),
    );
  }
}
