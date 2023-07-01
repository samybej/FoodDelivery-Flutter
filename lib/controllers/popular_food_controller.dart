import 'package:delivrili/models/food.dart';
import 'package:delivrili/repository/food_repo.dart';
import 'package:get/get.dart';

class PopularFoodController extends GetxController {
  final FoodRepo foodRepo;

  PopularFoodController({required this.foodRepo});

  List<dynamic> _popularFoodList = [];
  List<dynamic> get popularProductList => _popularFoodList;

  Future<void> getPopularFoodList() async {
    Response response = await foodRepo.getPopularFoodList();

    if (response.statusCode == 200) {
      _popularFoodList = [];
      _popularFoodList.addAll(Product.fromJson(response.body).products);
      update(); //Let the UI know that the data has been updated
    } else {}
  }
}
