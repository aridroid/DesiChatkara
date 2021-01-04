import 'package:desichatkara/app_screens/Home/model/ActiveCuponModel.dart';
import 'package:desichatkara/helper/api_base_helper.dart';

class ActiveCuponRepository {


  ApiBaseHelper _helper = ApiBaseHelper();

  Future<ActiveCuponResponseModel> getactiveCupon() async {

    Map body={

    };
    final response = await _helper.post("active/coupon",body);
    return ActiveCuponResponseModel.fromJson(response);
  }
}