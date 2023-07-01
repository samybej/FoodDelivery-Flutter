import 'package:delivrili/routes/routes.dart';
import 'package:delivrili/utils/dimensions.dart';
import 'package:delivrili/utils/theme_colors.dart';
import 'package:delivrili/widgets/expandable_text_widget.dart';
import 'package:delivrili/widgets/reusable_icons.dart';
import 'package:delivrili/widgets/text_font_big.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SelectedFoodDetailsView extends StatelessWidget {
  const SelectedFoodDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
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
                      Get.toNamed(Routes.homeRoute);
                    },
                    child: ReusableIcons(icon: Icons.clear)),
                ReusableIcons(icon: Icons.shopping_cart_outlined),
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
                  text: 'China number one',
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
              background: Image.asset(
                "assets/image/food0.png",
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
                  child: ExpandableText(
                      text:
                          "testing the description. For now we are simply using a random text to see how well the expansion functions on the page. If it doesnt, we have some work to do ... don't we ? ...However, let's make the text a little bit longer to test the overflow error, just ... a little .... longer.... let's test again with the new updated long text and see if we get any errors . testing the description. For now we are simply using a random text to see how well the expansion functions on the page. If it doesnt, we have some work to do ... don't we ? ...However, let's make the text a little bit longer to test the overflow error, just ... a little .... longer.... let's test again with the new updated long text and see if we get any errors . testing the description. For now we are simply using a random text to see how well the expansion functions on the page. If it doesnt, we have some work to do ... don't we ? ...However, let's make the text a little bit longer to test the overflow error, just ... a little .... longer.... let's test again with the new updated long text and see if we get any errors ; testing the description. For now we are simply using a random text to see how well the expansion functions on the page. If it doesnt, we have some work to do ... don't we ? ...However, let's make the text a little bit longer to test the overflow error, just ... a little .... longer.... let's test again with the new updated long text and see if we get any errors . testing the description. For now we are simply using a random text to see how well the expansion functions on the page. If it doesnt, we have some work to do ... don't we ? ...However, let's make the text a little bit longer to test the overflow error, just ... a little .... longer.... let's test again with the new updated long text and see if we get any errors . testing the description. For now we are simply using a random text to see how well the expansion functions on the page. If it doesnt, we have some work to do ... don't we ? ...However, let's make the text a little bit longer to test the overflow error, just ... a little .... longer.... let's test again with the new updated long text and see if we get any errors"),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: Column(
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
                ReusableIcons(
                    iconSize: Dimensions.iconSize24,
                    backgroundColor: AppColors.mainColor,
                    iconColor: Colors.white,
                    icon: Icons.remove),
                BigText(
                    text: "\$10 " + "X " + " 0 ",
                    color: AppColors.mainBlackColor,
                    size: Dimensions.font26),
                ReusableIcons(
                    iconSize: Dimensions.iconSize24,
                    backgroundColor: AppColors.mainColor,
                    iconColor: Colors.white,
                    icon: Icons.add),
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
                      borderRadius: BorderRadius.circular(Dimensions.radius20),
                      color: Colors.white,
                    ),
                    child: Icon(
                      Icons.favorite,
                      color: AppColors.mainColor,
                    )),
                Container(
                  padding: EdgeInsets.only(
                      top: Dimensions.height15,
                      bottom: Dimensions.height15,
                      left: Dimensions.width20,
                      right: Dimensions.width20),
                  child:
                      BigText(text: '\$10 | Add To Cart', color: Colors.white),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(Dimensions.radius20),
                    color: AppColors.mainColor,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
