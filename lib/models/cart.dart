import 'package:delivrili/models/product.dart';

class CartModel {
  int? id;
  String? name;
  int? price;
  String? img;
  int? quantity;
  bool? Exists;
  String? time;
  ProductModel? product;

  CartModel({
    this.id,
    this.name,
    this.price,
    this.img,
    this.quantity,
    this.Exists,
    this.time,
    this.product,
  });

  CartModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    price = json['price'];
    img = json['img'];
    quantity = json['quantity'];
    Exists = json['isExist'];
    time = json['time'];
    product = ProductModel.fromJson(json['product']);
  }

//to be able to save the list of carts to shared preferences, we need the following function to convert to json
  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "price": price,
      "img": img,
      "quantity": quantity,
      "isExist": Exists,
      "time": time,
      "product": product!.toJson(),
    };
  }
}
