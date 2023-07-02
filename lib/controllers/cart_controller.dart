import 'package:delivrili/models/product.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../models/cart.dart';
import '../repository/cart_repo.dart';
import '../utils/theme_colors.dart';

class CartController extends GetxController {
  final CartRepo cartRepo;

  CartController({required this.cartRepo});

  Map<int, CartModel> _items = {};

  Map<int, CartModel> get items => _items;

  void addItem(ProductModel product, int quantity) {
    var totalQuantity = 0;

    if (_items.containsKey(product.id!)) {
      _items.update(
        product.id!,
        (cartModel) {
          totalQuantity = cartModel.quantity! + quantity;

          return CartModel(
            id: cartModel.id,
            name: cartModel.name,
            price: cartModel.price,
            img: cartModel.img,
            quantity: cartModel.quantity! + quantity,
            Exists: true,
            time: DateTime.now().toString(),
          );
        },
      );
      if (totalQuantity <= 0) {
        _items.remove(product.id);
      }
    } else {
      if (quantity > 0) {
        _items.putIfAbsent(
          product.id!,
          () {
            return CartModel(
              id: product.id,
              name: product.name,
              price: product.price,
              img: product.img,
              quantity: quantity,
              Exists: true,
              time: DateTime.now().toString(),
            );
          },
        );
      } else {
        Get.snackbar(
          "Error",
          "Please select a valid amount of items to add",
          backgroundColor: AppColors.mainColor,
          colorText: Colors.white,
        );
      }
    }
  }

  bool alreadyInCart(ProductModel product) {
    if (_items.containsKey(product.id)) {
      return true;
    }
    return false;
  }

  getQuantity(ProductModel product) {
    // var quantity = 0;
    // if (_items.containsKey(product.id)) {
    //   _items.forEach(
    //     (key, value) {
    //       if (key == product.id) {
    //         quantity = value.quantity!;
    //       }
    //     },
    //   );
    // }

    var quantity = 0;
    if (_items.containsKey(product.id)) {
      var value = _items[product.id];
      quantity = value!.quantity!;
    }

    return quantity;
  }

  int get totalItems {
    var totalQuantity = 0;

    _items.forEach((key, value) {
      totalQuantity += value.quantity!;
    });

    return totalQuantity;
  }
}
