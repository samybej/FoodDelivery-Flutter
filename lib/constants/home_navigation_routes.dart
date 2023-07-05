import 'package:delivrili/pages/cart/cart_history_view.dart';
import 'package:delivrili/pages/home/food_page.dart';
import 'package:delivrili/pages/home/food_page_body.dart';
import 'package:delivrili/widgets/text_font_big.dart';
import 'package:flutter/material.dart';

class NavigationRoute {
  static final List = [
    FoodPageView(),
    Scaffold(
      body: Center(child: Container(child: BigText(text: "NEXT"))),
    ),
    CartHistoryView(),
    Scaffold(
      body: Center(child: Container(child: BigText(text: "NEXT3"))),
    ),
  ];
}
