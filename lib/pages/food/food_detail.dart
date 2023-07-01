import 'package:delivrili/routes/routes.dart';
import 'package:delivrili/utils/dimensions.dart';
import 'package:delivrili/widgets/expandable_text_widget.dart';
import 'package:delivrili/widgets/reusable_column.dart';
import 'package:delivrili/widgets/reusable_icons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utils/theme_colors.dart';
import '../../widgets/icon_text_widget.dart';
import '../../widgets/text_font_big.dart';
import '../../widgets/text_font_small.dart';
import '../home/home_page.dart';

class PopularFoodDetailsView extends StatelessWidget {
  const PopularFoodDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          //we used 'Positioned' widget to tell flutter how to Stack the widgets
          //1/Background image
          Positioned(
            left: 0,
            right: 0,
            child: Container(
              width: double.maxFinite,
              height: Dimensions.foodDetailImgSize,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage("assets/image/food0.png"),
              )),
            ),
          ),
          //back and shop icons
          Positioned(
            top: Dimensions.height45,
            left: Dimensions.width20,
            right: Dimensions.width20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    Get.toNamed(Routes.homeRoute);
                  },
                  child: ReusableIcons(icon: Icons.arrow_back_ios),
                ),
                ReusableIcons(icon: Icons.shopping_cart_outlined),
              ],
            ),
          ),
          //the reusable text widget (introduction of the selected food + Description)
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            top: Dimensions.foodDetailImgSize - 20,
            child: Container(
              padding: EdgeInsets.only(
                left: Dimensions.width20,
                right: Dimensions.width20,
                top: Dimensions.height20,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(Dimensions.radius15),
                  topRight: Radius.circular(Dimensions.radius15),
                ),
                color: Colors.white,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const ReusableColumn(text: "china number one"),
                  SizedBox(height: Dimensions.height20),
                  BigText(text: 'Description', size: Dimensions.font20),
                  SizedBox(height: Dimensions.height20),
                  Expanded(
                    child: const SingleChildScrollView(
                      child: ExpandableText(
                          text:
                              "testing the description. For now we are simply using a random text to see how well the expansion functions on the page. If it doesnt, we have some work to do ... don't we ? ...However, let's make the text a little bit longer to test the overflow error, just ... a little .... longer.... let's test again with the new updated long text and see if we get any errors . testing the description. For now we are simply using a random text to see how well the expansion functions on the page. If it doesnt, we have some work to do ... don't we ? ...However, let's make the text a little bit longer to test the overflow error, just ... a little .... longer.... let's test again with the new updated long text and see if we get any errors . testing the description. For now we are simply using a random text to see how well the expansion functions on the page. If it doesnt, we have some work to do ... don't we ? ...However, let's make the text a little bit longer to test the overflow error, just ... a little .... longer.... let's test again with the new updated long text and see if we get any errors"),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        height: Dimensions.bottomNavigationHeight,
        padding: EdgeInsets.only(
            top: Dimensions.height30,
            bottom: Dimensions.height30,
            left: Dimensions.width20,
            right: Dimensions.width20),
        decoration: BoxDecoration(
            color: AppColors.buttonBackgroundColor,
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(Dimensions.radius20 * 2),
              topLeft: Radius.circular(Dimensions.radius20 * 2),
            )),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: EdgeInsets.only(
                  top: Dimensions.height15,
                  bottom: Dimensions.height15,
                  left: Dimensions.width20,
                  right: Dimensions.width20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Dimensions.radius20),
                color: Colors.white,
              ),
              child: Row(
                children: [
                  Icon(Icons.remove, color: AppColors.signColor),
                  SizedBox(width: Dimensions.width10 / 2),
                  BigText(text: '0'),
                  SizedBox(width: Dimensions.width10 / 2),
                  Icon(Icons.add, color: AppColors.signColor),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.only(
                  top: Dimensions.height15,
                  bottom: Dimensions.height15,
                  left: Dimensions.width20,
                  right: Dimensions.width20),
              child: BigText(text: '\$10 | Add To Cart', color: Colors.white),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Dimensions.radius20),
                color: AppColors.mainColor,
              ),
            )
          ],
        ),
      ),
    );
  }
}
