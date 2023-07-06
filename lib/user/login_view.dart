import 'package:delivrili/user/sign_up_view.dart';
import 'package:delivrili/utils/dimensions.dart';
import 'package:delivrili/utils/theme_colors.dart';
import 'package:delivrili/widgets/reusable_text_field.dart';
import 'package:delivrili/widgets/text_font_big.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LogInView extends StatelessWidget {
  const LogInView({super.key});

  @override
  Widget build(BuildContext context) {
    final emailController = TextEditingController();
    final passwordController = TextEditingController();

    return Scaffold(
      backgroundColor: Colors.white,
      //Wrap the column around SingleChildScrollView to eliminate Overflow issue when the keyboard pops up to type a text
      body: SingleChildScrollView(
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
                  backgroundImage: AssetImage("assets/image/logo part 1.png"),
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
              controller: passwordController,
              hintText: 'password',
              icon: Icons.password,
            ),
            Container(
              margin: EdgeInsets.only(top: Dimensions.height20),
              width: Dimensions.screenWidth / 2,
              height: Dimensions.screenHeight / 15,
              decoration: BoxDecoration(
                  color: AppColors.mainColor,
                  borderRadius: BorderRadius.circular(Dimensions.radius30)),
              child: Center(
                  child: BigText(text: 'Login', size: Dimensions.font26)),
            ),
            SizedBox(height: Dimensions.height15),
            RichText(
              text: TextSpan(
                  text: "Create a new account",
                  style: TextStyle(
                      color: Colors.grey, fontSize: Dimensions.font20),
                  children: [
                    TextSpan(
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Get.to(() => SignUpView());
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
      ),
    );
  }
}
