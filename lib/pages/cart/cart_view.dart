import 'package:delivrili/utils/api_constants.dart';
import 'package:delivrili/utils/dimensions.dart';
import 'package:delivrili/utils/theme_colors.dart';
import 'package:delivrili/widgets/reusable_icons.dart';
import 'package:delivrili/widgets/text_font_big.dart';
import 'package:delivrili/widgets/text_font_small.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/cart_controller.dart';

class CartView extends StatelessWidget {
  const CartView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //we are using Stack nstead of column because it makes positionning and scrolling easier to work with...
      body: Stack(
        children: [
          Positioned(
              left: Dimensions.width20,
              right: Dimensions.width20,
              top: Dimensions.height30 * 2,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ReusableIcons(
                    icon: Icons.arrow_back,
                    iconColor: Colors.white,
                    backgroundColor: AppColors.mainColor,
                    iconSize: Dimensions.iconSize24,
                  ),
                  ReusableIcons(
                    icon: Icons.home_outlined,
                    iconColor: Colors.white,
                    backgroundColor: AppColors.mainColor,
                    iconSize: Dimensions.iconSize24,
                  ),
                  ReusableIcons(
                    icon: Icons.shopping_cart,
                    iconColor: Colors.white,
                    backgroundColor: AppColors.mainColor,
                    iconSize: Dimensions.iconSize24,
                  )
                ],
              )),
          Positioned(
              top: Dimensions.height20 * 5,
              left: Dimensions.width20,
              right: Dimensions.width20,
              bottom: 0,
              child: Container(
                margin: EdgeInsets.only(top: Dimensions.height15),
                //ListView by default adds a margin on the top. to remove it we need to wrap it around a MediaQuery.removePadding
                child: MediaQuery.removePadding(
                    context: context,
                    removeTop: true,
                    child: GetBuilder<CartController>(
                      builder: (cartController) {
                        return ListView.builder(
                          itemCount: cartController.getItems.length,
                          itemBuilder: (context, index) {
                            return Container(
                              height: 100,
                              width: double.maxFinite,
                              child: Row(
                                children: [
                                  Container(
                                    width: Dimensions.width20 * 5,
                                    height: Dimensions.height20 * 5,
                                    margin: EdgeInsets.only(
                                        bottom: Dimensions.height10),
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            fit: BoxFit.cover,
                                            image: NetworkImage(AppConstants
                                                    .BASE_URL +
                                                AppConstants.UPLOAD_IMG_URL +
                                                cartController
                                                    .getItems[index].img!)),
                                        borderRadius: BorderRadius.circular(
                                            Dimensions.radius20),
                                        color: Colors.white),
                                  ),
                                  SizedBox(width: Dimensions.width10),
                                  //Expanded makes the container take all the available space of the parent container
                                  Expanded(
                                      child: Container(
                                    height: Dimensions.height20 * 5,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        BigText(
                                            text: cartController
                                                .getItems[index].name!,
                                            color: Colors.black54),
                                        SmallText(text: "test"),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            BigText(
                                              text:
                                                  "\$ ${cartController.getItems[index].price}",
                                              color: Colors.red,
                                            ),
                                            Container(
                                              padding: EdgeInsets.only(
                                                  top: Dimensions.height10,
                                                  bottom: Dimensions.height10,
                                                  left: Dimensions.width10,
                                                  right: Dimensions.width10),
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        Dimensions.radius20),
                                                color: Colors.white,
                                              ),
                                              child: Row(
                                                children: [
                                                  GestureDetector(
                                                      onTap: () {
                                                        // popularProduct.setProductQuantity(false);
                                                      },
                                                      child: Icon(Icons.remove,
                                                          color: AppColors
                                                              .signColor)),
                                                  SizedBox(
                                                      width:
                                                          Dimensions.width10 /
                                                              2),
                                                  BigText(text: "s"),
                                                  SizedBox(
                                                      width:
                                                          Dimensions.width10 /
                                                              2),
                                                  GestureDetector(
                                                      onTap: () {
                                                        // popularProduct.setProductQuantity(true);
                                                      },
                                                      child: Icon(Icons.add,
                                                          color: AppColors
                                                              .signColor)),
                                                ],
                                              ),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ))
                                ],
                              ),
                            );
                          },
                        );
                      },
                    )),
              ))
        ],
      ),
    );
  }
}
