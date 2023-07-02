import 'package:delivrili/controllers/popular_food_controller.dart';
import 'package:delivrili/controllers/recommanded_food_controller.dart';
import 'package:delivrili/routes/routes.dart';
import 'package:delivrili/utils/api_constants.dart';
import 'package:delivrili/utils/dimensions.dart';
import 'package:delivrili/utils/theme_colors.dart';
import 'package:delivrili/widgets/expandable_text_widget.dart';
import 'package:delivrili/widgets/reusable_icons.dart';
import 'package:delivrili/widgets/text_font_big.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/cart_controller.dart';

class SelectedFoodDetailsView extends StatelessWidget {
  final index;
  const SelectedFoodDetailsView({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    var selectedProduct =
        Get.find<RecommandedFoodController>().recommandedProductList[index];
    Get.find<PopularFoodController>()
        .initProudct(selectedProduct, Get.find<CartController>());
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        // slivers are widgets that allow us to do special effects
        slivers: [
          SliverAppBar(
            automaticallyImplyLeading: false,
            toolbarHeight: 60,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                    onTap: () {
                      Get.toNamed(Routes.getHome());
                    },
                    child: ReusableIcons(icon: Icons.clear)),
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
                                child: ReusableIcons(
                                  icon: Icons.circle,
                                  size: 20,
                                  iconColor: Colors.transparent,
                                  backgroundColor: AppColors.mainColor,
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
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(20),
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(Dimensions.radius20),
                      topRight: Radius.circular(Dimensions.radius20),
                    )),
                child: Center(
                    child: BigText(
                  text: selectedProduct.name!,
                  size: Dimensions.font20,
                )),
                width: double.maxFinite,
                padding: EdgeInsets.only(top: 5, bottom: 10),
              ),
            ),
            pinned:
                true, //once you scroll the restricted background image stays restricted at the top ( with a different color/appearance of our choice)
            expandedHeight: 300,
            backgroundColor: AppColors.yellowColor,

            flexibleSpace: FlexibleSpaceBar(
              background: Image.network(
                AppConstants.BASE_URL +
                    AppConstants.UPLOAD_IMG_URL +
                    selectedProduct.img!,
                width: double.maxFinite,
                fit: BoxFit.cover,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(
                      left: Dimensions.width20, right: Dimensions.width20),
                  child: ExpandableText(text: selectedProduct.description!),
                ),
              ],
            ),
          ),
        ],
      ),
      //GetBuilder is used to create an instance of a controller so that we can use it/its methods/attributes
      bottomNavigationBar: GetBuilder<PopularFoodController>(
        //init: MyController(),
        //initState: (_) {},
        builder: (popularProduct) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: EdgeInsets.only(
                    left: Dimensions.width20 * 2.5,
                    right: Dimensions.width20 * 2.5,
                    top: Dimensions.height10,
                    bottom: Dimensions.height10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        popularProduct.setProductQuantity(false);
                      },
                      child: ReusableIcons(
                          iconSize: Dimensions.iconSize24,
                          backgroundColor: AppColors.mainColor,
                          iconColor: Colors.white,
                          icon: Icons.remove),
                    ),
                    BigText(
                        text:
                            "\$ ${selectedProduct.price} X  ${popularProduct.inCartItems} ",
                        color: AppColors.mainBlackColor,
                        size: Dimensions.font26),
                    GestureDetector(
                      onTap: () {
                        popularProduct.setProductQuantity(true);
                      },
                      child: ReusableIcons(
                          iconSize: Dimensions.iconSize24,
                          backgroundColor: AppColors.mainColor,
                          iconColor: Colors.white,
                          icon: Icons.add),
                    ),
                  ],
                ),
              ),
              Container(
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
                          borderRadius:
                              BorderRadius.circular(Dimensions.radius20),
                          color: Colors.white,
                        ),
                        child: Icon(
                          Icons.favorite,
                          color: AppColors.mainColor,
                        )),
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
                          borderRadius:
                              BorderRadius.circular(Dimensions.radius20),
                          color: AppColors.mainColor,
                        ),
                        child: BigText(
                            text:
                                '\$ ${selectedProduct.price! * popularProduct.inCartItems} | Add To Cart',
                            color: Colors.white),
                      ),
                    )
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
