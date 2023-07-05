import 'package:delivrili/controllers/cart_controller.dart';
import 'package:delivrili/models/cart.dart';
import 'package:delivrili/utils/api_constants.dart';
import 'package:delivrili/utils/dimensions.dart';
import 'package:delivrili/utils/theme_colors.dart';
import 'package:delivrili/widgets/reusable_icons.dart';
import 'package:delivrili/widgets/text_font_big.dart';
import 'package:delivrili/widgets/text_font_small.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class CartHistoryView extends StatelessWidget {
  const CartHistoryView({super.key});

  @override
  Widget build(BuildContext context) {
    Map<String, int> countItemsPerOder =
        Get.find<CartController>().getCountItemsPerOrderTime();
    var cartController = Get.find<CartController>();
    var cartHistoryList = Get.find<CartController>().getCartHistoryList();

    print(" keys : ${countItemsPerOder.keys}");
    print(" values : ${countItemsPerOder.values}");

    return Scaffold(
        body: Column(
      children: [
        //first container is similar to the AppBar
        Container(
          width: double.maxFinite,
          height: Dimensions.height20 * 5,
          color: AppColors.mainColor,
          padding: EdgeInsets.only(top: Dimensions.height45),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              BigText(
                text: "Cart History",
                color: Colors.white,
              ),
              ReusableIcons(
                icon: Icons.shopping_cart_outlined,
                backgroundColor: Colors.transparent,
                iconColor: Colors.white,
                iconSize: 30,
              ),
            ],
          ),
        ),
        //second container
        //we use expanded so that this child of the column takes all the available space. Which makes sense for our ListView
        Expanded(
          child: Container(
            margin: EdgeInsets.only(
                top: Dimensions.height20,
                left: Dimensions.width20,
                right: Dimensions.width20),
            child: ListView(children: [
              // for (var time in countItemsPerOder.keys)
              //   Container(
              //     child: ,
              //   )
              for (var time in countItemsPerOder.keys)
                Container(
                  height: Dimensions.height20 * 6,
                  margin: EdgeInsets.only(bottom: Dimensions.height20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      BigText(
                          text: DateFormat("MM/dd/yyyy hh:mm a")
                              .format(DateTime.parse(time))
                              .toString()),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          //In case we have too many items to show in only one line, Wrap allows us to go to the next line
                          Wrap(
                            direction: Axis.horizontal,
                            children: List.generate(
                              cartController
                                  .getCorrespondingItemsPerTime(time)
                                  .length,
                              (index) {
                                return index <= 2
                                    ? Container(
                                        height: Dimensions.height20 * 4,
                                        width: Dimensions.width20 * 4,
                                        decoration: BoxDecoration(
                                            image: DecorationImage(
                                                image: NetworkImage(AppConstants
                                                        .BASE_URL +
                                                    AppConstants
                                                        .UPLOAD_IMG_URL +
                                                    cartController
                                                        .getCorrespondingItemsPerTime(
                                                            time)[index]
                                                        .img!))),
                                      )
                                    : Container();
                              },
                            ),
                          ),
                          Container(
                            height: Dimensions.height20 * 4,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                SmallText(text: "Total"),
                                BigText(
                                  text:
                                      "Items : ${cartController.getCorrespondingItemsPerTime(time).length}",
                                  color: AppColors.titleColor,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    List<CartModel> orderMoreList =
                                        cartController
                                            .getCorrespondingItemsPerTime(time);
                                    Map<int, CartModel> orderMoreMap = {};
                                    for (int j = 0;
                                        j < orderMoreList.length;
                                        j++) {
                                      orderMoreMap.putIfAbsent(
                                          orderMoreList[j].product!.id!, () {
                                        return orderMoreList[j];
                                      });
                                    }
                                    orderMoreMap.forEach((key, value) {
                                      print("key is : $key");
                                      print("value is : ${value.name}");
                                      print("value is : ${value.price}");
                                      print("value is : ${value.quantity}");
                                    });

                                    cartController
                                        .setorderMoreMap(orderMoreMap);
                                  },
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: Dimensions.width10,
                                        vertical: Dimensions.height10 / 2),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(
                                          Dimensions.radius15 / 3),
                                      border: Border.all(
                                          width: 1, color: AppColors.mainColor),
                                    ),
                                    child: SmallText(text: "order more"),
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                )
            ]),
          ),
        )
      ],
    ));
  }
}
