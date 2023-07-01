import 'package:delivrili/models/food.dart';
import 'package:delivrili/repository/recommanded_food_repo.dart';
import 'package:get/get.dart';

class RecommandedFoodController extends GetxController {
  final RecommandedFoodRepo recommandedFoodRepo;

  RecommandedFoodController({required this.recommandedFoodRepo});

  List<ProductModel> _recommandedProductList = [];
  List<ProductModel> get recommandedProductList => _recommandedProductList;

  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;

  Future<void> getRecommandedProductList() async {
    Response response = await recommandedFoodRepo.getRecommandedProductList();
    print(response.statusCode);
    if (response.statusCode == 200) {
      print("got it !");
      _recommandedProductList = [];
      _recommandedProductList.addAll(Product.fromJson(response.body).products);
      _isLoaded = true;

      update(); //Let the UI know that the data has been updated
    } else {
      print("error");
    }
  }
}
