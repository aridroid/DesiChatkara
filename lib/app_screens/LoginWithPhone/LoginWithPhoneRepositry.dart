import 'package:desichatkara/helper/api_base_helper.dart';

import 'LoginWithPhoneModel.dart';

class LoginPhoneRepository {


  ApiBaseHelper _helper = ApiBaseHelper();

  Future<LoginWithPhoneModel> userLogin(body) async {

    final response = await _helper.post("user/login",body);
    return LoginWithPhoneModel.fromJson(response);
  }
}