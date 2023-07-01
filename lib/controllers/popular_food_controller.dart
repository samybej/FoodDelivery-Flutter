import 'package:delivrili/models/food.dart';
import 'package:delivrili/repository/food_repo.dart';
import 'package:get/get.dart';

class PopularFoodController extends GetxController {
  final FoodRepo foodRepo;

  PopularFoodController({required this.foodRepo});

  List<ProductModel> _popularProductList = [];
  List<ProductModel> get popularProductList => _popularProductList;

  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;

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
}
