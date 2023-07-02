import 'package:delivrili/controllers/cart_controller.dart';
import 'package:delivrili/models/cart.dart';
import 'package:delivrili/models/product.dart';
import 'package:delivrili/repository/food_repo.dart';
import 'package:delivrili/utils/theme_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PopularFoodController extends GetxController {
  final FoodRepo foodRepo;

  PopularFoodController({required this.foodRepo});

  List<ProductModel> _popularProductList = [];
  List<ProductModel> get popularProductList => _popularProductList;

  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;

  int _quantity = 0;
  int get quantity => _quantity;

  int _inCartItems = 0;
  int get inCartItems => _inCartItems + _quantity;

  late CartController _cart;

  Future<void> getPopularProductList() async {
    Response response = await foodRepo.getPopularProductList();
    print(response.statusCode);
    if (response.statusCode == 200) {
      _popularProductList = [];
      _popularProductList.addAll(Product.fromJson(response.body).products);
      _isLoaded = true;

      update(); //Let the UI know that the data has been updated
    } else {
      print("error");
    }
  }

  void setProductQuantity(bool isIncremented) {
    if (isIncremented && (_inCartItems + _quantity) >= 0) {
      if ((_inCartItems + _quantity) < 10) {
        _quantity++;
        print("checking addition : $_quantity");
      } else {
        Get.snackbar(
          "Quantity selection",
          "You cannot select more!",
          backgroundColor: AppColors.mainColor,
          colorText: Colors.white,
        );
      }

      update(); //Update the UI
    } else if (!isIncremented && (_inCartItems + _quantity) > 0) {
      _quantity--;
      print("checking substraction : $_quantity");
      update(); //Update the UI
    }
  }

  void initProudct(ProductModel product, CartController cart) {
    _quantity = 0;
    _inCartItems = 0;
    _cart = cart;
    bool inCart = _cart.alreadyInCart(product);
    if (inCart) {
      _inCartItems = _cart.getQuantity(product);
    }
    print("quantity of items in cart : $_inCartItems");
  }

  void addIem(ProductModel product) {
    _cart.addItem(product, _quantity);

    _quantity = 0;
    _inCartItems = _cart.getQuantity(product);

    _cart.items.forEach((key, value) {
      print("The item is ${value.id} and the quantity is ${value.quantity}");
    });

    update();
  }

  int get totalItems {
    return _cart.totalItems;
  }

  List<CartModel> get getItems {
    return _cart.getItems;
  }
}
