import 'package:desichatkara/app_screens/KitchenByCategory/model/KitchenByCategoryModel.dart';
import 'package:desichatkara/helper/api_base_helper.dart';

class KitchenByCategoryRepository {


  ApiBaseHelper _helper = ApiBaseHelper();

  Future<KitchenByCategoryResponseModel> getKitchenByCategory(String categoryid) async {

    Map body={
      "categoryid":categoryid.toString()
    };
    final response = await _helper.post("productbycategoryid",body);
    return KitchenByCategoryResponseModel.fromJson(response);
  }
}