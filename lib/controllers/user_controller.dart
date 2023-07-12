import 'package:delivrili/models/response.dart';
import 'package:delivrili/models/user.dart';
import 'package:delivrili/models/userSignUp.dart';
import 'package:delivrili/repository/auth_repo.dart';
import 'package:get/get.dart';

import '../repository/user_repo.dart';

class UserController extends GetxController implements GetxService {
  final UserRepo userRepo;

  UserController({required this.userRepo});

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  late User _user;
  User get user => _user;

  set setUser(User user) {
    _user = user;
  }

  Future<ResponseModel> getUserInfo() async {
    _isLoading = true;
    update(); //let the UI know that the state of isLoading changed
    Response response = await userRepo.getUserInfo();
    ResponseModel responseModel;
    if (response.statusCode == 200) {
      setUser = User.fromJson(response.body);
      responseModel = ResponseModel(true, "User Info retrieved successfully");
    } else {
      responseModel = ResponseModel(false, response.statusText!);
    }
    _isLoading = false;
    update();
    return responseModel;
  }
}
