import 'package:delivrili/pages/cart/cart_history_view.dart';
import 'package:delivrili/pages/home/food_page.dart';
import 'package:delivrili/pages/home/food_page_body.dart';
import 'package:delivrili/user/profile_view.dart';
import 'package:delivrili/user/sign_up_view.dart';
import 'package:delivrili/widgets/text_font_big.dart';
import 'package:flutter/material.dart';

class NavigationRoute {
  static final List = [
    FoodPageView(),
    SignUpView(),
    CartHistoryView(),
    ProfileView(),
  ];
}
