import 'package:delivrili/home/home_page_body.dart';
import 'package:delivrili/utils/dimensions.dart';
import 'package:delivrili/utils/theme_colors.dart';
import 'package:delivrili/widgets/text_font_big.dart';
import 'package:delivrili/widgets/text_font_small.dart';
import 'package:flutter/material.dart';

class FoodPageView extends StatefulWidget {
  const FoodPageView({super.key});

  @override
  State<FoodPageView> createState() => _FoodPageViewState();
}

class _FoodPageViewState extends State<FoodPageView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          //The header
          Container(
            margin: EdgeInsets.only(
                top: Dimensions.height45, bottom: Dimensions.height15),
            padding: EdgeInsets.only(
                left: Dimensions.width20, right: Dimensions.width15),
            child: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      BigText(
                        text: 'Tunisia',
                        color: AppColors.mainColor,
                      ),
                      Row(
                        children: [
                          SmallText(
                            text: 'testing',
                            color: AppColors.mainBlackColor,
                          ),
                          const Icon(Icons.arrow_drop_down)
                        ],
                      ),
                    ],
                  ),
                  Center(
                    child: Container(
                      width: Dimensions.width45,
                      height: Dimensions.height45,
                      decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.circular(Dimensions.radius15),
                          color: AppColors.mainColor),
                      child: Icon(
                        Icons.search,
                        color: Colors.white,
                        size: Dimensions.iconSize,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          //The body
          const FoodPageBodyView(),
        ],
      ),
    );
  }
}
