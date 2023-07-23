import 'package:delivrili/models/response.dart';
import 'package:delivrili/models/user.dart';
import 'package:delivrili/models/userSignUp.dart';
import 'package:delivrili/repository/auth_repo.dart';
import 'package:get/get.dart';

import '../repository/user_repo.dart';

class UserController extends GetxController implements GetxService {
  final UserRepo userRepo;

  UserController({required this.userRepo});

  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;

  late User? _user;
  User? get user => _user;

  set setUser(User user) {
    _user = user;
  }

  Future<ResponseModel> getUserInfo() async {
    Response response = await userRepo.getUserInfo();
    ResponseModel responseModel;
    if (response.statusCode == 200) {
      setUser = User.fromJson(response.body);
      _isLoaded = true;

      update(); //let the UI know that the state of isLoading changed
      responseModel = ResponseModel(true, "User Info retrieved successfully");
    } else {
      print("info failed to retrieve");
      responseModel = ResponseModel(false, response.statusText!);
    }
    update();
    return responseModel;
  }
}
