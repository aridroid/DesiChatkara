
import 'package:desichatkara/app_screens/registrationScreen/model/registrationModel.dart';
import 'package:desichatkara/helper/api_base_helper.dart';

class RegistrationRepository {

  ApiBaseHelper _apiBaseHelper = new ApiBaseHelper();

  Future<RegistrationModel> registration(Map _body) async {
    Map body = _body;
    final response= await _apiBaseHelper.post("register", body);
    return RegistrationModel.fromJson(response);
  }

}
