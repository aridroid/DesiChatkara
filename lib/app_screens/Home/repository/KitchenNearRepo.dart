import 'package:desichatkara/app_screens/Home/model/KitchenNearModel.dart';
import 'package:desichatkara/helper/api_base_helper.dart';

class KitchensNearRepository {


  ApiBaseHelper _helper = ApiBaseHelper();

  Future<KitchensNearResponseModel> getAllKitchenNear(String id) async {

    Map body={
      "category_id":"$id"
    };
    final response = await _helper.post("vendors/all",body);
    return KitchensNearResponseModel.fromJson(response);
  }
}