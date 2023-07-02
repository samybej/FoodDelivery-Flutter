import 'package:delivrili/controllers/cart_controller.dart';
import 'package:delivrili/controllers/popular_food_controller.dart';
import 'package:delivrili/pages/cart/cart_view.dart';
import 'package:delivrili/routes/routes.dart';
import 'package:delivrili/utils/api_constants.dart';
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
  final index;
  const PopularFoodDetailsView({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    //get the instance from the list based on the index
    var selectedProduct =
        Get.find<PopularFoodController>().popularProductList[index];
    Get.find<PopularFoodController>()
        .initProudct(selectedProduct, Get.find<CartController>());

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
              decoration: BoxDecoration(
                  image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(
                  AppConstants.BASE_URL +
                      AppConstants.UPLOAD_IMG_URL +
                      selectedProduct.img!,
                ),
              )),
            ),
          ),
          //back and shop icons
          GetBuilder<PopularFoodController>(
            // init: PopularFoodController(),
            //initState: (_) {},
            builder: (popularProduct) {
              return Positioned(
                top: Dimensions.height45,
                left: Dimensions.width20,
                right: Dimensions.width20,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Get.toNamed(Routes.getHome());
                      },
                      child: ReusableIcons(icon: Icons.arrow_back_ios),
                    ),
                    GetBuilder<PopularFoodController>(
                      // init: MyController(),
                      // initState: (_) {},
                      builder: (_) {
                        return Stack(
                          children: [
                            ReusableIcons(icon: Icons.shopping_cart_outlined),
                            Get.find<PopularFoodController>().totalItems > 0
                                ? Positioned(
                                    right: 0,
                                    top: 0,
                                    child: GestureDetector(
                                      onTap: () {
                                        Get.to(() => CartView());
                                      },
                                      child: ReusableIcons(
                                        icon: Icons.circle,
                                        size: 20,
                                        iconColor: Colors.transparent,
                                        backgroundColor: AppColors.mainColor,
                                      ),
                                    ),
                                  )
                                : Container(),
                            Get.find<PopularFoodController>().totalItems > 0
                                ? Positioned(
                                    right: 3,
                                    top: 3,
                                    child: BigText(
                                      text: Get.find<PopularFoodController>()
                                          .totalItems
                                          .toString(),
                                      size: 12,
                                      color: Colors.white,
                                    ))
                                : Container(),
                          ],
                        );
                      },
                    ),
                  ],
                ),
              );
            },
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
                  ReusableColumn(text: selectedProduct.name!),
                  SizedBox(height: Dimensions.height20),
                  BigText(text: 'Description', size: Dimensions.font20),
                  SizedBox(height: Dimensions.height20),
                  Expanded(
                    child: SingleChildScrollView(
                      child: ExpandableText(text: selectedProduct.description!),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: GetBuilder<PopularFoodController>(
        // init: MyController(),
        //initState: (_) {},
        builder: (popularProduct) {
          return Container(
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
                      GestureDetector(
                          onTap: () {
                            popularProduct.setProductQuantity(false);
                          },
                          child:
                              Icon(Icons.remove, color: AppColors.signColor)),
                      SizedBox(width: Dimensions.width10 / 2),
                      BigText(text: popularProduct.inCartItems.toString()),
                      SizedBox(width: Dimensions.width10 / 2),
                      GestureDetector(
                          onTap: () {
                            popularProduct.setProductQuantity(true);
                          },
                          child: Icon(Icons.add, color: AppColors.signColor)),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    popularProduct.addIem(selectedProduct);
                  },
                  child: Container(
                    padding: EdgeInsets.only(
                        top: Dimensions.height15,
                        bottom: Dimensions.height15,
                        left: Dimensions.width20,
                        right: Dimensions.width20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(Dimensions.radius20),
                      color: AppColors.mainColor,
                    ),
                    child: BigText(
                        text: "\$ ${selectedProduct.price} | Add To Cart",
                        color: Colors.white),
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
