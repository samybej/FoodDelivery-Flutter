import 'package:get/get.dart';

class Dimensions {
  static double screenWidth = Get.context!.width;
  static double screenHeight = Get.context!.height;

  static double pageView = screenHeight / 2.64;
  static double pageViewContainer = screenHeight / 3.84;
  static double pageViewTextContainer = screenHeight / 7.03;

  //SizedBox height for spacing between text (padding and margin mostly)
  static double height10 = screenHeight / 84.4;
  static double height20 = screenHeight / 42.2;
  static double height15 = screenHeight / 56.27;
  static double height30 = screenHeight / 28.13;
  static double height45 = screenHeight / 18.75;

  //SizedBox width for spacing between text( padding and margin mostly)
  static double width5 = screenHeight / 168.8;
  static double width10 = screenHeight / 84.4;
  static double width20 = screenHeight / 42.2;
  static double width15 = screenHeight / 56.27;
  static double width30 = screenHeight / 28.13;
  static double width45 = screenHeight / 18.75;

//fontsize
  static double font20 = screenHeight / 42.2;
  static double fon12 = screenHeight / 70.33;
  static double font26 = screenHeight / 32.46;
  static double font16 = screenHeight / 52.75;

  static double radius20 = screenHeight / 42.2;
  static double radius30 = screenHeight / 28.13;
  static double radius15 = screenHeight / 56.26;

  //Icon size
  static double iconSize24 = screenHeight / 35.17;
  static double iconSize16 = screenHeight / 52.75;

  //List view size
  static double listViewImgSize = screenWidth / 3.25;
  static double listViewTextContSize = screenWidth / 3.9;

  //food detail dimensions
  static double foodDetailImgSize = screenHeight / 2.41;

  //bottom Navigation height
  static double bottomNavigationHeight = screenHeight / 7.03;

  //splash screen
  static double splashImage = screenHeight / 3.38;
}
