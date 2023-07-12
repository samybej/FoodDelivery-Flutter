import 'package:delivrili/routes/routes.dart';
import 'package:delivrili/user/sign_up_view.dart';
import 'package:delivrili/utils/dimensions.dart';
import 'package:delivrili/utils/theme_colors.dart';
import 'package:delivrili/widgets/reusable_text_field.dart';
import 'package:delivrili/widgets/text_font_big.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/auth_controller.dart';
import '../models/userSignUp.dart';
import '../widgets/custom_snackbar.dart';

class LogInView extends StatelessWidget {
  const LogInView({super.key});

  @override
  Widget build(BuildContext context) {
    final phoneController = TextEditingController();
    final passwordController = TextEditingController();

    void login(AuthController authController) {
      String phone = phoneController.text.trim();
      String password = passwordController.text.trim();

      if (phone.isEmpty) {
        showCustomSnackBar("email address is required");
      } else if (password.isEmpty) {
        showCustomSnackBar("password is required");
      } else if (password.length < 6) {
        showCustomSnackBar("password must include at least 6 characters");
      } else {
        authController.login(phone, password).then((responseModel) {
          if (responseModel.isSuccessful) {
            Get.toNamed(Routes.getCartPage());
          } else {
            showCustomSnackBar(responseModel.message);
          }
        });
      }
    }

    return Scaffold(
        backgroundColor: Colors.white,
        //Wrap the column around SingleChildScrollView to eliminate Overflow issue when the keyboard pops up to type a text
        body: GetBuilder<AuthController>(
          builder: (authController) {
            return authController.isLoading == false
                ? SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(height: Dimensions.height30),
                        Container(
                          height: Dimensions.height45 * 5,
                          color: Colors.white,
                          child: const Center(
                            child: CircleAvatar(
                              backgroundColor: Colors.white,
                              radius: 80,
                              backgroundImage:
                                  AssetImage("assets/image/logo part 1.png"),
                            ),
                          ),
                        ),
                        ReusableTextField(
                          controller: phoneController,
                          hintText: 'phone',
                          icon: Icons.phone,
                        ),
                        SizedBox(height: Dimensions.height20),
                        ReusableTextField(
                          isPasswordField: true,
                          controller: passwordController,
                          hintText: 'password',
                          icon: Icons.password,
                        ),
                        GestureDetector(
                          onTap: () {
                            login(authController);
                          },
                          child: Container(
                            margin: EdgeInsets.only(top: Dimensions.height20),
                            width: Dimensions.screenWidth / 2,
                            height: Dimensions.screenHeight / 15,
                            decoration: BoxDecoration(
                                color: AppColors.mainColor,
                                borderRadius:
                                    BorderRadius.circular(Dimensions.radius30)),
                            child: Center(
                                child: BigText(
                                    text: 'Login', size: Dimensions.font26)),
                          ),
                        ),
                        SizedBox(height: Dimensions.height15),
                        RichText(
                          text: TextSpan(
                              text: "Create a new account",
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: Dimensions.font20),
                              children: [
                                TextSpan(
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      Get.to(() => SignUpView(),
                                          transition: Transition.fade);
                                    },
                                  text: " here",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: Dimensions.font20,
                                      fontWeight: FontWeight.bold),
                                )
                              ]),
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
                  );
          },
        ));
  }
}
