import 'package:delivrili/utils/dimensions.dart';
import 'package:delivrili/utils/theme_colors.dart';
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
            Container(
              margin: EdgeInsets.only(top: Dimensions.height20),
              width: Dimensions.screenWidth / 2,
              height: Dimensions.screenHeight / 15,
              decoration: BoxDecoration(
                  color: AppColors.mainColor,
                  borderRadius: BorderRadius.circular(Dimensions.radius30)),
              child: Center(
                  child: BigText(text: 'Sign Up', size: Dimensions.font26)),
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
                style:
                    TextStyle(color: Colors.grey, fontSize: Dimensions.font20),
              ),
            ),
            SizedBox(height: Dimensions.height10),
            RichText(
              text: TextSpan(
                text: "Sign up using the following methods",
                style:
                    TextStyle(color: Colors.grey, fontSize: Dimensions.font16),
              ),
            ),
            Wrap(
              children: List.generate(
                  2,
                  (index) => Padding(
                        //we wrapped the CircleAvatar around the Padding widget to create seperation
                        padding: const EdgeInsets.all(8.0),
                        child: CircleAvatar(
                          backgroundImage:
                              AssetImage("assets/image/${signUpImages[index]}"),
                        ),
                      )),
            )
          ],
        ),
      ),
    );
  }
}
