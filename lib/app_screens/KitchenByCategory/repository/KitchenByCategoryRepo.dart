import 'package:desichatkara/app_screens/KitchenByCategory/model/KitchenByCategoryModel.dart';
import 'package:desichatkara/helper/api_base_helper.dart';

class KitchenByCategoryRepository {


  ApiBaseHelper _helper = ApiBaseHelper();

  Future<KitchenByCategoryResponseModel> getKitchenByCategory(String cid) async {

    Map body={
      "categoryid":cid
    };
    final response = await _helper.post("productbycategoryid",body);
    return KitchenByCategoryResponseModel.fromJson(response);
  }
}