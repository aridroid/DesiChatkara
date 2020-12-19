import 'package:desichatkara/app_screens/UserLogin/model/LoginModel.dart';
import 'package:desichatkara/helper/api_base_helper.dart';

class UserLoginRepository {


  ApiBaseHelper _helper = ApiBaseHelper();

  Future<UserLoginResponseModel> userLogin(body) async {
   
    final response = await _helper.post("login",body);
    return UserLoginResponseModel.fromJson(response);
  }
}