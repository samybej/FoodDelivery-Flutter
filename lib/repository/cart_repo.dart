import 'dart:convert';

import 'package:delivrili/service/api_client.dart';
import 'package:delivrili/utils/api_constants.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/cart.dart';

class CartRepo extends GetxService {
  final SharedPreferences sharedPreferences;

  CartRepo({required this.sharedPreferences});

  List<String> _cart = [];
  List<String> cartHistory = [];

  void addToCartList(List<CartModel> cartList) {
    // sharedPreferences.remove(AppConstants.CART_LIST);
    // sharedPreferences.remove(AppConstants.CART_HISTORY_LIST);
    // return;
    var time = DateTime.now().toString();
    _cart = [];
    cartList.forEach((cart) {
      //we set the exact same time for all the items
      //If we don't each item will have a different time as it's being created
      //in the CartModel
      cart.time = time;
      _cart.add(jsonEncode(cart.toJson()));
    });
    print("length of the cart is : ${_cart.length}");
    //SharedPreferences takes list of Strings not objects
    sharedPreferences.setStringList(AppConstants.CART_LIST, _cart);

    //The list will be saved in our SharedPreferences instance with a name "cart-List"
    print(sharedPreferences.getStringList(AppConstants.CART_LIST));

    // getCartList();
  }

  List<CartModel> getCartList() {
    List<CartModel> cartList = [];
    sharedPreferences.containsKey(AppConstants.CART_LIST)
        ? sharedPreferences
            .getStringList(AppConstants.CART_LIST)!
            .forEach((element) {
            cartList.add(CartModel.fromJson(jsonDecode(element)));
          })
        : cartList;

    return cartList;
  }

  void addToCartHistoryList() {
    for (int i = 0; i < _cart.length; i++) {
      cartHistory.add(_cart[i]);
    }

    sharedPreferences.setStringList(
        AppConstants.CART_HISTORY_LIST, cartHistory);

    sharedPreferences.remove(AppConstants.CART_LIST);

    for (int i = 0; i < getCartHistoryList().length; i++) {
      print("time for item number $i is ${getCartHistoryList()[i].time}");
    }
  }

  List<CartModel> getCartHistoryList() {
    List<CartModel> history = [];

    sharedPreferences.containsKey(AppConstants.CART_HISTORY_LIST)
        ? sharedPreferences
            .getStringList(AppConstants.CART_HISTORY_LIST)!
            .forEach((element) {
            history.add(CartModel.fromJson(jsonDecode(element)));
          })
        : history;

    return history;
  }

  Map<String, int> getCountItemsPerOrderTime() {
    var count = 1;
    var time = getCartHistoryList()[0].time;
    var ordersPerTime = <String, int>{};
    for (int i = 0; i < getCartHistoryList().length; i++) {
      if (getCartHistoryList()[i].time == time) {
        count++;
        ordersPerTime.putIfAbsent(time!, () => count);
        ordersPerTime.update(time, (value) => count);
      } else {
        time = getCartHistoryList()[i].time;
        count = 1;
        ordersPerTime.putIfAbsent(time!, () => count);
        ordersPerTime.update(time, (value) => count);
      }
    }

    var sortedByTime = Map.fromEntries(ordersPerTime.entries.toList()
      ..sort((e1, e2) {
        var parsedDate1 = DateTime.parse(e1.key);
        var parsedDate2 = DateTime.parse(e2.key);

        return parsedDate2.compareTo(parsedDate1);
      }));

    return sortedByTime;
  }
}
