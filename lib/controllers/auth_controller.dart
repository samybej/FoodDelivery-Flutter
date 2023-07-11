import 'package:delivrili/models/response.dart';
import 'package:delivrili/models/user.dart';
import 'package:delivrili/repository/auth_repo.dart';
import 'package:get/get.dart';

class AuthController extends GetxController implements GetxService {
  final AuthRepo authRepo;

  AuthController({required this.authRepo});

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<ResponseModel> registration(User user) async {
    _isLoading = true;
    update(); //let the UI know that the state of isLoading changed
    Response response = await authRepo.registration(user);
    ResponseModel responseModel;
    if (response.statusCode == 200) {
      await authRepo.saveUserToken(response.body["token"]);
      responseModel = ResponseModel(true, response.body["token"]);
    } else {
      responseModel = ResponseModel(false, response.statusText!);
    }
    _isLoading = false;
    update();
    return responseModel;
  }

  Future<ResponseModel> login(String email, String password) async {
    _isLoading = true;
    update(); //let the UI know that the state of isLoading changed
    Response response = await authRepo.login(email, password);
    ResponseModel responseModel;
    if (response.statusCode == 200) {
      await authRepo.saveUserToken(response.body["token"]);

      responseModel = ResponseModel(true, response.body["token"]);
    } else {
      responseModel = ResponseModel(false, response.statusText!);
    }
    _isLoading = false;
    update();
    return responseModel;
  }

  void saveUserNumberAndPassword(String number, String password) {
    authRepo.saveUserNumberAndPassword(number, password);
  }

  bool userIsLoggedIn() {
    return authRepo.userIsLoggedIn();
  }

  void clearSharedData() {
    return authRepo.clearSharedData();
  }
}
