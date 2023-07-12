import 'package:delivrili/controllers/auth_controller.dart';
import 'package:delivrili/controllers/cart_controller.dart';
import 'package:delivrili/controllers/user_controller.dart';
import 'package:delivrili/routes/routes.dart';
import 'package:delivrili/utils/dimensions.dart';
import 'package:delivrili/utils/theme_colors.dart';
import 'package:delivrili/widgets/reusable_icons.dart';
import 'package:delivrili/widgets/text_font_big.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../widgets/profile_widget.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    bool _userLoggedIn = Get.find<AuthController>().userIsLoggedIn();
    if (_userLoggedIn) {
      Get.find<UserController>().getUserInfo();
    }
    return Scaffold(
        appBar: AppBar(
            title: BigText(text: 'Profile', size: 24, color: Colors.white),
            backgroundColor: AppColors.mainColor,
            centerTitle: true),
        body: GetBuilder<UserController>(
          builder: (userController) {
            return _userLoggedIn
                ? (userController.isLoading
                    ? Container(
                        width: double.maxFinite,
                        margin: EdgeInsets.only(top: Dimensions.height20),
                        child: Column(
                          children: [
                            ReusableIcons(
                              icon: Icons.person,
                              backgroundColor: AppColors.mainColor,
                              iconColor: Colors.white,
                              iconSize: Dimensions.height15 * 5,
                              size: Dimensions.height30 * 5,
                            ),
                            SizedBox(height: Dimensions.height30),
                            Expanded(
                              child: SingleChildScrollView(
                                child: Column(
                                  children: [
                                    ProfileWidget(
                                      icon: ReusableIcons(
                                        icon: Icons.person,
                                        backgroundColor: AppColors.mainColor,
                                        iconColor: Colors.white,
                                        iconSize: Dimensions.height20,
                                        size: Dimensions.height20 * 2,
                                      ),
                                      text: BigText(text: 'Samy'),
                                    ),
                                    SizedBox(height: Dimensions.height30),
                                    ProfileWidget(
                                      icon: ReusableIcons(
                                        icon: Icons.phone,
                                        backgroundColor: AppColors.yellowColor,
                                        iconColor: Colors.white,
                                        iconSize: Dimensions.height20,
                                        size: Dimensions.height20 * 2,
                                      ),
                                      text: BigText(text: '92108304'),
                                    ),
                                    SizedBox(height: Dimensions.height30),
                                    ProfileWidget(
                                      icon: ReusableIcons(
                                        icon: Icons.email,
                                        backgroundColor: AppColors.mainColor,
                                        iconColor: Colors.white,
                                        iconSize: Dimensions.height20,
                                        size: Dimensions.height20 * 2,
                                      ),
                                      text: BigText(
                                          text: 'samy.bejaoui@esprit.tn'),
                                    ),
                                    SizedBox(height: Dimensions.height30),
                                    ProfileWidget(
                                      icon: ReusableIcons(
                                        icon: Icons.location_on,
                                        backgroundColor: AppColors.yellowColor,
                                        iconColor: Colors.white,
                                        iconSize: Dimensions.height20,
                                        size: Dimensions.height20 * 2,
                                      ),
                                      text: BigText(text: 'Address'),
                                    ),
                                    SizedBox(height: Dimensions.height30),
                                    ProfileWidget(
                                      icon: ReusableIcons(
                                        icon: Icons.message_outlined,
                                        backgroundColor: AppColors.mainColor,
                                        iconColor: Colors.white,
                                        iconSize: Dimensions.height20,
                                        size: Dimensions.height20 * 2,
                                      ),
                                      text: BigText(text: 'Messages'),
                                    ),
                                    SizedBox(height: Dimensions.height30),
                                    GestureDetector(
                                      onTap: () {
                                        Get.find<AuthController>()
                                            .clearSharedData();
                                        Get.find<CartController>().clear();
                                        Get.find<CartController>()
                                            .clearCartHistory();
                                        Get.offNamed(Routes.getLogInPage());
                                      },
                                      child: ProfileWidget(
                                        icon: ReusableIcons(
                                          icon: Icons.logout,
                                          backgroundColor: AppColors.mainColor,
                                          iconColor: Colors.white,
                                          iconSize: Dimensions.height20,
                                          size: Dimensions.height20 * 2,
                                        ),
                                        text: BigText(text: 'Logout'),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    : Center(
                        child: Container(
                          height: Dimensions.height20 * 5,
                          width: Dimensions.width20 * 5,
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.circular(Dimensions.radius30)),
                          alignment: Alignment.center,
                          child: CircularProgressIndicator(
                            color: AppColors.mainColor,
                          ),
                        ),
                      ))
                : Container(
                    child: Center(
                      child: Text('You are not logged in.'),
                    ),
                  );
          },
        ));
  }
}