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

//to store in shared pereferences
  List<CartModel> storageCartItems = [];

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
            product: product,
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
              product: product,
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
    cartRepo.addToCartList(getItems);
    update(); //update the UI
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

  int get totalCartPrice {
    var totalPrice = 0;

    _items.forEach((key, value) {
      totalPrice += value.quantity! * value.price!;
    });

    return totalPrice;
  }

  List<CartModel> get getItems {
    return _items.entries.map((cart) => cart.value).toList();
  }

  List<CartModel> getCartLocalStorage() {
    setCart = cartRepo.getCartList();
    return storageCartItems;
  }

  void set setCart(List<CartModel> cartList) {
    storageCartItems = cartList;

    //this is not going to conflict with what we did in the addItem() method
    //because that method checks if the item exists or not!if it does exist
    //it only updates.
    //Besides the getCartLocalStorage() method which calls the set method
    //only gets called once(when the app starts)
    //It's going to call the getCartList from the repo which then calls the
    //shared preferences to get the local data...
    //The method gets called in the main.dart build function !
    for (int i = 0; i < storageCartItems.length; i++) {
      _items.putIfAbsent(
          storageCartItems[i].product!.id!, () => storageCartItems[i]);
    }
  }

  void addToCartHistoryList() {
    cartRepo.addToCartHistoryList();
    clear();
  }

  void clear() {
    _items = {};
    update();
  }

  List<CartModel> getCartHistoryList() {
    return cartRepo.getCartHistoryList();
  }

  Map<String, int> getCountItemsPerOrderTime() {
    return cartRepo.getCountItemsPerOrderTime();
  }

  List<CartModel> getCorrespondingItemsPerTime(String? time) {
    var correspondingList = <CartModel>[];
    for (int i = 0; i < getCartHistoryList().length; i++) {
      if (time == getCartHistoryList()[i].time) {
        correspondingList.add(getCartHistoryList()[i]);
      }
    }

    return correspondingList;
  }
}
