import 'package:delivrili/controllers/auth_controller.dart';
import 'package:delivrili/models/userSignUp.dart';
import 'package:delivrili/utils/dimensions.dart';
import 'package:delivrili/utils/theme_colors.dart';
import 'package:delivrili/widgets/custom_snackbar.dart';
import 'package:delivrili/widgets/reusable_text_field.dart';
import 'package:delivrili/widgets/text_font_big.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpView extends StatelessWidget {
  const SignUpView({super.key});

  @override
  Widget build(BuildContext context) {
    final emailController = TextEditingController();
    final passwordController = TextEditingController();
    final nameController = TextEditingController();
    final phoneController = TextEditingController();
    final signUpImages = ["f.png", "g.png"];

    void _registration(AuthController authController) {
      String name = nameController.text.trim();
      String email = emailController.text.trim();
      String password = passwordController.text.trim();
      String phone = phoneController.text.trim();

      if (name.isEmpty) {
        showCustomSnackBar("name is required");
      } else if (phone.isEmpty) {
        showCustomSnackBar("phone number is required");
      } else if (email.isEmpty) {
        showCustomSnackBar("email address is required");
      } else if (GetUtils.isEmail(email) == false) {
        showCustomSnackBar("Please type a valid email address");
      } else if (password.isEmpty) {
        showCustomSnackBar("password is required");
      } else if (password.length < 6) {
        showCustomSnackBar("password must include at least 6 characters");
      } else {
        UserSignUp user = UserSignUp(
            name: name, phone: phone, email: email, password: password);
        authController.registration(user).then((responseModel) {
          if (responseModel.isSuccessful) {
            print("successfull registration");
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
                        controller: emailController,
                        hintText: 'email',
                        icon: Icons.email,
                      ),
                      SizedBox(height: Dimensions.height20),
                      ReusableTextField(
                        isPasswordField: true,
                        controller: passwordController,
                        hintText: 'password',
                        icon: Icons.password,
                      ),
                      SizedBox(height: Dimensions.height20),
                      ReusableTextField(
                        controller: nameController,
                        hintText: 'name',
                        icon: Icons.person,
                      ),
                      SizedBox(height: Dimensions.height20),
                      ReusableTextField(
                        controller: phoneController,
                        hintText: 'phone',
                        icon: Icons.phone,
                      ),
                      GestureDetector(
                        onTap: () {
                          _registration(authController);
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
                                  text: 'Sign Up', size: Dimensions.font26)),
                        ),
                      ),
                      SizedBox(height: Dimensions.height15),
                      RichText(
                        text: TextSpan(
                          //recognizer is like <a href
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              return Get.back();
                            },
                          text: "Have an account ?",
                          style: TextStyle(
                              color: Colors.grey, fontSize: Dimensions.font20),
                        ),
                      ),
                      SizedBox(height: Dimensions.height10),
                      RichText(
                        text: TextSpan(
                          text: "Sign up using the following methods",
                          style: TextStyle(
                              color: Colors.grey, fontSize: Dimensions.font16),
                        ),
                      ),
                      Wrap(
                        children: List.generate(
                            2,
                            (index) => Padding(
                                  //we wrapped the CircleAvatar around the Padding widget to create seperation
                                  padding: const EdgeInsets.all(8.0),
                                  child: CircleAvatar(
                                    backgroundImage: AssetImage(
                                        "assets/image/${signUpImages[index]}"),
                                  ),
                                )),
                      )
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
      ),
    );
  }
}
